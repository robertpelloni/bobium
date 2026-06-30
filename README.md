# bobium

**Chromium, but less evil.**

A Chromium fork that strips Google surveillance, preserves Manifest V2 for real ad blocking, fixes Edge's tab hoarding problems, and includes Vivaldi-style portable mode.

*Part of the bob software ecosystem by Robert Pelloni.*

## Vision

Chromium won the browser engine war. But Google controls it, and that's a problem:
- **Manifest V3** killed effective ad blocking (especially YouTube)
- **Telemetry everywhere** - Google knows every site you visit
- **Edge inherited Chromium's flaws** and added Microsoft telemetry on top
- **400+ tabs** shouldn't crash a browser in 2026

**bobium** aims to:
1. **Preserve Manifest V2** - Full webRequest API, forever
2. **Strip all Google services** - No telemetry, no safe browsing phone-home, no account integration
3. **Fix tab performance** - Handle 500+ tabs without choking
4. **Portable mode** - Run from USB like Vivaldi
5. **Built-in ad blocking** - Brave-style, but optional
6. **Cherry-pick the best** from Edge, Vivaldi, Brave, Ungoogled-Chromium

## Why Both bobzilla AND bobium?

| bobzilla (Firefox) | bobium (Chromium) |
|-------------------|-------------------|
| Gecko engine | Blink engine |
| True engine diversity | Site compatibility |
| SpiderMonkey JS | V8 JS (faster) |
| Better memory usage | Better raw performance |
| Privacy DNA | Need to add privacy |
| Manifest V2 native | Need to restore MV2 |

**Use bobzilla for privacy. Use bobium for compatibility. Both for maximum bob.**

## Upstream Sources

| Source | What We Take |
|--------|--------------|
| **Chromium** | Base browser, Blink, V8 |
| **Ungoogled-Chromium** | Google service removal patches |
| **Brave** | Ad blocking approach, privacy features |
| **Vivaldi** | Portable mode implementation, UI ideas |
| **Edge** | What NOT to do (but maybe sleeping tabs) |

## Key Features (Planned)

### Privacy (Day 1)
- [ ] All Google services stripped (using ungoogled-chromium patches)
- [ ] No telemetry
- [ ] No safe browsing phone-home (local lists only)
- [ ] No Google account integration
- [ ] Strict tracking protection

### Ad Blocking
- [ ] **Manifest V2 preserved** - webRequest API works
- [ ] Built-in ad blocker (optional, Brave-style)
- [ ] YouTube ad blocking works
- [ ] No "Manifest V2 is deprecated" warnings

### Performance
- [ ] Tab suspension/hibernation (better than Edge)
- [ ] Memory limits per tab
- [ ] Handle 500+ tabs gracefully
- [ ] Startup optimization

### Portable Mode
- [ ] Single folder, run from USB
- [ ] Profile stored alongside executable
- [ ] No registry/system modifications
- [ ] Cross-machine portability

### UI/UX
- [ ] Clean, minimal default
- [ ] Vertical tabs option
- [ ] Tab grouping improvements
- [ ] Customizable new tab page (no sponsored garbage)

## Repository Structure

```
bobium/
├── chromium/            # Chromium source (submodule, ~30GB)
├── patches/
│   ├── privacy/         # Google service removal
│   ├── performance/     # Tab/memory improvements
│   ├── adblock/         # MV2 preservation, built-in blocking
│   ├── ui/              # UI customizations
│   └── branding/        # bobium branding
├── portable/            # Portable mode implementation
├── settings/            # Default preferences
├── scripts/             # Build automation
└── docs/                # Documentation
```

## Building

### WARNING: Chromium is HUGE
- **Source**: ~30GB download, ~100GB with build
- **Build time**: 2-8 hours depending on hardware
- **RAM**: 32GB+ recommended
- **Disk**: 150GB+ free space

### Prerequisites
- Python 3
- Git
- Visual Studio 2022 (Windows) / Xcode (Mac) / GCC (Linux)
- depot_tools (Google's build tools)

### Quick Start

```bash
# Clone bobium
git clone --recursive https://github.com/robertpelloni/bobium.git
cd bobium

# Fetch Chromium source (this takes HOURS)
./scripts/fetch-chromium.sh

# Apply bobium patches
./scripts/apply-patches.sh

# Build
./scripts/build.sh

# Run
./out/Release/bobium
```

## The Manifest V2 Question

Google deprecated MV2 to kill ad blockers. Can we keep it?

### Technical Reality
- MV2 code still exists in Chromium (for enterprise)
- Extensions API is in `chrome/browser/extensions/`
- webRequest API is in `extensions/browser/api/web_request/`
- Google added kill switches and deprecation warnings

### Our Approach
1. Remove deprecation warnings/timers
2. Keep webRequest blocking capability
3. Don't remove MV2 code when rebasing
4. May need to maintain extension API ourselves long-term

### Risk
- Google may fully remove MV2 code eventually
- We'd need to maintain a fork of the extensions system
- Ungoogled-Chromium community may help

## Related Projects

- [bobzilla](../bobzilla) - Firefox fork (the other browser)
- [raindropioapp](../raindropioapp) - Bookmark manager (integrates with bobium)
- [bobcoin](../bobcoin) - Cryptocurrency
- [bob's game](https://bobsgame.com) - The game

## Philosophy

1. **Your browser, your rules** - No corporate surveillance
2. **Ads are a choice** - Block them if you want
3. **Tabs are cheap** - 500 tabs shouldn't kill your PC
4. **Portable freedom** - Take your browser anywhere
5. **Absurdist branding** - It's called bobium, embrace the chaos

## License

BSD 3-Clause (inherited from Chromium)

---

*"In a world of Chrome clones, be a bobium."*
