# bobium Project Handoff

**Version:** `v0.1.0`
**Milestone:** 1 (Core Foundation Complete)

## Current State
All C++ patch files, build orchestration scripts, and project documentation are drafted and structurally validated. Due to ephemeral sandbox constraints, the actual Chromium fetch and compilation must be performed on a dedicated local machine or self-hosted CI runner.

## Prerequisites for Local Build
To execute the pipeline, the host machine MUST meet the following requirements:
*   **Disk Space:** 150GB+ free space (the Chromium source tree alone expands to ~30-40GB; object files require the rest).
*   **RAM:** 32GB minimum recommended (16GB minimum with aggressive swap).
*   **Time:** An 8+ hour compile window depending on CPU core count.
*   **Tools:** `git`, `python3`, `curl`, and standard C++ build essentials (`build-essential`, `ninja-build` depending on OS). The `depot_tools` suite will be fetched automatically.

## Pipeline Run Instructions
1.  **Clone the Repository:**
    `git clone <repo-url> bobium && cd bobium`
2.  **Fetch Source:**
    `./scripts/fetch-chromium.sh`
3.  **Apply Patches:**
    `./scripts/apply-patches.sh`
    *(Ensure there are no "corrupt patch" errors or rejections)*
4.  **Compile:**
    `./scripts/build.sh`

## Post-Build Validation Checkpoints
Once the binary is successfully compiled (located in `chromium/out/Release/`), launch it and manually verify the following:

*   [ ] **Portable Vault Mode:** Verify that user data (profiles, caches) is being saved locally in a `vault/` folder adjacent to the binary, rather than in `~/.config/google-chrome/` or `%LOCALAPPDATA%`.
*   [ ] **Manifest V2 (Ad Blocking):** Install an MV2 extension (e.g., uBlock Origin). Navigate to `chrome://extensions` and verify that no "deprecation warning" banners are displayed.
*   [ ] **Tab Hibernation:** Open multiple tabs, navigate to `chrome://settings/performance`, enable the Memory Cap UI toggle, and verify tabs are aggressively discarding to free memory after the set threshold.
*   [ ] **Privacy Defaults:** Navigate to `chrome://settings/cookies` and verify "Block third-party cookies" is the hardcoded default. Verify no Google Account sign-in prompts appear on first launch.

## Troubleshooting Notes

### 1. depot_tools Setup
If `fetch-chromium.sh` fails with errors related to `python3_bin_reldir.txt not found` or `vpython3` errors, `depot_tools` may not be fully bootstrapped.
*   **Fix:** Manually navigate to the `depot_tools` folder and run `update_depot_tools` or ensure `python3` and `curl` are installed locally before executing the fetch script.

### 2. Patch Conflicts
If `apply-patches.sh` fails due to a "corrupt patch" or "hunk rejected" error:
*   Chromium updates very rapidly. The bobium patches were drafted against a specific snapshot.
*   **Fix:** Navigate to `chromium/src`, reset the tree `git reset --hard HEAD && git clean -fd`, manually open the failing `.patch` file, and apply the logic by hand to the new target source files. Then, regenerate the patch file.
