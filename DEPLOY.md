# DEPLOY.md

## Environment Setup & Build Instructions

### WARNING: Resource Requirements
Building Chromium is an immense task.
- **Source Size:** ~30GB download, ~100GB total with build artifacts.
- **Build Time:** 2-8 hours depending on CPU/RAM.
- **RAM:** Minimum 32GB, 64GB strongly recommended.
- **Disk:** 150GB+ free space on an SSD.

### 1. Prerequisites
- **Python 3**
- **Git**
- **OS-Specific Toolchains:**
  - **Windows:** Visual Studio 2022 with C++ workload, Windows 10/11 SDK.
  - **macOS:** Latest Xcode.
  - **Linux (Debian/Ubuntu):**
    ```bash
    sudo apt install build-essential clang lld libgtk-3-dev libglib2.0-dev libnss3-dev libatk1.0-dev libatk-bridge2.0-dev libcups2-dev libdrm-dev libxkbcommon-dev libxcomposite-dev libxdamage-dev libxrandr-dev libgbm-dev libasound2-dev
    ```

### 2. Setting Up `depot_tools`
Chromium's build relies on Google's `depot_tools`.

```bash
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$(pwd)/depot_tools
```
*(On Windows, add the depot_tools directory to your System PATH environment variable.)*

### 3. Fetching Chromium
Initialize the environment and fetch the code.

```bash
# From the bobium root directory
mkdir -p chromium && cd chromium
fetch --nohooks chromium
cd src
gclient runhooks
```
*Note: This process will take hours. Do not interrupt `fetch`.*

### 4. Patch Application
We use a patch-based approach to modify Chromium without maintaining a hard fork of the massive 30GB repository.

```bash
# Return to the bobium root
cd ../../
./scripts/apply-patches.sh
```

### 5. Build Configuration
Generate the Ninja build files using GN.

```bash
cd chromium/src
gn gen out/Release --args='is_debug=false is_official_build=true symbol_level=0'
```

### 6. Compilation
Run the build using `autoninja`.

```bash
autoninja -C out/Release chrome
```

### 7. Deployment / Running
Once compiled, you can run the binary directly.

```bash
# Linux/macOS
./out/Release/chrome

# Windows
out\Release\chrome.exe
```

For portable mode testing, ensure a `portable` file or directory exists adjacent to the executable.
