import threading
import time
import tkinter as tk
from tkinter import ttk, messagebox
import serial
import serial.tools.list_ports

GRID_SIZE = 28
CELL_PX = 14  # 28 * 14 = 392x392 drawing canvas
SEND_INTERVAL_SEC = 0.08  # Throttle UART TX while dragging (~12.5 Hz)


class MNISTUartApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("MNIST UART Tester")
        self.root.resizable(False, False)

        # 28x28 grid stored in row-major order as 8-bit unsigned values (0-255)
        self.grid = bytearray(GRID_SIZE * GRID_SIZE)
        self.bar_values = [0] * 10

        # Serial state
        self.ser = None
        self.rx_thread = None
        self.running = False
        self.dirty = False
        self.last_send_time = 0.0
        self.tx_lock = threading.Lock()

        self._build_ui()
        self._refresh_ports()
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)

    # ------------------------------------------------------------------
    # UI Construction
    # ------------------------------------------------------------------
    def _build_ui(self):
        # Top bar: Serial connection controls
        top = ttk.Frame(self.root, padding=8)
        top.pack(fill="x")

        ttk.Label(top, text="Port:").pack(side="left")
        self.port_var = tk.StringVar()
        self.port_combo = ttk.Combobox(
            top, textvariable=self.port_var, width=14, state="readonly"
        )
        self.port_combo.pack(side="left", padx=(4, 4))

        ttk.Button(top, text="Refresh", command=self._refresh_ports).pack(
            side="left", padx=(0, 10)
        )

        ttk.Label(top, text="Baud:").pack(side="left")
        self.baud_var = tk.StringVar(value="115200")
        baud_combo = ttk.Combobox(
            top,
            textvariable=self.baud_var,
            values=["9600", "57600", "115200", "230400", "460800", "921600"],
            width=8,
            state="readonly",
        )
        baud_combo.pack(side="left", padx=(4, 10))

        self.connect_btn = ttk.Button(
            top, text="Connect", command=self._toggle_connection
        )
        self.connect_btn.pack(side="left")

        self.status_var = tk.StringVar(value="Disconnected")
        ttk.Label(top, textvariable=self.status_var, foreground="gray").pack(
            side="right"
        )

        ttk.Separator(self.root, orient="horizontal").pack(fill="x")

        # Main side-by-side workspace
        main = ttk.Frame(self.root, padding=12)
        main.pack(fill="both", expand=True)

        # --- Left Side: 28x28 Paint Grid ---
        left = ttk.Frame(main)
        left.pack(side="left", padx=(0, 16))

        ttk.Label(
            left,
            text="28×28 Input (Left-click: Paint, Right-click: Erase)",
            font=("Segoe UI", 10, "bold"),
        ).pack(anchor="w", pady=(0, 6))

        canvas_dim = GRID_SIZE * CELL_PX
        self.paint_canvas = tk.Canvas(
            left,
            width=canvas_dim,
            height=canvas_dim,
            bg="black",
            highlightthickness=1,
            highlightbackground="#555",
        )
        self.paint_canvas.pack()

        # Pre-create all 784 cell rectangles for fast updates
        self.cell_ids = [[0] * GRID_SIZE for _ in range(GRID_SIZE)]
        for r in range(GRID_SIZE):
            for c in range(GRID_SIZE):
                x0, y0 = c * CELL_PX, r * CELL_PX
                self.cell_ids[r][c] = self.paint_canvas.create_rectangle(
                    x0,
                    y0,
                    x0 + CELL_PX,
                    y0 + CELL_PX,
                    fill="#000000",
                    outline="#1a1a1a",
                )

        # Mouse bindings for painting and erasing
        self.paint_canvas.bind(
            "<Button-1>", lambda e: self._paint_event(e, erase=False)
        )
        self.paint_canvas.bind(
            "<B1-Motion>", lambda e: self._paint_event(e, erase=False)
        )
        self.paint_canvas.bind("<ButtonRelease-1>", self._on_stroke_end)

        self.paint_canvas.bind("<Button-3>", lambda e: self._paint_event(e, erase=True))
        self.paint_canvas.bind(
            "<B3-Motion>", lambda e: self._paint_event(e, erase=True)
        )
        self.paint_canvas.bind("<ButtonRelease-3>", self._on_stroke_end)

        # Controls under the paint canvas
        controls = ttk.Frame(left)
        controls.pack(fill="x", pady=(8, 0))

        ttk.Button(controls, text="Reset", command=self.reset_grid).pack(side="left")

        self.soft_brush_var = tk.BooleanVar(value=True)
        ttk.Checkbutton(
            controls, text="Soft Brush (MNIST-style)", variable=self.soft_brush_var
        ).pack(side="right")

        # --- Right Side: 10-Value Bar Graph ---
        right = ttk.Frame(main)
        right.pack(side="left", fill="both")

        ttk.Label(
            right, text="UART Output (0–255 per Digit)", font=("Segoe UI", 10, "bold")
        ).pack(anchor="w", pady=(0, 6))

        self.bar_width = 420
        self.bar_height = canvas_dim
        self.bar_canvas = tk.Canvas(
            right,
            width=self.bar_width,
            height=self.bar_height,
            bg="#ffffff",
            highlightthickness=1,
            highlightbackground="#555",
        )
        self.bar_canvas.pack()

        self._init_bar_graph()

        self.pred_var = tk.StringVar(value="Prediction: —")
        ttk.Label(
            right, textvariable=self.pred_var, font=("Segoe UI", 11, "bold")
        ).pack(pady=(8, 0))

    def _init_bar_graph(self):
        self.margin_left = 36
        self.margin_right = 16
        self.margin_top = 28
        self.margin_bottom = 32
        self.plot_h = self.bar_height - self.margin_top - self.margin_bottom
        plot_w = self.bar_width - self.margin_left - self.margin_right
        slot_w = plot_w / 10
        bar_pad = 6

        # Horizontal reference gridlines (0, 64, 128, 192, 255)
        for val in (0, 64, 128, 192, 255):
            y = self.margin_top + self.plot_h * (1 - val / 255.0)
            self.bar_canvas.create_line(
                self.margin_left,
                y,
                self.bar_width - self.margin_right,
                y,
                fill="#e5e5e5",
            )
            self.bar_canvas.create_text(
                self.margin_left - 6,
                y,
                text=str(val),
                anchor="e",
                font=("Segoe UI", 8),
                fill="#666",
            )

        # Create 10 bars, value labels, and index labels (0-9)
        self.bar_rects = []
        self.bar_val_texts = []
        self.bar_x_bounds = []
        base_y = self.margin_top + self.plot_h

        for i in range(10):
            x0 = self.margin_left + i * slot_w + bar_pad / 2
            x1 = self.margin_left + (i + 1) * slot_w - bar_pad / 2
            cx = (x0 + x1) / 2
            self.bar_x_bounds.append((x0, x1, cx))

            rect = self.bar_canvas.create_rectangle(
                x0, base_y, x1, base_y, fill="#4a90e2", outline=""
            )
            val_txt = self.bar_canvas.create_text(
                cx, base_y - 8, text="0", font=("Segoe UI", 8), fill="#333"
            )
            self.bar_canvas.create_text(
                cx, base_y + 16, text=str(i), font=("Segoe UI", 10, "bold"), fill="#222"
            )

            self.bar_rects.append(rect)
            self.bar_val_texts.append(val_txt)

    # ------------------------------------------------------------------
    # Painting Logic
    # ------------------------------------------------------------------
    def _paint_event(self, event, erase: bool):
        col = event.x // CELL_PX
        row = event.y // CELL_PX
        if not (0 <= row < GRID_SIZE and 0 <= col < GRID_SIZE):
            return

        changed = False
        if erase:
            # Erase 3x3 area for convenience
            for dr in (-1, 0, 1):
                for dc in (-1, 0, 1):
                    r, c = row + dr, col + dc
                    if 0 <= r < GRID_SIZE and 0 <= c < GRID_SIZE:
                        changed |= self._set_cell(r, c, 0)
        elif self.soft_brush_var.get():
            # Soft 3x3 MNIST-like brush: center = 255, cardinal neighbors += 110, diagonals += 55
            kernel = [
                (0, 0, 255),
                (-1, 0, 110),
                (1, 0, 110),
                (0, -1, 110),
                (0, 1, 110),
                (-1, -1, 55),
                (-1, 1, 55),
                (1, -1, 55),
                (1, 1, 55),
            ]
            for dr, dc, delta in kernel:
                r, c = row + dr, col + dc
                if 0 <= r < GRID_SIZE and 0 <= c < GRID_SIZE:
                    idx = r * GRID_SIZE + c
                    new_val = min(255, self.grid[idx] + delta)
                    changed |= self._set_cell(r, c, new_val)
        else:
            changed |= self._set_cell(row, col, 255)

        if changed:
            self.dirty = True
            self._maybe_send_grid()

    def _set_cell(self, row: int, col: int, value: int) -> bool:
        idx = row * GRID_SIZE + col
        if self.grid[idx] == value:
            return False
        self.grid[idx] = value
        hex_color = f"#{value:02x}{value:02x}{value:02x}"
        self.paint_canvas.itemconfig(self.cell_ids[row][col], fill=hex_color)
        return True

    def _on_stroke_end(self, _event):
        # Ensure the final state of a drag stroke is always transmitted
        if self.dirty:
            self._send_grid_now()

    def reset_grid(self):
        for r in range(GRID_SIZE):
            for c in range(GRID_SIZE):
                self._set_cell(r, c, 0)
        self.dirty = True
        self._send_grid_now()

    # ------------------------------------------------------------------
    # Bar Graph Updates
    # ------------------------------------------------------------------
    def update_bars(self, values: list[int]):
        self.bar_values = values
        base_y = self.margin_top + self.plot_h
        max_val = max(values)
        max_idx = values.index(max_val)

        for i, val in enumerate(values):
            x0, x1, cx = self.bar_x_bounds[i]
            top_y = base_y - (val / 255.0) * self.plot_h
            color = "#2ecc71" if (i == max_idx and max_val > 0) else "#4a90e2"

            self.bar_canvas.coords(self.bar_rects[i], x0, top_y, x1, base_y)
            self.bar_canvas.itemconfig(self.bar_rects[i], fill=color)
            self.bar_canvas.coords(self.bar_val_texts[i], cx, top_y - 8)
            self.bar_canvas.itemconfig(self.bar_val_texts[i], text=str(val))

        self.pred_var.set(
            f"Prediction: {max_idx} ({max_val}/255)" if max_val > 0 else "Prediction: —"
        )

    # ------------------------------------------------------------------
    # UART Communication
    # ------------------------------------------------------------------
    def _refresh_ports(self):
        ports = [p.device for p in serial.tools.list_ports.comports()]
        self.port_combo["values"] = ports
        if ports and self.port_var.get() not in ports:
            self.port_var.set(ports[0])

    def _toggle_connection(self):
        if self.ser and self.ser.is_open:
            self._disconnect()
        else:
            self._connect()

    def _connect(self):
        port = self.port_var.get()
        if not port:
            messagebox.showwarning("No Port", "Select a serial port first.")
            return
        try:
            baud = int(self.baud_var.get())
            self.ser = serial.Serial(port, baudrate=baud, timeout=0.1)
            self.ser.reset_input_buffer()
            self.ser.reset_output_buffer()
        except serial.SerialException as exc:
            messagebox.showerror("Connection Error", str(exc))
            return

        self.running = True
        self.rx_thread = threading.Thread(target=self._rx_loop, daemon=True)
        self.rx_thread.start()

        self.connect_btn.config(text="Disconnect")
        self.status_var.set(f"Connected: {port} @ {baud}")

    def _disconnect(self):
        self.running = False
        if self.ser:
            try:
                self.ser.close()
            except serial.SerialException:
                pass
            self.ser = None
        self.connect_btn.config(text="Connect")
        self.status_var.set("Disconnected")

    def _maybe_send_grid(self):
        now = time.monotonic()
        if now - self.last_send_time >= SEND_INTERVAL_SEC:
            self._send_grid_now()

    def _send_grid_now(self):
        self.dirty = False
        self.last_send_time = time.monotonic()
        if not (self.ser and self.ser.is_open):
            return

        # Copy buffer and transmit in a short thread so GUI never stalls
        payload = bytes(self.grid)  # 784 bytes in row-major order
        threading.Thread(target=self._tx_bytes, args=(payload,), daemon=True).start()

    def _tx_bytes(self, payload: bytes):
        with self.tx_lock:
            if not (self.ser and self.ser.is_open):
                return
            try:
                self.ser.write(payload)
            except serial.SerialException:
                self.root.after(0, self._disconnect)

    def _rx_loop(self):
        rx_buf = bytearray()
        while self.running and self.ser and self.ser.is_open:
            try:
                chunk = self.ser.read(10 - len(rx_buf))
                if not chunk:
                    continue
                rx_buf.extend(chunk)
                if len(rx_buf) == 10:
                    values = list(rx_buf)
                    rx_buf.clear()
                    # Safely schedule UI update on the main Tkinter thread
                    self.root.after(0, self.update_bars, values)
            except serial.SerialException:
                self.root.after(0, self._disconnect)
                break

    def _on_close(self):
        self._disconnect()
        self.root.destroy()


if __name__ == "__main__":
    root = tk.Tk()
    app = MNISTUartApp(root)
    root.mainloop()
