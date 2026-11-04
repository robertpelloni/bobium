# bobium: Local Build & Execution Instructions

This document provides complete instructions for setting up, compiling, and validating `bobium` locally on heavy-compute hardware or on a dedicated self-hosted CI runner.

---

## 1. Hardware Prerequisites

Compiling Chromium is one of the most resource-intensive build tasks. The build orchestrator scripts strictly enforce the following minimums:

- **Free Disk Space:** **150 GB+** on a fast NVMe or SSD (spinning HDDs will cause severe I/O bottlenecks).
- **RAM:** **32 GB minimum** (64 GB+ recommended). Systems with 16 GB will encounter Out-Of-Memory (OOM) errors during the link step (`lld` / `thinlto`).
- **CPU:** **8+ cores** (16+ threads recommended). Full clean compilation takes between 2 to 8 hours depending on CPU core count.

---

## 2. OS & System Dependencies

Ensure the base development toolchain is installed for your operating system:

### Linux (Ubuntu / Debian / Arch)
```bash
# Ubuntu / Debian
sudo apt-get update
sudo apt-get install -y build-essential git python3 curl pkg-config \
    libglib2.0-dev libnss3-dev libatk1.0-dev libatk-bridge2.0-dev \
    libcups2-dev libdrm-dev libxkbcommon-dev libxcomposite-dev \
    libxdamage-dev libxrandr-dev libgbm-dev libasound2-dev
```

### macOS
1. Install **Xcode Command Line Tools**:
   ```bash
   xcode-select --install
   ```
2. Note on macOS GN configuration: `enable_chromium_updater=false` is enforced in build configurations to bypass macOS sandboxing restrictions.

### Windows
1. Install **Visual Studio 2022** (Community or higher) with the **Desktop development with C++** workload.
2. Ensure Windows 10/11 SDK (version 10.0.22621.0 or newer) and C++ ATL/MFC components are installed.
3. Configure Git for line endings:
   ```bash
   git config --global core.autocrlf false
   git config --global core.filemode false
   ```
4. Enable Windows **Developer Mode** (or run as Administrator) to allow creation of symlinks by depot_tools.
5. Use **Git Bash** for running the orchestration `.sh` scripts.

---

## 3. Step-by-Step Build Orchestration

The repository uses modular bash scripts located in `scripts/`:

### Step 3.1: Pre-Flight Environment Sanity Check
Before downloading dependencies, run the pre-flight verification script to check dependencies, free disk space, and available memory:
```bash
./scripts/pre_flight_check.sh
```
*If this fails with insufficient disk space or RAM, allocate additional storage or swap before continuing.*

### Step 3.2: Fetch depot_tools & Chromium Source Tree
Fetch depot_tools and the complete Chromium source (~30 GB download):
```bash
./scripts/fetch-chromium.sh
```
This script will:
1. Clone `depot_tools` into `depot_tools/` if not already present.
2. Export `depot_tools` to `$PATH`.
3. Fetch the Chromium source into `chromium/src` using `fetch --nohooks chromium`.
4. Run `gclient sync --with_branch_heads --with_tags`.

### Step 3.3: Fetch Upstream Ungoogled Patches
Synchronize the latest de-Googling patch sets:
```bash
./scripts/fetch-ungoogled.sh
```

### Step 3.4: Verify Patch Integrity (Dry Run)
Before modifying the source tree, run the dry-run patch verification tool:
```bash
./scripts/validate-patches-dry-run.sh
```
This tests all patch tiers (`ungoogled/`, `privacy/`, `adblock/`, `performance/`, `portable/`, `branding/`) to ensure clean application.

### Step 3.5: Apply bobium & Ungoogled Patches
Apply the unified patch suite to `chromium/src`:
```bash
./scripts/apply-patches.sh
```

### Step 3.6: Generate Build Files & Compile
Compile the release binary with de-Googled GN arguments:
```bash
./scripts/build.sh
```
This runs:
- `gn gen out/Release --args='is_debug=false dcheck_always_on=false is_component_build=false symbol_level=0 blink_symbol_level=0 enable_hangout_services_extension=false enable_mdns=false google_api_key="" google_default_client_id="" google_default_client_secret="" safe_browsing_mode=0 use_thin_lto=true'`
- `autoninja -C out/Release chrome`

Compiled binary will be located at:
`chromium/src/out/Release/chrome` (or `chrome.exe` on Windows).

### Step 3.7: Package Release & Checksums
Package the distributable release and generate SHA-256 signatures:
```bash
./scripts/package_release.sh
```

---

## 4. Post-Build Validation Suite

Run the automated certification suite to verify that all privacy, portable, ad-blocking, and hibernation requirements are met:
```bash
./tests/validation/run_all_validations.sh
```

The test runner will execute:
1. `tests/validation/test_mv2_portable.sh`:
   - Validates inline `.portable` marker file hook and isolation in `vault/` (no system profile leakage).
   - Validates Manifest V2 extension loading and `webRequest` blocking without deprecation warnings.
2. `tests/validation/test_telemetry_performance.sh`:
   - Launches headless browser to capture `--log-net-log`.
   - Asserts zero Google endpoint pings (`clients4.google.com`, `update.googleapis.com`, `safebrowsing.google.com`, `gstatic.com`).
   - Runs `tests/validation/simulate_tab_hibernation.py` to assert memory limits under multi-tab simulation.
3. `tests/validation/verify_checksums.sh`:
   - Calculates SHA-256 hash of compiled binary and verifies integrity against build metadata.

---

## 5. Troubleshooting & Maintenance

- **Patch Collisions:** If upstream Chromium source drifts and a patch fails in `apply-patches.sh`, enter `chromium/src`, inspect conflicting files (`git status`), resolve conflicts, and re-export the patch using `git diff`.
- **Linking OOM:** If compilation is killed during final linking, lower Ninja concurrency with `NINJA_SUMMARIZE_BUILD=1 autoninja -j 4 -C out/Release chrome`.
