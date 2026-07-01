# bobium Execution & Validation Checklist

This document serves as the final step-by-step checklist to compile and validate the bobium browser on a dedicated heavy-compute local machine.

## Phase 1: Environment Readiness
Ensure your build machine meets the strict requirements documented in `docs/BUILDING.md`.
- [ ] OS is Linux (Ubuntu 22.04+), macOS (13+), or Windows 11.
- [ ] >150GB of free SSD/NVMe disk space.
- [ ] 32GB+ RAM available (64GB recommended).
- [ ] 8+ CPU Cores available.
- [ ] `./scripts/pre_flight_check.sh` executes successfully.

## Phase 2: Compilation Execution
Execute the pipeline strictly in this sequence. Do not bypass the fetch scripts, as they manipulate `depot_tools` safely outside the git index.

- [ ] Run `./scripts/fetch-chromium.sh`
  * **Troubleshooting:** If `gclient sync` fails mid-way, it is usually due to network timeouts or disk space exhaustion. Rerun the script; it is designed to be idempotent.
- [ ] Run `./scripts/fetch-ungoogled.sh`
- [ ] Run `./scripts/apply-patches.sh`
  * **Troubleshooting:** Watch for `git apply` rejects. If Chromium upstream has aggressively refactored `chrome_main_delegate.cc` or `extension_features.cc`, the patches in `patches/` must be manually rebased and regenerated using `#HANDOFF` resolution.
- [ ] Run `./scripts/build.sh`
  * **Troubleshooting GN Flags:** The script uses aggressive privacy flags (e.g., `google_api_key=""`, `safe_browsing_mode=0`). If the linker crashes, ensure you have sufficient RAM. You can manually tweak `args.gn` in `chromium/out/Release` if needed.
- [ ] Run `./scripts/package_release.sh`

## Phase 3: Validation Verification
Once compilation is finished, execute the automated post-build suite to certify the binary.
- [ ] Run `./tests/validation/run_all_validations.sh`

**Manual Validation Checks:**
1. **Portable Vault:** Touch `.portable` next to the `chrome` binary. Launch the browser and verify that `bobium_profile/` is created inside that exact directory, not `~/.config/` or `%APPDATA%`.
2. **Manifest V2:** Install an MV2 extension (e.g., an older version of uBlock Origin). Ensure the "This extension is no longer supported" warning banner is hidden from `chrome://extensions`.
3. **Hibernation:** Spawn 500 blank tabs. Watch process explorer. Background tabs should flush memory state to VFS, keeping total browser RAM footprint stable.

---
**Status:** Architecture drafted. Awaiting human compilation. `#HANDOFF`
