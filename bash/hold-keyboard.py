from pynput.keyboard import Controller, Key
import time

keyboard = Controller()

print("Holding down '1'... Press CTRL+C to stop.")

try:
    keyboard.press('1')
    while True:
        time.sleep(1)  # keep alive
except KeyboardInterrupt:
    keyboard.release('1')
    print("\nStopped holding '1'.")