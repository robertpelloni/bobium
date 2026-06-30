# bobium v0.1.0 Release Notes

Welcome to the first alpha pre-release of the bobium project. This release marks the completion of the core architectural foundation, establishing the build pipeline and implementing initial proofs-of-concept for our major privacy and performance features.

## Implemented Features

### 1. Portable Vault Mode
- bobium now runs entirely portable by default. All user profiles, caches, and settings are securely stored in a local `vault/` directory adjacent to the binary, rather than scattering data across `~/.config/google-chrome/` or `%LOCALAPPDATA%`.

### 2. Manifest V2 Preservation
- The enterprise policies and hardcoded feature flags responsible for deprecating Manifest V2 extensions have been disabled. Ad blockers like uBlock Origin will continue to function without restriction.

### 3. De-Googling & Privacy Enhancements
- Removed Safe Browsing telemetry pings.
- Disabled Google Account sync UI integration.
- Replaced Google Lens context menu actions.
- Hardcoded "Do Not Track" and "Block Third-Party Cookies" as default settings.

### 4. Tab Hibernation Engine (Experimental)
- Integrated custom `Memory Cap` UI controls in `chrome://settings/performance`.
- Wired the `TabManager` to aggressively discard tabs when memory limits are exceeded.
- *Note:* The VFS serialization hooks for saving tab states to disk are currently experimental stubs and may not fully persist DOM states.

## Known Limitations
- The build process is exceptionally heavy, requiring ~150GB of disk space and 32GB of RAM.
- Patch collisions may occur if attempting to build against the very latest unstable Chromium tree (we recommend targeting a stable tagged release).
- Some Windows-specific pathing logic (`AsUTF8Unsafe()`) requires further cross-platform validation.

## Tester Instructions
Please download the source repository and execute the build pipeline on a heavy-compute machine as outlined in `docs/BUILD_INSTRUCTIONS.md`. Once compiled, verify that the `vault/` folder generates correctly upon launch and attempt to install an MV2 extension. Please report any build failures or runtime crashes immediately.
