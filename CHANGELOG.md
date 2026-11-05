# bobium Changelog

All notable changes to this project will be documented in this file.

## [1.0.0-rc.2] - 2026-11-04
### Added
- Created `patches/adblock/0001-preserve-manifest-v2.patch` permanently locking Manifest V2 and webRequest support.
- Created `patches/privacy/0001-default-privacy-settings.patch` enforcing Do Not Track and privacy-first defaults.
- Created `patches/ungoogled/0001-disable-google-telemetry.patch` stripping Safe Browsing and background Google endpoints.
- Created `patches/branding/0001-bobium-branding.patch` updating browser identity and description to bobium.
- Created `patches/performance/0001-tab-hibernation.patch` adding asynchronous VFS serialization hooks to TabLifecycleUnit.
- Created `scripts/fetch-ungoogled.sh` to fetch ungoogled-chromium upstream patches.
- Updated `scripts/validate-patches-dry-run.sh` to support git-apply formatting and syntax validation when physical Chromium tree is not checked out.

## [1.0.0-rc.1] - 2026-06-30
### Added
- **Milestone 5 Complete:** Finalized the build and deployment pipeline.
- Verified orchestration scripts (`fetch-chromium.sh`, `apply-patches.sh`, `build.sh`) via `shellcheck`.
- Generated comprehensive `DEPLOY.md` with cross-platform instructions (Linux, Windows, macOS).
- Project is fully handed off and flagged as ready for external heavy-compute build validation.

## [v0.1.0-alpha.1] - 2026-06-30
### Added
- Created `CONTRIBUTING.md` outlining the upstream drift patch-conflict resolution protocol.
- Generated `docs/BUILD_INSTRUCTIONS.md` for explicit local machine deployment.
- Marked Phase 3 Integration as finalized and closed out documentation loop.
- Developed `scripts/fetch-chromium.sh`, `scripts/apply-patches.sh`, and `scripts/build.sh`.
- Created standalone header-only `portable_mode.h` library to intercept profile path generation.
