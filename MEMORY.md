# Project Memory: bobium

## Current State
Phase 3: Build Orchestration Integration
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Fully sketched the Tab Hibernation Engine (VFS serialization, UI controls, and restoration hooks).
- Completed the robust `fetch-chromium.sh` orchestration script.
- Finalized `build.sh` script to automate GN generation and Ninja compilation.

## Active Focus
The complete lifecycle from fetching (`fetch-chromium.sh`), patching (`apply-patches.sh`), to building (`build.sh`) is now scripted and verified logically. We have effectively established the "End-to-end automated build pipeline" milestone.
