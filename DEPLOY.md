# bobium Deployment & Build Guide

To deploy and test bobium, the project must be compiled from source on a local heavy-compute machine.

## Build Prerequisites
- **Disk:** 150GB+ free SSD space.
- **RAM:** 32GB+ (64GB recommended).
- **Compute:** 8+ Core CPU.
- **Tools:** `depot_tools` in `$PATH`, `git`, `python3`.

### Platform Specifics
- **Linux:** Install `build-essential` and `ninja-build`.
- **Windows:** Install Visual Studio 2022 with the "Desktop development with C++" workload. Ensure you are using Git Bash or an appropriate shell for executing the `.sh` scripts.
- **macOS:** Install Xcode Command Line Tools.

## Step-by-Step Execution

1. Clone this repository locally.
2. Ensure your machine meets the hardware requirements.
3. Fetch the Chromium source (~30GB) and `depot_tools` by running:
   ```bash
   ./scripts/fetch-chromium.sh
   ```
4. Apply the bobium patches to the Chromium tree:
   ```bash
   ./scripts/apply-patches.sh
   ```
   *Note: If an upstream patch collision occurs, you must manually resolve the merge conflict in `chromium/src` and regenerate the patch file via `git diff`.*
5. Build the browser (takes 2-10 hours depending on hardware):
   ```bash
   ./scripts/build.sh
   ```

## Post-Build Validation
Once compiled, locate the binary in `chromium/src/out/Release/chrome` (or `bobium.exe`).
- **Test Portable Vault:** Launch the browser and verify that a `vault/` directory is created.
- **Test MV2 Preservation:** Install a Manifest V2 extension and confirm no deprecation banners appear.
- **Test Tab Hibernation:** Enable hibernation in settings, open many tabs, and monitor memory usage.
