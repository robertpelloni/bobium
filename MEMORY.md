# Project Memory: bobium

## Current State
Phase 2: Performance (Hibernation Engine) Execution is nearly complete.
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Drafted initial Tab Hibernation Engine logic.
- Implemented C++ stub for VFS DOM serialization (`TabHibernationManager`).
- Implemented UI control hooks for setting memory caps per tab.

## Active Focus
The core features listed in the VISION and ROADMAP for Milestone 1-4 have been completely scaffolded via patch files. The patch integration pipeline (`apply-patches.sh`) is fully aware of all directories. We are now ready to tackle the final build environment instructions or await actual deployment onto a machine capable of pulling the 30GB repository.
