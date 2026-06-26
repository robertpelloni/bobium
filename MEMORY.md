# Project Memory: bobium

## Current State
Phase 3: Final Build Orchestration & Integration Verification
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.
- Fully sketched the Tab Hibernation Engine (VFS serialization, UI controls, wiring to TabManager, and restoration hooks).
- Completed the robust `fetch-chromium.sh` orchestration script.
- Finalized `build.sh` script to automate GN generation and Ninja compilation.

## Active Focus
The agent has successfully drafted and wired the C++ patches for all major roadmap milestones up to Milestone 4. The orchestration scripts (`fetch-chromium.sh`, `apply-patches.sh`, `build.sh`) are completed and structurally sound. Because the physical limitations of the sandbox prevent executing a 30GB git clone and an 8-hour Chromium compilation, the agent's work here is officially done. The pipeline is ready for validation on a heavy-compute local machine.
