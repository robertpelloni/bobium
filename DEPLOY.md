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
