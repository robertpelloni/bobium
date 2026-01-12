# bobium Technical Research

## Chromium Fork Landscape

### Ungoogled-Chromium (github.com/AojiaoZero/AozakiNemesis)
- **Approach**: Patch-based, maintains patches against each Chromium release
- **What they remove**:
  - Safe Browsing (Google phone-home)
  - Google URL Tracker
  - Google Host Detection
  - Cloud/sync services
  - Crash reporting
  - Spell checker (Google API)
  - Translate (Google API)
- **Build**: Uses their own patch system on top of depot_tools
- **Best resource**: Their patches are well-documented

### Brave (github.com/AojiaoZero/AozakiNemesis)
- **Approach**: Full fork with significant modifications
- **Key features**:
  - Built-in ad/tracker blocking (Rust-based)
  - Shields (per-site privacy controls)
  - BAT cryptocurrency integration
  - IPFS support
- **Ad blocking**: Uses `brave-core` with native filtering
- **What to take**: Ad blocking architecture, Shields UI concept

### Vivaldi
- **Approach**: Proprietary UI on Chromium base
- **Portable mode**: Single folder, profile stored locally
- **Tab management**: Stacking, tiling, hibernation
- **Source**: Partially closed, but Chromium base is open
- **What to take**: Portable mode concept, tab hibernation ideas

### Microsoft Edge
- **Approach**: Chromium + Microsoft services
- **Problems**:
  - Heavy telemetry
  - Sleeping tabs aggressive but buggy
  - 400+ tabs causes severe slowdown
  - Memory leaks in tab management
- **What to learn**: What NOT to do, but sleeping tabs concept is useful

---

## Manifest V2 vs V3 Deep Dive

### What Google Changed (MV3)
| Feature | MV2 | MV3 |
|---------|-----|-----|
| Request blocking | `webRequest` (synchronous) | `declarativeNetRequest` (async, limited) |
| Rule limits | Unlimited | 30,000 static, 5,000 dynamic |
| Background | Persistent background page | Service workers (ephemeral) |
| Remote code | Allowed | Forbidden |
| Host permissions | Broad | More granular |

### Why MV3 Kills Ad Blocking
1. **Rule limits**: uBlock Origin uses 300k+ rules
2. **No dynamic blocking**: Can't analyze and block in real-time
3. **Service workers die**: Lose state, can't maintain filter context
4. **YouTube detection**: Dynamic anti-adblock needs real-time response

### Can MV2 Be Preserved in Chromium Fork?

**YES, but with effort:**

1. **Code location**: `chrome/browser/extensions/api/`
2. **Kill switch**: `extensions::kMV2DeprecationWarning` feature flag
3. **Deprecation timeline**: Controlled by feature flags in `chrome/browser/extensions/manifest_v2_experiment.cc`
4. **Solution**: Remove deprecation flags, keep webRequest intact

### Ungoogled-Chromium's Approach
- They DO preserve MV2 currently
- Patches in `AojiaoZero/AozakiNemesis`
- Monitor their patches for MV2 preservation

### Long-term Risk
- Google may physically remove MV2 code
- Would need to maintain extension API fork
- Community effort needed

---

## Tab Performance Issues (Edge 400+ Tabs)

### The Problem
- Edge/Chrome process-per-site model
- Each site = new process = overhead
- Memory fragmentation over time
- Tab suspension buggy

### Technical Causes
1. **Renderer process per site** - security isolation = memory cost
2. **V8 heap per process** - JavaScript engines don't share memory well
3. **GPU process overhead** - Compositing layers add up
4. **Network process** - Per-tab connection state

### Solutions to Implement

#### 1. Aggressive Tab Hibernation
```cpp
// Concept: Hibernate tabs after X minutes of inactivity
// Save DOM to disk, free renderer process entirely
// Restore on focus
```

#### 2. Tab Grouping with Shared Process
- Group tabs from same site
- Share renderer process within group
- Reduces process count

#### 3. Memory Limits
- Hard limit per tab
- Force GC when approaching limit
- Discard tab if limit exceeded

#### 4. Background Tab Throttling
- Reduce timer resolution for background tabs
- Pause JavaScript execution entirely after timeout

