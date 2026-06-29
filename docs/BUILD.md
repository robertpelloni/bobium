# bobium Build & Validation Guide

Because Chromium is massive, the build process requires specific configuration. This guide outlines how to compile and validate the bobium project on a local heavy-compute machine.

## 1. System Prerequisites
- **Compute:** 8-core CPU minimum (16+ cores recommended).
- **Memory:** 32GB RAM minimum (64GB recommended).
- **Storage:** 150GB+ of free disk space on a fast SSD (Chromium source + build artifacts are massive).
- **Tools:** `git`, `python3`, `curl`, `depot_tools`.
- **Platform Specifics:**
  - **Linux:** `build-essential`, `ninja-build`.
  - **Windows:** Visual Studio 2022 with C++ workload.
  - **macOS:** Xcode Command Line Tools.

## 2. Step-by-Step Execution

### Fetch the Chromium Source
Run the fetch orchestration script. This will download `depot_tools` and initiate the massive Chromium source fetch.
**Warning:** This step will take several hours.
```bash
./scripts/fetch-chromium.sh
```

### Apply the Patch Engine
Once the source is fetched, apply the bobium patch engine to the Chromium tree.
```bash
./scripts/apply-patches.sh
```
Check the output carefully to ensure no patches are rejected or corrupt.

### Compile the Browser
Initiate the GN and autoninja compilation sequence.
```bash
./scripts/build.sh
```
This step will take between 2 to 10 hours depending on your hardware. The final binary will be located in `chromium/src/out/Release/chrome` (or `bobium.exe` on Windows).

## 3. Post-Build Verification Checklist
After a successful build, launch the binary and verify the following core milestones:

*   [ ] **Portable Vault Mode:** Do not launch via standard shortcuts. Run the executable directly. Verify that a `vault/` directory is automatically generated adjacent to the executable. Navigate to `chrome://version` and ensure the "Profile Path" explicitly points into the new `vault/` directory.
*   [ ] **Manifest V2 (Ad Blocking):** Install a Manifest V2 extension like uBlock Origin. Navigate to `chrome://extensions` and verify there are NO "deprecation" or "unsupported" warning banners displayed.
*   [ ] **Tab Hibernation:** Open `chrome://settings/performance`. Verify the custom bobium Memory Cap UI controls are present. Enable the feature, set a low threshold, open 20+ heavy web pages, and monitor the system task manager to ensure background tabs are aggressively serialized to VFS and purged from active RAM.
*   [ ] **Privacy Defaults:** Navigate to `chrome://settings/cookies` and verify "Block third-party cookies" is the hardcoded default. Verify no Google Account sign-in prompts appear on first launch.
