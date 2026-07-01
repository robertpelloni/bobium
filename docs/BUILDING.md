# bobium Heavy-Compute Build Instructions

Chromium compilation requires a massive amount of system resources. This guide outlines the necessary prerequisites and step-by-step instructions to move from the AI Sandbox orchestration phase to a fully compiled local binary.

## 1. Hardware & System Prerequisites
Because Chromium's linker phase is intensely demanding, you **cannot** compile bobium on a standard lightweight CI runner or ephemeral sandbox.

*   **OS:** Ubuntu 22.04 LTS (Recommended), macOS 13+, or Windows 11.
*   **Disk Space:** `>150GB` of free SSD/NVMe space. (The source tree is ~30GB; build artifacts consume the rest).
*   **RAM:** `32GB` Minimum. `64GB` is highly recommended to avoid swapping and system lockups during the final `autoninja` linking phase.
*   **CPU:** 8+ Physical Cores.

## 2. Software Dependencies
Ensure your host machine has the following installed:
*   `git`
*   `python3`
*   Build Toolchain: `GCC`/`Clang` (Linux), `Xcode` (macOS), or `Visual Studio 2022` (Windows).

## 3. Step-by-Step Local Execution Guide

Execute the following commands sequentially on your heavy-compute machine:

```bash
# Step 1: Clone the bobium patch engine repository
git clone --recursive https://github.com/robertpelloni/bobium.git
cd bobium

# Step 2: Validate local dependencies
./scripts/pre_flight_check.sh

# Step 3: Fetch the massive Chromium source tree (Takes Hours)
# This will automatically clone Google's depot_tools and run gclient sync.
./scripts/fetch-chromium.sh

# Step 4: Fetch Ungoogled-Chromium base patches
./scripts/fetch-ungoogled.sh

# Step 5: Apply bobium custom C++ patches (Portable mode, MV2, etc)
./scripts/apply-patches.sh

# Step 6: Generate Ninja configurations and compile (Takes 2-8 Hours)
./scripts/build.sh

# Step 7: Package the binaries and generate final checksums
./scripts/package_release.sh
```

## 4. Post-Build Automated Validation
Once the build is complete and packaged, you should immediately run the validation suite to ensure the environment compiled correctly and the telemetry blocks are active:

```bash
./tests/validation/run_all_validations.sh
```