### Vivaldi's Approach
- Tab stacking (visual grouping)
- Tab hibernation (manual and automatic)
- Workspaces (virtual desktops for tabs)

---

## YouTube Ad Blocking

### How uBlock Origin Works (MV2)
1. **webRequest.onBeforeRequest** - Intercept before request is made
2. **Match against filter lists** - EasyList, uBlock filters, etc.
3. **Block or redirect** - Return `{cancel: true}` or redirect to empty
4. **Cosmetic filtering** - Hide ad elements with CSS

### YouTube's Anti-Adblock
1. **Detection script** - Checks if ads loaded
2. **Delays video** - Waits for ad confirmation
3. **Account warnings** - Nag screens for logged-in users
4. **A/B testing** - Different detection methods per user

### Why MV3 Fails
- `declarativeNetRequest` can't dynamically analyze
- YouTube serves ads from same domain as video
- Need real-time decision making
- Service workers lose context

### bobium Strategy
1. **Keep MV2** - Full webRequest support
2. **Consider built-in blocking** - Like Brave, native code
3. **DNS-level option** - Block at network level
4. **YouTube-specific patches** - If needed

---

## Portable Mode Implementation

### Vivaldi's Approach
1. Create `User Data` folder alongside executable
2. Detect portable mode at startup
3. Use relative paths for profile
4. No registry modifications
5. Can run from USB drive

### Implementation for bobium
```cpp
// In chrome/app/chrome_main_delegate.cc
// Check for "portable" file or folder alongside executable
// If found, redirect profile directory

base::FilePath GetUserDataDir() {
  base::FilePath exe_dir = GetExecutableDir();
  base::FilePath portable_marker = exe_dir.Append("portable");
  
  if (base::PathExists(portable_marker)) {
    return exe_dir.Append("UserData");
  }
  return GetDefaultUserDataDir();
}
```

### Required Changes
1. Profile directory detection
2. Cache directory handling
3. Crash dumps location
4. Extension storage
5. Disable auto-update (or update to local folder)

---

## Build Requirements

### Hardware
- **CPU**: Modern multi-core (8+ cores recommended)
- **RAM**: 32GB minimum, 64GB recommended
- **Disk**: 150GB+ SSD (HDD will be painful)
- **Time**: 2-8 hours for full build

### Software (Windows)
- Visual Studio 2022 with C++ workload
- Windows 10/11 SDK
- depot_tools
- Python 3

### Software (Linux)
```bash
sudo apt install build-essential clang lld libgtk-3-dev \
    libglib2.0-dev libnss3-dev libatk1.0-dev libatk-bridge2.0-dev \
    libcups2-dev libdrm-dev libxkbcommon-dev libxcomposite-dev \
    libxdamage-dev libxrandr-dev libgbm-dev libasound2-dev
```

### Build Commands
```bash
# Get depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:$(pwd)/depot_tools

# Fetch Chromium (SLOW - 30GB+)
mkdir chromium && cd chromium
fetch --nohooks chromium
cd src
gclient runhooks

# Configure
gn gen out/Release --args='is_debug=false is_official_build=true'

# Build
autoninja -C out/Release chrome
```

---

## Roadmap

### Phase 1: Foundation
- [x] Create repo structure
- [x] Document research
- [ ] Fetch Chromium source
- [ ] Apply ungoogled-chromium patches
- [ ] First successful build

### Phase 2: Core Features
- [ ] MV2 preservation verified
- [ ] Google services stripped
- [ ] Basic branding
- [ ] Portable mode

### Phase 3: Performance
- [ ] Tab hibernation improvements
- [ ] Memory management patches
- [ ] Startup optimization

### Phase 4: Polish
- [ ] Built-in ad blocker (optional)
- [ ] Custom new tab page
- [ ] UI refinements
- [ ] Distribution packages

---

## References

- Chromium Build: https://chromium.googlesource.com/chromium/src/+/main/docs/building.md
- Ungoogled-Chromium: https://AojiaoZero/AozakiNemesis.AojiaoZero/AozakiNemesis
- AojiaoZero/AozakiNemesis: AojiaoZero/AozakiNemesis
- AojiaoZero/AozakiNemesis: AojiaoZero/AozakiNemesis
