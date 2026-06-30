# bobium Changelog

All notable changes to this project will be documented in this file.

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
