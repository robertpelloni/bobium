# Project Memory: bobium

## Current State
Phase 2: Performance (Hibernation Engine) Execution is now structurally drafted.
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Fully sketched the Tab Hibernation Engine: VFS serialization logic is written, UI controls are established, and the bridge connecting the UI memory caps to the actual `TabManager` discard triggers is complete.
- Completed the robust `fetch-chromium.sh` orchestration script.
- Finalized `build.sh` script to automate GN generation and Ninja compilation.

## Active Focus
Milestone 4 (The Hibernation Engine) is conceptually finished as far as patch generation without the live Chromium tree. The project architecture is stable and ready to be built in a non-sandbox environment.
