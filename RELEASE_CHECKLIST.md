# Release Checklist: bobium

Before certifying and distributing a release, ensure the following checklist is completed:

## Pre-Build Orchestration Checks
- [x] Version number is updated in `VERSION.md` (`1.0.0-rc.2`).
- [x] `CHANGELOG.md` is updated with all new patches, features, and build scripts.
- [x] `scripts/fetch-ungoogled.sh` is verified and ready to synchronize upstream patches.
- [x] `scripts/validate-patches-dry-run.sh` passes cleanly across all 6 patch layers.
- [x] Portable mode logic is implemented with cross-platform executable path resolution (`portable/portable_mode.h`).
- [x] Default privacy and tab hibernation preferences configured in `settings/default_preferences.json`.
- [x] Local build and troubleshooting instructions documented in `docs/BUILD_INSTRUCTIONS.md`.
- [x] CI workflow in `.github/workflows/build.yml` configured and secured for self-hosted runners.

## Physical Build & Verification (Local Machine / Dedicated CI Runner)
- [ ] #HANDOFF Run `./scripts/pre_flight_check.sh` on physical machine (>150GB SSD, 32GB+ RAM).
- [ ] #HANDOFF Execute `./scripts/fetch-chromium.sh` to download Chromium source tree.
- [ ] #HANDOFF Execute `./scripts/apply-patches.sh` to apply all patches cleanly to `chromium/src`.
- [ ] #HANDOFF Execute `./scripts/build.sh` to compile Release binary (`chromium/src/out/Release/chrome`).
- [ ] #HANDOFF Execute `./scripts/package_release.sh` to generate artifact packages and SHA-256 signatures.
- [ ] #HANDOFF Execute `./tests/validation/run_all_validations.sh` to certify:
  - Portable vault profile creation without system directory pollution.
  - Manifest V2 extension loading and `webRequest` blocking without deprecation kills.
  - Zero Google telemetry and phone-home pings in net-log.
  - Tab hibernation memory ceilings under multi-tab simulation.
  - Checksum validation against build manifest.
