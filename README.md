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

## Key Features (Planned & Completed)

### Portable Mode
- [x] Portable vault mode interception (Stores profile locally)

### Privacy
- [x] All Google services stripped (using ungoogled-chromium patches)
- [x] No telemetry
- [x] No safe browsing phone-home (local lists only)
- [x] No Google account integration
- [x] Strict tracking protection

### Ad Blocking
- [x] **Manifest V2 preserved** - webRequest API works
- [ ] Built-in ad blocker (optional, Brave-style)
- [ ] YouTube ad blocking works
- [x] No "Manifest V2 is deprecated" warnings

### Performance
- [x] Tab suspension/hibernation (better than Edge)
- [x] Memory limits per tab via UI
- [x] Handle 500+ tabs gracefully

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
│   ├── adblock/         # MV2 preservation
│   ├── ungoogled/       # Telemetry patches
│   └── branding/        # bobium branding
├── scripts/             # Build orchestration (fetch, apply, build, package)
└── docs/                # Documentation & handoff validation
```

## Quick Start (Build & Validation)

**WARNING:** Chromium compilation is exceptionally heavy. You MUST have 150GB+ of free SSD space and 32GB+ of RAM.

```bash
# 1. Clone bobium
git clone https://github.com/robertpelloni/bobium.git
cd bobium

# 2. Fetch Chromium source and dependencies (takes HOURS)
./scripts/fetch-chromium.sh

# 3. Apply bobium patches
./scripts/apply-patches.sh

# 4. Build
./scripts/build.sh

# 5. Run
./chromium/src/out/Release/chrome
```

See `docs/BUILD_INSTRUCTIONS.md` and `HANDOFF.md` for a complete step-by-step local validation guide.

## License

BSD 3-Clause (inherited from Chromium)
