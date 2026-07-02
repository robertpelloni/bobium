# Release Checklist

Before packaging a release, ensure the following checks are complete:

- [ ] Version number is updated in `VERSION.md`.
- [ ] `CHANGELOG.md` is updated with all new features and fixes.
- [ ] `./scripts/fetch-chromium.sh` runs successfully.
- [ ] `./scripts/fetch-ungoogled.sh` pulls the latest patches.
- [ ] `./scripts/apply-patches.sh` applies all patches cleanly without any merge conflicts.
- [ ] The build succeeds: `./scripts/build.sh`.
- [ ] Portable mode logic is verified.
- [ ] Ensure all Google services (telemetry, Safe Browsing, search sync) are properly stripped.
- [ ] Manifest V2 extensions work correctly.
- [ ] High-tab count (500+) memory footprint is stable.
