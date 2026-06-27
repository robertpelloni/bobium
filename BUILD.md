# bobium Build Instructions

Because Chromium is massive, the build process requires specific configuration.

## 1. Fetching the Source
We rely on `depot_tools`. The `./scripts/fetch-chromium.sh` script automates this, but you must ensure you have at least **150GB of free disk space** and **32GB of RAM**.

## 2. Applying Patches
Always run `./scripts/apply-patches.sh` *after* fetching or syncing the `chromium` submodule and *before* building. This script automatically loops through:
- `patches/portable/`
- `patches/adblock/`
- `patches/privacy/`
- `patches/ungoogled/`
- `patches/branding/`
- `patches/performance/`

## 3. Recommended args.gn
When running `gn gen out/Release`, use the following `args.gn` configuration to strip proprietary codecs, disable Google API keys, and optimize the build for bobium:

```gn
is_debug = false
dcheck_always_on = false
is_component_build = false
symbol_level = 0
blink_symbol_level = 0

# bobium specific
enable_hangout_services_extension = false
enable_mdns = false
google_api_key = ""
google_default_client_id = ""
google_default_client_secret = ""

# Privacy
safe_browsing_mode = 0

# Optimization
use_thin_lto = true
```

## 4. Compilation
Use the provided `build.sh` script, which wraps `gn gen` and `autoninja`:
```bash
./scripts/build.sh
```
