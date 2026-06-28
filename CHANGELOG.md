# Changelog

## [v0.1.0] - 2026-06-28
### Added
- Explicitly marked Milestone 1 (Core Foundation completion).
- Documented finished core patch infrastructure, build/fetch orchestration scripts, and hibernation engine drafts.
## [0.4.0] - 2026-06-28
### Added
- Finalized Milestone 4 completion.
- Created `DEPLOY_VALIDATION.md` featuring a comprehensive step-by-step verification checklist for executing the build pipeline on local heavy-compute machines.
- Handoff package for Milestone 5 is complete and ready.
## [v0.4.1] - 2026-06-28
### Added
- Refactored portable mode marker detection into a standalone header-only `portable_mode.h` library.
- Added unit tests for portable mode detection.
- Updated `build.sh` to compile and execute the test runner automatically before Chromium compilation.
### Added
- Created `DEPLOY.md` to explicitly define the heavy-compute validation sequence required outside of the AI sandbox.
- Fixed `README.md` checkboxes to accurately reflect the completion of Phase 3 and Phase 4 features via the C++ patch drafts.

## [0.5.0-alpha] - 2026-06-24
### Added
- Finalized Phase 3 & 4 feature implementation (Performance/Tab Hibernation Engine and UI Hooks).
- Completed end-to-end build orchestration scripts ready for local execution.
- Formalized project handoff documentation for heavy-compute environment.

## [0.2.0-beta] - 2026-06-23
### Added
- Completed Phase 1 (Foundation): `fetch-chromium.sh`, `build.sh`, and `apply-patches.sh` build orchestration.
- Completed Phase 1 (Core Patches): Manifest V2 preservation, ungoogled-chromium telemetry removal, Google Account sync disabling.
- Completed Phase 2 (Performance): Tab Hibernation Engine logic with VFS serialization stub and UI memory cap wiring.
- Completed Phase 3 (UI): Foundational bobium branding string replacements.

## [0.1.0-alpha] - 2026-06-22
### Added
- Implemented foundational Portable Vault Mode patch (`patches/portable/0001-portable-vault-mode.patch`) to intercept profile path generation.
- Added `scripts/apply-patches.sh` skeleton for build automation.

## [v0.4.2-dev] - 2026-06-27
### Fixed
* Recalculated hunk sizes and fixed context lines formatting across all `.patch` files to resolve `corrupt patch` errors during validation.

## [0.4.0] - 2026-06-27
### Changed
- Finalized integration verification.
- Validated patch application order and GN configuration syntax.
- Milestone v0.4.0 completed.

## [v0.1.0] - 2026-06-27
### Changed
- Explicit override: Re-versioned to v0.1.0 to formally mark Milestone 1 core foundation completion.
- Logged all core patch infrastructure (portable vault, MV2, privacy, ungoogled, branding).
- Logged performance tab hibernation engine logic.
- Logged completion of `scripts/fetch-chromium.sh`, `scripts/apply-patches.sh`, and `scripts/build.sh`.

## [0.4.0] - 2026-06-27 (Final Handoff)
### Added
- Completed Milestones 1-4.
- Verified documentation consistency across README, VISION, ROADMAP, and MEMORY.
- Repository is ready for heavy compute local build validation.

## [0.5.0] - 2026-06-27 (Phase 3 End)
### Added
- Logged the completion of the build orchestration and hibernation engine wiring.
- Finalized housekeeping changes to cleanly close out the handoff for Phase 3.

## [v0.1.0] - 2026-06-28
### Added
- Finalized local execution handoff documentation.
- Added explicit local build prerequisites and step-by-step validation instructions to DEPLOY.md and HANDOFF.md.
- Marked Milestone 1 completion.

## [v0.1.0-rc1] - 2026-06-28
### Added
- Completed sandbox initialization phase.
- Added troubleshooting notes for `depot_tools` and patch conflicts to `HANDOFF.md`.
- Added "First Run" section to `DEPLOY.md` to guide validation of portable mode, MV2, and tab hibernation.
- Marked project as ready for local heavy-compute build validation.

## [v0.4.1] - 2026-06-28
### Added
- Refactored portable mode marker detection into a standalone `portable_mode.cc` helper.
- Added unit tests for portable mode detection.
- Created `run_tests.sh` to compile and execute the test runner.
