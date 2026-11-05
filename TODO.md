# TODO: bobium

- [x] Complete MV2 preservation patches (`patches/adblock/0001-preserve-manifest-v2.patch`).
- [x] Complete ungoogled telemetry removal patches (`patches/ungoogled/0001-disable-google-telemetry.patch`).
- [x] Draft initial bobium branding string replacements (`patches/branding/0001-bobium-branding.patch`).
- [x] Implement VFS serialization hooks for TabHibernationManager (`patches/performance/0001-tab-hibernation.patch`).
- [x] Implement fetch script for ungoogled-chromium patch suite (`scripts/fetch-ungoogled.sh`).
- [x] Update patch validation dry-run tool with syntax checking (`scripts/validate-patches-dry-run.sh`).
- [ ] #HANDOFF Execute physical build on dedicated heavy-compute physical machine/runner (requires >150GB free SSD space; current ephemeral environment has 92GB available, failing `pre_flight_check.sh`).
- [ ] #HANDOFF Verify cross-platform patch application against physical Chromium source tree (`chromium/src`) on heavy-compute hardware.
- [ ] #HANDOFF Compile Release binary via `./scripts/build.sh` on dedicated self-hosted build runner.
- [ ] #HANDOFF Execute `./tests/validation/run_all_validations.sh` post-compilation against `chromium/out/Release/chrome`.
