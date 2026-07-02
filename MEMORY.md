# Project Memory: bobium

## Current State
Phase 5: Autonomous Handoff Complete
- Drafted Portable Vault Mode and auxiliary header wrappers (`portable_mode.h`).
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies) with `settings/default_preferences.json`.
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Fully sketched the Tab Hibernation Engine (VFS serialization, UI controls, wiring to TabManager, and restoration hooks).
- Completed the robust orchestration scripts: `fetch-chromium.sh`, `apply-patches.sh`, `build.sh`, `pre_flight_check.sh`, `package_release.sh`.
- Expanded documentation matrix with `DEPLOY.md`, `DEPLOY_VALIDATION.md`, `CONTRIBUTING.md`, `RELEASE_CHECKLIST.md`, and `EXECUTION_HANDOFF.md`.
- Consolidated all resources into a final validation bundle (`bobium-handoff.tar.gz`).

## Active Focus
The agent has successfully finalized all code, patches, bash orchestration scripts, mock-testing validation suites, and documentation spanning Milestones 1-4. Because physical sandbox limitations prevent executing a 30GB+ git clone and an 8-hour compilation, the autonomous phase is complete. The project is #HANDOFF ready for a human developer to pull the repository on a heavy-compute machine and execute the documented verification checklist.

## Handoff Readiness
- **In-Sandbox Testing Complete:** Syntax verification (`bash -n`) for all build scripts, patch hierarchy logic audit, validation script dependency handling, and checksum payload validations.
- **Requires Local Execution:**
  - `scripts/fetch-chromium.sh` (>30GB download)
  - `scripts/apply-patches.sh` (actual git patch generation against upstream src)
  - `scripts/build.sh` (autoninja compilation, ~150GB disk + 32GB RAM required)
  - `./tests/validation/run_all_validations.sh` (must be run post-build)
- **Expected Outcomes:**
  - Portable Vault Mode successfully isolates profile data into the `chromium/out/Release/bobium_profile` local directory.
  - MV2 Extensions (e.g. uBlock Origin) successfully install without deprecation warnings.
  - Network pings to `clients4.google.com` or telemetry domains are blackholed.
  - Tab Hibernation serializes memory bounds under 4GB thresholds correctly.
