# bobium Build Instructions

Because Chromium is massive, the build process requires specific configuration. This guide outlines how to transfer the project to a local high-compute machine and validate the v0.4.x features.

## 1. System Prerequisites (High-Compute Machine)
- **Compute:** 8-core CPU minimum (16+ cores recommended).
- **Memory:** 32GB RAM minimum (64GB recommended).
- **Storage:** 150GB+ of free disk space on a fast SSD.
- **Tools:** `git`, `python3`, `curl`, `depot_tools`.

## 2. Transfer and Execute
1. Clone this repository to your high-compute machine.
2. Run the fetch orchestration script (Downloads Chromium, ~30GB):
   ```bash
   ./scripts/fetch-chromium.sh
   ```
3. Apply the bobium patch engine:
   ```bash
   ./scripts/apply-patches.sh
   ```
4. Compile the Browser:
   ```bash
   ./scripts/build.sh
   ```

## 3. Feature Validation (v0.4.x Roadmap)
After a successful build, locate the binary in `chromium/src/out/Release/chrome` and verify:

*   **Portable Vault Validation:** Run the executable directly. Verify that a `vault/` directory is automatically generated adjacent to the executable, and `chrome://version` shows the Profile Path inside `vault/`.
*   **Tab Hibernation Validation:** Open `chrome://settings/performance`. Enable the Memory Cap UI controls, open 20+ heavy web pages, and ensure background tabs are serialized to VFS and purged from active RAM.
