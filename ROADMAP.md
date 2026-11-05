# ROADMAP: bobium

## Milestone 1: Core Foundation (Completed)
- Establish patch engine and build orchestration scripts (`fetch-chromium.sh`, `apply-patches.sh`, `build.sh`).
- Implement Portable Vault mode (`portable/portable_mode.h`, `patches/portable/0001-portable-vault-mode.patch`).

## Milestone 2: De-Googling (Completed)
- Remove Safe Browsing telemetry (`patches/ungoogled/0001-disable-google-telemetry.patch`).
- Strip Google Account Sync and metrics reporting.
- Implement automated ungoogled patch fetcher (`scripts/fetch-ungoogled.sh`).
- Set privacy-first defaults (`patches/privacy/0001-default-privacy-settings.patch`).

## Milestone 3: Manifest V2 Preservation (Completed)
- Disable deprecation flags and warning banners in `extension_features.cc` and `manifest_v2_experiment_manager.cc` (`patches/adblock/0001-preserve-manifest-v2.patch`).
- Retain full synchronous `webRequest` API support.

## Milestone 4: Hibernation Engine (Completed)
- Wire `TabLifecycleUnit` to asynchronous VFS DOM serialization hooks (`patches/performance/0001-tab-hibernation.patch`).
- Maintain memory boundaries under massive multi-tab loads.

## Milestone 5: Stable Release & Heavy-Compute Validation (Active)
- Establish CI pipelines (`.github/workflows/bobium-ci.yml`) on self-hosted runners.
- Execute physical compilation on dedicated machine (>150GB SSD, 32GB+ RAM).
- Run post-build validation suite (`tests/validation/run_all_validations.sh`).
- Cross-platform binary packaging and distribution.
