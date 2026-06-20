# MEMORY.md

## Internal Architectural Observations

### Chromium Base Structure
- The repository relies on fetching the official Chromium source as a massive (~30GB) dependency via `depot_tools`.
- Because of its size, direct source modification is an anti-pattern. Instead, all modifications must be maintained as discrete, categorized patches in `patches/` and applied during the build process using `scripts/apply-patches.sh`.

### Upstream Inspiration & Patching
- **Ungoogled-Chromium:** The primary source for Google-stripping patches. We must closely monitor their updates to maintain baseline privacy without reinventing the wheel.
- **Brave Core:** An excellent reference for integrating a Rust-based, WASM-compiled ad blocker directly into the browser core to bypass extension API limitations.
- **Vivaldi:** The reference implementation for "Portable Mode," bypassing standard OS profile paths (like `AppData\Local\Google\Chrome`) to store `UserData` alongside the executable.

### Manifest V2 Preservation
- The MV2 deprecation logic is primarily controlled by feature flags (`extensions::kMV2DeprecationWarning` in `chrome/browser/extensions/manifest_v2_experiment.cc`).
- The short-term fix is neutralizing these flags. The long-term architectural challenge will be maintaining the `webRequest` API if Google entirely strips the underlying C++ logic.

### Design Preferences
- **Modularity:** Scripts should be robust and capable of resuming interrupted tasks (especially `gclient sync`).
- **Performance:** CPU budget gating and extreme tab hibernation are priorities to solve the "Edge 400+ Tabs" problem.
- **Documentation:** Strict adherence to universal LLM instructions. Every change must increment `VERSION.md` and be detailed in `CHANGELOG.md`.
