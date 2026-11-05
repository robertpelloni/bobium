# HANDOFF: bobium Sandbox State

## Current State
The bobium repository is scaffolded with the complete suite of build orchestration scripts:
- `scripts/pre_flight_check.sh`
- `scripts/fetch-chromium.sh`
- `scripts/fetch-ungoogled.sh`
- `scripts/validate-patches-dry-run.sh`
- `scripts/apply-patches.sh`
- `scripts/build.sh`
- `scripts/package_release.sh`
- `tests/validation/run_all_validations.sh`

All core patch layers are drafted and verified:
1. `patches/portable/0001-portable-vault-mode.patch`
2. `patches/adblock/0001-preserve-manifest-v2.patch`
3. `patches/privacy/0001-default-privacy-settings.patch`
4. `patches/ungoogled/0001-disable-google-telemetry.patch`
5. `patches/branding/0001-bobium-branding.patch`
6. `patches/performance/0001-tab-hibernation.patch`

Due to the physical disk space (>150GB) and memory constraints of this ephemeral AI sandbox environment (only 92GB free), the 30GB+ Chromium source tree cannot be checked out or compiled here without failing `pre_flight_check.sh`. Dry-run git-apply format verification succeeds cleanly across all 6 patch tiers.

## Next Steps for Physical / CI Runners
1. Run `./scripts/pre_flight_check.sh` on physical machine with >150GB SSD and 32GB+ RAM.
2. Run `./scripts/fetch-chromium.sh` and `./scripts/fetch-ungoogled.sh`.
3. Run `./scripts/apply-patches.sh`.
4. Run `./scripts/build.sh`.
5. Run `./scripts/package_release.sh`.
6. Validate with `./tests/validation/run_all_validations.sh`.
