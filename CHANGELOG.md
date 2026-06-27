# Changelog

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
