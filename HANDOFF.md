# bobium: Handoff & Execution Guide

This document acts as the definitive consolidation of the execution environment, patch sequences, and validation requirements necessary to handoff bobium from AI orchestration to human local-execution.

## 1. Hardware & System Prerequisites
Because Chromium's linker phase is intensely demanding, you **cannot** compile bobium on a standard lightweight CI runner or ephemeral sandbox.

*   **OS:** Ubuntu 22.04 LTS (Recommended), macOS 13+, or Windows 11.
*   **Disk Space:** `>150GB` of free SSD/NVMe space. (The source tree is ~30GB; build artifacts consume the rest).
*   **RAM:** `32GB` Minimum. `64GB` is highly recommended to avoid swapping and system lockups during the final `autoninja` linking phase.
*   **CPU:** 8+ Physical Cores.

**Cross-Platform Quirks:**
*   *Windows Git:* Ensure `core.autocrlf` is set to `false`. Convert to LF endings or `apply-patches.sh` will break universally.
*   *Windows Symlinks:* Enable Windows Developer Mode or use administrative privileges so `depot_tools` can construct symlinks.
*   *macOS Sandboxing:* `args.gn` explicitly sets `enable_chromium_updater=false` to avoid sandboxing conflicts.

## 2. Source Acquisition & Patch Sequences
Execute the pipeline strictly in this sequence:

1. Validate local dependencies: `./scripts/pre_flight_check.sh`
2. Fetch upstream Chromium via `depot_tools` (Takes Hours): `./scripts/fetch-chromium.sh`
3. Fetch privacy patches: `./scripts/fetch-ungoogled.sh`
4. **Patch Verification (Dry-Run):** Execute `./scripts/validate-patches-dry-run.sh` to ensure all patches stage cleanly against the currently fetched Chromium branch.
5. Apply Patches: `./scripts/apply-patches.sh`

**Explicit Patch Apply Order:**
The orchestrator scripts enforce the following application hierarchy to prevent context collisions:
1. `patches/ungoogled/*.patch` (Domain substitution, Google endpoints).
2. `patches/privacy/` (DNT, 3P cookie blocks).
3. `patches/adblock/` (MV2 deprecation hooks).
4. `patches/performance/` (Tab Hibernation VFS engines).
5. `patches/portable/` (Portable Vault profile redirection).
6. `patches/branding/` (UI substitutions).

## 3. Build Orchestration
Execute the build sequence: `./scripts/build.sh`

*   **GN Flags:** The script uses aggressive privacy flags (`google_api_key=""`, `safe_browsing_mode=0`).
*   **OOM Troubleshooting:** The final linking phase (`autoninja -C out/Release chrome`) can consume >32GB RAM. If the build crashes mysteriously, reduce concurrency (`autoninja -j 4`).

Once compiled, execute `./scripts/package_release.sh`.

## 4. Post-Build Automated Validation
Execute `./tests/validation/run_all_validations.sh` to parse net-logs and verify baseline functionality, then perform manual checks:

- [ ] **Portable Vault Isolation:** Touch `.portable` next to the executable. Verify `bobium_profile/` is created adjacent to the binary, escaping host `%APPDATA%`/`~/.config`.
- [ ] **Manifest V2 webRequest:** Load an unpacked MV2 extension (`webRequestBlocking`) and verify the "deprecated" warning is suppressed.
- [ ] **Telemetry Scrubbing:** Monitor Wireshark. Ensure no requests are made to `clients4.google.com` or `safebrowsing.google.com`.
- [ ] **Tab Hibernation:** Spawn 500 tabs. Verify background tabs flush memory state to VFS, keeping browser RAM stable.

---
**Status:** AI Sandbox architecture drafted. `#HANDOFF` to local compilation and human validation.
