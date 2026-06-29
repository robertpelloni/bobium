# bobium Deployment & Build Guide

## Local Build Prerequisites
To compile the bobium browser from source on a local machine, you MUST have the following:

- **Compute:** 8-core CPU minimum (16+ cores recommended).
- **Memory:** 32GB RAM minimum (64GB recommended).
- **Storage:** 150GB+ of free disk space on a fast SSD (Chromium source + build artifacts are massive).
- **Tools:** `git`, `python3`, `curl`, `build-essential` (Linux), or Visual Studio (Windows).

## Step-by-Step Validation Instructions

### 1. Initialize the Environment
Ensure your system is updated and you have a clean workspace. Clone the repository.

```bash
git clone <repo-url> bobium && cd bobium
```

### 2. Fetch the Chromium Source
Run the fetch orchestration script. This will download `depot_tools` and initiate the massive Chromium source fetch.
**Warning:** This step will take several hours and requires a stable, fast internet connection.

```bash
./scripts/fetch-chromium.sh
```

### 3. Apply the Patch Engine
Once the source is fetched, apply the bobium patch engine to the Chromium tree. This modifies the source code to enforce our privacy defaults, portable mode, and tab hibernation logic.

```bash
./scripts/apply-patches.sh
```
Check the output carefully to ensure no patches are rejected or corrupt.

### 4. Compile the Browser
Initiate the GN and autoninja compilation sequence.

```bash
./scripts/build.sh
```
This step will take between 2 to 10 hours depending on your hardware.

### 5. Post-Build Validation
Once compiled, locate the binary in `chromium/out/Release/chrome` (or `bobium.exe`).

- **Test Portable Vault:** Launch the browser and verify that a `vault` directory is created alongside the binary, and that no profile data is written to standard OS appdata locations.
- **Test MV2 Preservation:** Install a Manifest V2 extension like uBlock Origin and confirm no deprecation banners appear.
- **Test Tab Hibernation:** Open 20+ tabs and verify memory footprint drops significantly after enabling the hibernation feature in settings.

## First Run & Feature Validation

After compiling the bobium browser, execute the binary and perform the following initial verification steps:

1.  **Portable Mode Validation:**
    *   Do not launch bobium via standard shortcuts. Run the executable directly from the terminal or a portable USB drive.
    *   Verify that a `vault/` directory is automatically generated adjacent to the executable.
    *   Navigate to `chrome://version` and ensure the "Profile Path" explicitly points into the new `vault/` directory rather than the host OS user data folders (e.g., `~/.config/` or `%LOCALAPPDATA%`).
2.  **MV2 Preservation Validation:**
    *   Navigate to the Chrome Web Store or download a `.crx` file for a Manifest V2 extension (e.g., uBlock Origin).
    *   Install the extension.
    *   Navigate to `chrome://extensions` and verify there are NO "deprecation" or "unsupported" warning banners displayed.
3.  **Tab Hibernation Validation:**
    *   Open `chrome://settings/performance`.
    *   Verify the existence of the custom bobium Memory Cap UI controls.
    *   Enable the feature and set a low threshold. Open 20+ heavy web pages.
    *   Monitor the system task manager or `chrome://system` to ensure background tabs are aggressively serialized to disk/VFS and purged from active RAM.

## Static Validation Notes
Due to the rapid development cycle of the upstream Chromium source, patch collision is a known risk.
When executing `apply-patches.sh`, if you encounter pathing errors targeting `chrome/app/chrome_main_delegate.cc` or `extensions/common/extension_features.cc`, it means the Chromium source tree has drifted from the snapshot these patches were originally developed against.

**Resolution:**
If `git apply` rejects a patch:
1. Locate the target file (e.g., `chromium/src/chrome/app/chrome_main_delegate.cc`).
2. Search the upstream source for the new function signature (e.g., `PreSandboxStartup()`).
3. Manually integrate the custom logic (such as `#include "portable_mode.h"` and the vault hook).
4. Run `git diff > patches/portable/0001-portable-vault-mode.patch` to regenerate the patch file against the current Chromium stable branch.
