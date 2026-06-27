# DEPLOYMENT & VALIDATION

The bobium project does not deploy to a server in the traditional sense; it must be compiled into cross-platform binaries. Because the Chromium source is extremely large (~30GB), a heavy-compute machine is required for local validation and final deployment builds.

## Heavy-Compute Machine Requirements
- **Disk Space:** 150GB+ (SSD/NVMe highly recommended)
- **RAM:** 32GB+
- **CPU:** 8+ cores
- **OS:** Linux (Ubuntu/Debian), macOS, or Windows 11 (with VS2022)

## Exact Local Validation Sequence

To validate the Phase 3/4 patches (Hibernation Engine, MV2, Privacy, Portable Mode), execute the following sequence precisely:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/robertpelloni/bobium.git
   cd bobium
   ```

2. **Fetch Chromium Source:**
   This script will download Google's `depot_tools` and clone the massive Chromium repository, pulling the stable `bobium_base` branch.
   ```bash
   ./scripts/fetch-chromium.sh
   ```

3. **Apply the Patch Engine:**
   This iterates through `patches/` (portable, adblock, privacy, ungoogled, branding, performance) and applies the C++ overrides to the Chromium tree.
   ```bash
   ./scripts/apply-patches.sh
   ```

4. **Orchestrate Build:**
   This runs GN with strict privacy/optimization flags and initiates the `autoninja` compiler. This will take several hours.
   ```bash
   ./scripts/build.sh
   ```

5. **Verify:**
   The compiled binary will reside in `chromium/out/Release/chrome` (or `bobium.exe`). Run it and test the vault mode by creating a `.portable` file adjacent to the executable.
