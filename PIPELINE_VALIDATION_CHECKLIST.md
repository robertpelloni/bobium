# bobium Cross-Platform Pipeline Validation Checklist

This checklist is designed for human maintainers executing the bobium build orchestration on physical heavy-compute hardware (Linux, macOS, or Windows). It provides edge-case mitigation, cross-platform quirk documentation, and explicit manual testing criteria.

## Phase 1: Source Acquisition (`fetch-chromium.sh` / `fetch-ungoogled.sh`)

- [ ] **Windows Git Configuration:** Ensure `core.autocrlf` is set to `false`. Chromium source expects LF endings. Converting to CRLF will break `apply-patches.sh` universally.
  * *Fix:* `git config --global core.autocrlf false`
- [ ] **Windows Symlink Constraints:** Windows requires developer mode or elevated administrative privileges to allow `depot_tools` to construct symlinks within the massive Chromium tree.
  * *Fix:* Enable Windows Developer Mode in Settings -> Privacy & Security.
- [ ] **Network Interruptions:** `gclient sync` downloads ~30GB. If it times out, rerun `./scripts/fetch-chromium.sh`. It is idempotent and will resume.

## Phase 2: Patch Integration (`apply-patches.sh`)

- [ ] **Upstream Rebase Conflicts:** Chromium's master branch moves incredibly fast. If a patch fails (e.g., `0001-preserve-manifest-v2.patch` rejects against `extension_features.cc`), do **not** force apply.
  * *Fix:* Manually checkout the specific Chromium tag used when the patch was authored, or manually resolve the C++ conflict and regenerate the patch file using `git format-patch`.
- [ ] **Patch Ordering:** Ungoogled patches *must* apply before bobium-specific UI patches to ensure target lines haven't shifted.

## Phase 3: Build Orchestration (`build.sh`)

- [ ] **GN Misconfigurations (macOS Sandboxing):** `args.gn` strictly disables Google APIs. On macOS, ensure `enable_chromium_updater=false` to prevent the OS sandboxing logic from halting execution due to missing developer certificates.
- [ ] **Ninja Out-of-Memory (OOM) Errors:** The final linking phase (`autoninja -C out/Release chrome`) can consume >32GB RAM. If the build crashes mysteriously at 98%, it is an OOM kill.
  * *Fix:* Reduce concurrency by passing `-j 4` to ninja (e.g., `autoninja -j 4 -C out/Release chrome`).
- [ ] **Binary Output Verification:** Ensure `chrome` (Linux/macOS) or `chrome.exe` (Windows) is generated inside `chromium/out/Release/`.

## Phase 4: Runtime Feature Validation

Once compiled, execute `./tests/validation/run_all_validations.sh` to parse net-logs and verify baseline functionality, then perform these manual checks:

- [ ] **Portable Vault Isolation:**
  1. Create an empty `.portable` file next to the executable.
  2. Launch the browser and browse to any site.
  3. Close the browser.
  4. Verify a `bobium_profile/` directory appeared *adjacent* to the executable.
  5. Verify your host OS's default AppData/Config folder does *not* contain a new bobium profile.
- [ ] **Manifest V2 webRequest Hooks:**
  1. Navigate to `chrome://extensions`.
  2. Enable "Developer Mode".
  3. Load an unpacked MV2 extension that relies on `webRequestBlocking` (e.g., an older build of uBlock Origin).
  4. Verify the extension loads without error.
  5. Verify the "Manifest V2 is deprecated" yellow warning banner is suppressed/invisible.
- [ ] **Telemetry Scrubbing:**
  1. Launch the browser and monitor traffic via Wireshark or `chrome://net-export/`.
  2. Verify no DNS requests are made to `clients4.google.com`, `update.googleapis.com`, or `safebrowsing.google.com` upon startup.
