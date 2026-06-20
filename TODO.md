# TODO.md

## Immediate Tasks
- [x] Initialize missing repository directories (`patches/`, `portable/`, `settings/`, `scripts/`).
- [x] Develop `scripts/fetch-chromium.sh` to robustly handle depot_tools setup and `gclient runhooks` for the 30GB repo.
- [x] Develop `scripts/apply-patches.sh` to ingest and apply ungoogled-chromium baseline patches.
- [x] Develop `scripts/build.sh` for standard `gn gen` and `autoninja` compilation steps.
- [x] Identify and prepare patch for `chrome/browser/extensions/manifest_v2_experiment.cc` to permanently disable MV2 deprecation.

## Short-term Features
- [x] Draft the initial portable mode detection logic (`chrome_main_delegate.cc` equivalent patch) to redirect the User Data directory.
- [x] Create `settings/default_preferences.json` enforcing strict privacy defaults (DNT on, third-party cookies blocked, no sync).
- [x] Prepare the `AES-256` wrapper for the portable Vault mode workspace.

## Bug Fixes & Refactoring
- [x] Solidify all overarching documentation and ensure consistent versioning references in `VERSION.md`.
- [x] Ensure build scripts can gracefully recover from interrupted `gclient sync` instances given the immense size of the submodule.
