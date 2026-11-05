# Project Memory: bobium

## Current State
Phase 4: Release Candidate 2 Orchestration & Patch Consolidation

- Confirmed consistency across README, VISION, ROADMAP, MEMORY, TODO, and CHANGELOG to ensure all reflect complete patch hierarchy (MV2, privacy, ungoogled telemetry, branding, tab hibernation, portable vault).
- Patch dry-run validation (`scripts/validate-patches-dry-run.sh`) provides format check mode in headless/ephemeral environments where the multi-gigabyte Chromium tree cannot be fetched.
- Patch fetcher (`scripts/fetch-ungoogled.sh`) is implemented and ready for heavy-compute synchronization.
- Release version bumped to `1.0.0-rc.2`.

## Execution & Setup Commands
Project setup, CI, and building rely on sequential custom bash scripts:
- `scripts/pre_flight_check.sh`: System hardware and tool checks.
- `scripts/fetch-chromium.sh`: Fetches upstream Chromium source tree via depot_tools.
- `scripts/fetch-ungoogled.sh`: Syncs upstream de-Googling patch sets.
- `scripts/validate-patches-dry-run.sh`: Pre-compilation patch syntax and application verification.
- `scripts/apply-patches.sh`: Applies all patch layers in strict deterministic order.
- `scripts/build.sh`: Runs gn gen and autoninja to compile the Release binary.
- `scripts/package_release.sh`: Packages release artifacts and generates SHA-256 checksums.
- `tests/validation/run_all_validations.sh`: Full post-build validation suite (MV2, portable vault, telemetry blocking, hibernation).

## CI Security
Do not use the `pull_request` trigger in GitHub Actions workflows that run on `self-hosted` runners, as this introduces a critical security vulnerability for arbitrary code execution from malicious PRs.

## Project Architecture
Custom C++ helper logic introduced into the Chromium source (such as portable mode detection) should be implemented as header-only libraries (e.g., `portable_mode.h`) or clean atomic patches to avoid requiring complex, fragile modifications to Chromium's GN/Ninja build files.
