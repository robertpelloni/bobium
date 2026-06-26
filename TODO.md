# TODO: Granular Tasks & Immediate Fixes

## Infrastructure & Build
- [x] Create initial patch application scripts (`scripts/apply-patches.sh`)
- [x] Create robust `fetch-chromium.sh` script to handle depot_tools and huge source download with auto-retries.
- [x] Set up minimal default preferences (`settings/default_preferences.json`) enforcing DNT.
- [x] Setup script for fetching ungoogled-chromium patches.
- [x] Finalize `build.sh` script to orchestrate the GN and ninja build process.

## Core Patches (Phase 1)
- [x] Draft Portable Vault Mode patch (`patches/portable/0001-portable-vault-mode.patch`)
- [x] Draft Manifest V2 preservation patch (neutralize `extensions::kMV2DeprecationWarning`)
- [x] Incorporate Ungoogled-Chromium telemetry removal patches.
- [x] Expand ungoogled-chromium patch set to cover all domain substitutions and safe-browsing removals.

## UI/UX
- [x] Remove Google sign-in prompts from Chromium settings UI.
- [x] Implement initial "bobium" branding assets.

## Performance (Phase 2)
- [x] Draft initial Tab Hibernation Engine interception points.
- [x] Implement VFS logic for writing serialized DOM state to disk.
- [x] Add UI controls for setting memory caps per tab.
- [x] Wire Tab Manager discard triggers to UI memory caps.
- [x] Implement tab snapshot restoration hooks.
