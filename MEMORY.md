# Project Memory: bobium

## Current State
Phase 1 & 2 Overlap: Foundation & Privacy Enforcement.
- Drafted Portable Vault Mode.
- Drafted MV2 preservation.
- Drafted Privacy defaults (DNT, 3P cookies).
- Drafted ungoogled-chromium style patches (Safe Browsing disabling, domain substitution).
- Drafted initial bobium UI branding overrides.

## Active Focus
All initial patch scaffolding is complete. The application script handles all categories. The next major technical hurdle is creating the robust `fetch-chromium.sh` script to manage the massive `depot_tools` pull, which is currently blocked by sandbox limits.
