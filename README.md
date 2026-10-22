# bobium

bobium is a **patch-and-orchestration repository** for a proposed Chromium
fork: de-Googled, Manifest V2 preserved, with a portable mode. There is no
browser source in this repo and no built binary — what lives here is the
scaffolding intended to assemble one on a heavy local machine:

- `scripts/` — `pre_flight_check.sh`, `fetch-chromium.sh`, `apply-patches.sh`,
  `build.sh`, `package_release.sh`, `validate-patches-dry-run.sh`
- `patches/portable/` and `portable/portable_mode.h` — a "portable vault
  mode" patch and header
- `settings/default_preferences.json` — default preference overrides
- `tests/`, `docs/`, and the usual planning docs (`VISION.md`, `ROADMAP.md`,
  `PROJECT_STATUS_FINAL.json`)

The plan is to fetch upstream Chromium with depot_tools, layer
ungoogled-chromium's de-Googling patches plus bobium's own patches, and
build. `PROJECT_STATUS_FINAL.json` (v0.1.1-alpha) marks the first milestones
"completed" — in repo terms that means the scripts and draft patches are
written, **not** that a bobium browser has been built or released. None has:
there are no releases and no `chromium/` tree here, and the old README's
checked-off feature list (500+ tab handling, tab suspension beating Edge,
portable mode done) describes intentions, not a shipped product. It also
referenced a `scripts/fetch-ungoogled.sh` that does not exist in the repo.

## Building (the intended flow)

Chromium compilation needs a dedicated machine (>150 GB disk, 32 GB+ RAM,
8+ cores, hours for `gclient sync`):

```bash
git clone https://github.com/robertpelloni/bobium
cd bobium
./scripts/pre_flight_check.sh
./scripts/fetch-chromium.sh
./scripts/apply-patches.sh
./scripts/build.sh
./scripts/package_release.sh
```

## Status

Scaffolding only, dormant since the July 2026 checkpoint commits (latest
activity is an automated agent checkpoint, 2026-10-19). Sibling project:
`bobzilla`, the Firefox-fork counterpart, which follows the same
patch-layer-over-upstream pattern.
