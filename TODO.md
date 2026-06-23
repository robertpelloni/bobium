# TODO: Granular Tasks & Immediate Fixes

## Infrastructure & Build
- [x] Create initial patch application scripts (`scripts/apply-patches.sh`)
- [ ] Create robust `fetch-chromium.sh` script to handle depot_tools and huge source download with auto-retries.
- [ ] Set up minimal default preferences (`settings/default_preferences.json`) enforcing DNT.

## Core Patches (Phase 1)
- [x] Draft Portable Vault Mode patch (`patches/portable/0001-portable-vault-mode.patch`)
- [x] Draft Manifest V2 preservation patch (neutralize `extensions::kMV2DeprecationWarning`)
- [ ] Incorporate Ungoogled-Chromium telemetry removal patches.

## UI/UX
- [ ] Remove Google sign-in prompts from Chromium settings UI.
- [ ] Implement initial "bobium" branding assets.
