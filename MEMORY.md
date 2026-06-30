# Project Memory: bobium

## Current State
Phase 3: Final Build Orchestration & Integration Verification

- Confirmed consistency across README, VISION, ROADMAP, and MEMORY to ensure all reflect the completion of the core patching architecture, orchestration scripts, and hibernation/portable infrastructure.
- Final Phase 3 Closure: Phase 3 officially closed.
- Next Steps: The codebase has been fully scrubbed, verified, and pushed. Phase 4 handoff notes for local machine execution are comprehensively detailed in `docs/BUILD_INSTRUCTIONS.md`.

## Execution & Setup Commands
Project setup, CI, and building rely on sequential custom bash scripts: `scripts/fetch-chromium.sh` (using `fetch --nohooks` and `gclient sync`) and `scripts/apply-patches.sh` (using `git -C` for safety) to apply modifications to `chromium/src`, and `scripts/build.sh` (using gn gen and autoninja) for compilation.

## CI Security
Do not use the `pull_request` trigger in GitHub Actions workflows that run on `self-hosted` runners, as this introduces a critical security vulnerability for arbitrary code execution from malicious PRs.

## Project Architecture
Custom C++ helper logic introduced into the Chromium source (such as portable mode detection) should be implemented as header-only libraries (e.g., `portable_mode.h`) to avoid requiring complex, fragile modifications to Chromium's GN/Ninja build files.
