# bobium Changelog

All notable changes to this project will be documented in this file.

## [v0.1.0-alpha] - 2026-06-28
### Added
- **Final Handoff**: Project is successfully scaffolded and ready for physical compilation on a heavy-compute local machine (Commit: `f294588`).

### Verified Milestones
- **Milestone 5 (Build Pipeline & Distribution)**:
  - Completed GitHub Actions CI workflow for automated builds (Commit: `feb503d`).
  - Added binary packaging script `package_release.sh` (Commit: `1cb0874`).
  - Finalized `DEPLOY_VALIDATION.md` and `HANDOFF.md` instructions.
- **Milestone 4 (Hibernation Engine)**:
  - Wired `TabManager` to UI memory caps for aggressive hibernation (Commit: `3b2f2ab`).
  - Implemented VFS serialization logic and restoration hooks (Commit: `46a2939`, `622cff0`).
- **Milestone 3 (MV2 Preservation & Privacy)**:
  - Disabled Manifest V2 deprecation flags in `extension_features.cc`.
  - Enforced "Do Not Track" and third-party cookie blocking as defaults.
- **Milestone 2 (De-Googling)**:
  - Disabled Google Lens, Google Account Sync, IPv6 probes, and Safe Browsing telemetry (Commits: `87bcd6f`, `43ce699`, `f98214b`, `67898d1`).
  - Stripped hardcoded Chrome Web Store URLs and API keys.
- **Milestone 1 (Portable Vault & Build Orchestration)**:
  - Created standalone header-only `portable_mode.h` library to intercept profile path generation (Commit: `bdb555e`).
  - Developed `scripts/fetch-chromium.sh`, `scripts/apply-patches.sh`, and `scripts/build.sh` (Commit: `f786485`).


## [v0.1.0-alpha] - 2026-06-28 (Validation Lockdown)
### Added
- Final structural validation and build handoff complete.
- Verified all shell scripts (`fetch-chromium.sh`, `apply-patches.sh`, `build.sh`) via dry-run simulation.
- Audited all patches to confirm valid target paths and script references.
