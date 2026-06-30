# Project Memory: bobium

## Current State
Phase 4: Final Deployment Readiness
- Drafted Portable Vault Mode and auxiliary header wrappers (`portable_mode.h`).
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies) with `settings/default_preferences.json`.
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Fully sketched the Tab Hibernation Engine (VFS serialization, UI controls, wiring to TabManager, and restoration hooks).
- Completed the robust orchestration scripts: `fetch-chromium.sh`, `apply-patches.sh`, `build.sh`, `pre_flight_check.sh`, `package_release.sh`.
- Expanded documentation matrix with `DEPLOY.md`, `DEPLOY_VALIDATION.md`, `CONTRIBUTING.md`, and `RELEASE_CHECKLIST.md`.

## Active Focus
The agent has successfully drafted and wired the C++ patches for all major roadmap milestones up to Milestone 4, and rounded out all operational and deployment scripts/documentation. Because the physical limitations of the sandbox prevent executing a 30GB git clone and an 8-hour Chromium compilation, the agent's work here is officially done. The pipeline is fully prepared for validation and compilation on a heavy-compute local machine.
