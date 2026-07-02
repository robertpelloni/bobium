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

### Portable Mode
- [x] Portable vault mode interception

### Privacy (Day 1)
- [x] All Google services stripped (using ungoogled-chromium patches)
- [x] No telemetry
- [x] No safe browsing phone-home (local lists only)
- [x] No Google account integration
- [ ] Strict tracking protection

### Ad Blocking
- [x] **Manifest V2 preserved** - webRequest API works
- [ ] Built-in ad blocker (optional, Brave-style)
- [ ] YouTube ad blocking works
- [x] No "Manifest V2 is deprecated" warnings

### Performance
- [x] Tab suspension/hibernation (better than Edge)
- [x] Memory limits per tab
- [x] Handle 500+ tabs gracefully
- [ ] Startup optimization

### Portable Mode
- [x] Single folder, run from USB
- [x] Profile stored alongside executable
- [x] No registry/system modifications
- [x] Cross-machine portability

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

### WARNING: Heavy Compute Required
Chromium compilation cannot be done in a lightweight sandbox or CI. It requires a dedicated, heavy-compute physical machine.

- **Storage**: >150GB of free SSD/NVMe space.
- **Memory**: 32GB RAM minimum (64GB recommended to avoid swapping during linker phase).
- **CPU**: 8+ physical cores highly recommended.
- **Time**: 2-8 hours depending on hardware and network speed for `gclient sync`.

### Prerequisites
- OS: Ubuntu 22.04+ (Recommended), macOS 13+, or Windows 11.
- `git` and `python3` installed.
- Compiler toolchains: GCC/Clang (Linux), Xcode (macOS), or Visual Studio 2022 (Windows).

### Local Execution & Validation Guide

The bobium architecture relies on executing a series of specific orchestration scripts to assemble and compile the browser on your heavy-compute machine. **Milestones 1 through 4 are fully drafted and ready for local build validation.**

```bash
# 1. Clone the orchestration hub
git clone --recursive https://github.com/robertpelloni/bobium.git
cd bobium

# 2. Verify local environment prerequisites
./scripts/pre_flight_check.sh

# 3. Fetch upstream Chromium source via depot_tools (Takes HOURS and >30GB disk space)
./scripts/fetch-chromium.sh

# 4. Fetch upstream privacy base patches (ungoogled-chromium)
./scripts/fetch-ungoogled.sh

# 5. Apply the bobium custom C++ patches
./scripts/apply-patches.sh

# 6. Generate ninja files and trigger compilation
./scripts/build.sh

# 7. Package the final release binaries
./scripts/package_release.sh
```

### Expected Outcomes
After a successful build sequence, the executable will be located at `chromium/out/Release/chrome` (or `chrome.exe` on Windows).
To test Portable Vault mode, simply create a blank `.portable` file in the same directory as the executable before launching.

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
