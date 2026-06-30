# bobium Release Checklist

Before tagging and packaging a stable release, a core maintainer must manually verify the following on a compiled binary (`out/Release/chrome`).

## 1. Core Patches Verification
*   [ ] **Portable Vault Mode:** Launch the binary directly from a terminal. Verify a `vault/` directory is created. Navigate to `chrome://version` and ensure the profile path points to this local directory.
*   [ ] **Manifest V2 Ad Blocking:** Install uBlock Origin. Navigate to `chrome://extensions` and verify no deprecation warning banners are present.
*   [ ] **Privacy Defaults:** Navigate to `chrome://settings/cookies`. Verify "Block third-party cookies" is enabled by default.

## 2. Milestone 4: Tab Hibernation Hooks
*   [ ] **UI Integration:** Navigate to `chrome://settings/performance` and verify the custom bobium Memory Cap controls exist.
*   [ ] **Serialization Test:** Enable the memory cap with a low threshold. Open 20+ media-heavy tabs. Verify via task manager that background tabs are serialized to VFS and purged from active RAM to prevent OOM crashes.
*   [ ] **Restoration Test:** Click on a hibernated tab. Verify it restores seamlessly from the VFS snapshot.

## 3. Telemetry & De-Googling
*   [ ] **Network Monitor:** Launch the browser with a network sniffer (e.g., Wireshark). Verify no IPv6 probes or Safe Browsing telemetry pings are sent to Google servers upon startup.
*   [ ] **Google Sync:** Verify the Google Account sign-in prompts are completely absent from the settings menu and initial launch screens.

## 4. Packaging
*   [ ] **Artifact Generation:** Run `./scripts/package_release.sh`.
*   [ ] **Sanity Check Zip:** Extract the generated `.zip` file and ensure both the binary and the `portable_mode.h` manifest are present.
