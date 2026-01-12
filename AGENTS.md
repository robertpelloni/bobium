# AGENTS.md

**Generated:** 2026-01-12 | **Branch:** main | **Version:** 0.1.0

## Overview

**bobium** - Chromium fork focused on privacy (no Google), preserved Manifest V2 for ad blocking, improved tab performance, and portable mode. Part of the bob software ecosystem.

## Structure

```
bobium/
├── README.md            # Project overview
├── AGENTS.md            # This file
├── chromium/            # Chromium source (submodule, HUGE ~30GB)
├── patches/             # Organized by category
├── portable/            # USB/portable mode implementation
├── settings/            # Default preferences
├── scripts/             # Build automation
└── docs/                # Technical documentation
```

## Build System

Chromium uses:
- **GN** (Generate Ninja) for build configuration
- **Ninja** for actual building
- **depot_tools** for source management
- **gclient** for dependency management

## Key Concepts

1. **Patch-based approach** - Don't modify Chromium directly; maintain patches
2. **Ungoogled-chromium patches** - Start with their Google removal work
3. **MV2 preservation** - Critical for ad blocking, maintain extension APIs
4. **Portable mode** - Profile alongside executable, no system changes

## Upstream Repos

| Source | URL | Purpose |
|--------|-----|---------|
| Chromium | chromium.googlesource.com/chromium/src | Base browser |
| Ungoogled-Chromium | github.com/ungoogled-software/ungoogled-chromium | De-Googling patches |
| Brave | github.com/brave/brave-browser | Ad blocking reference |
| Vivaldi | vivaldi.com | Portable mode reference |

## Development Workflow

1. Set up depot_tools
2. Fetch Chromium source (~30GB, takes hours)
3. Apply patches: `./scripts/apply-patches.sh`
4. Configure: `gn gen out/Release`
5. Build: `autoninja -C out/Release chrome`
6. Test: `./out/Release/chrome`

## LLM Instructions

- Chromium source is MASSIVE (30GB+). Never try to read it all.
- Focus on patches/ directory for our modifications
- Use GN for build config, not makefiles
- Patches should be atomic and well-documented
- Test on Windows, Linux, macOS
- The extension API code is in `chrome/browser/extensions/` and `extensions/`
