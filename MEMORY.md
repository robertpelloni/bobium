# Project Memory: bobium

## Current State
Phase 2: Performance (Hibernation Engine) Execution.
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Drafted initial Tab Hibernation Engine logic.
- Implemented C++ stub for VFS DOM serialization (`TabHibernationManager`).

## Active Focus
Continuing to refine the Hibernation Engine (Milestone 4 on ROADMAP). The `TabHibernationManager` class has been scaffolded to handle writing WebContents data to disk, allowing 100% memory reclamation for the "500+ tabs" goal.
