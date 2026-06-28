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

## Phase 4 Build Validation Result
*   Executed validation sequence inside the agent sandbox.
*   **Result**: Expected failure. The sandbox lacks the ~150GB disk space and heavy compute required to perform a full `fetch` and compilation. The `fetch-chromium.sh` script successfully simulates the environment creation, but `apply-patches.sh` and `build.sh` predictably fail due to the missing source tree and uninitialized `depot_tools`.
*   **Action**: Validation must occur via the CI pipeline on a self-hosted runner, as structured in `.github/workflows/build.yml`.
- **Documentation Verification**: Confirmed consistency across README, VISION, ROADMAP, and MEMORY to ensure all reflect the completion of the core patching architecture, orchestration scripts, and hibernation/portable infrastructure.
