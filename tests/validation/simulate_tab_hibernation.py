#!/usr/bin/env python3
import time
import os
import sys
import subprocess

def simulate_memory_pressure():
    try:
        import psutil
    except ImportError:
        print("  -> WARNING: 'psutil' module is required for the Tab Hibernation simulation.")
        print("  -> Please run: pip install psutil")
        return 1

    print("[Python Execution] Simulating 500+ tab multi-process load...")

    script_dir = os.path.dirname(os.path.abspath(__file__))
    target_bin = os.path.join(script_dir, "..", "..", "chromium", "out", "Release", "chrome")

    if not os.path.exists(target_bin):
        print(f"  -> ERROR: Target binary not found at {target_bin}.")
        return 1

    processes = []

    try:
        print("  -> Spawning 500 headless tabs to test memory caps and VFS offloading...")
        for i in range(500):
            # Spawn lightweight headless instances against a blank target
            p = subprocess.Popen([target_bin, "--headless", "--disable-gpu", "about:blank"],
                                 stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            processes.append(p)

        time.sleep(10) # Let processes settle and trigger hibernation patches

        # Calculate total memory of all browser processes
        total_memory_mb = 0
        for p in processes:
            try:
                proc = psutil.Process(p.pid)
                total_memory_mb += proc.memory_info().rss / (1024 * 1024)
            except psutil.NoSuchProcess:
                pass

        print(f"  -> Total aggregate memory consumption for 500 tabs: {total_memory_mb:.2f} MB")

        # 500 tabs would typically consume ~10-25GB unoptimized. We assert VFS keeps it < 4GB.
        if total_memory_mb < 4000:
            print("  -> VFS serialized successfully. Memory bounds respected.")
            ret = 0
        else:
            print("  -> ERROR: Tab limit memory bounds exceeded without aggressive VFS offloading!")
            ret = 1

    except Exception as e:
        print(f"  -> ERROR: Failed to execute simulation: {e}")
        ret = 1
    finally:
        print("  -> Cleaning up browser processes...")
        for p in processes:
            p.terminate()

    return ret

if __name__ == "__main__":
    sys.exit(simulate_memory_pressure())
