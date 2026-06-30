# Contributing to bobium

Thank you for your interest in contributing to bobium! Since bobium is a patch-based Chromium fork, the development workflow differs from standard projects.

## Core Development Philosophy
1.  **Edit the Patches, Not the Source Directly:** All core logic (Manifest V2 preservation, portable vault hooks, tab hibernation) is maintained as `.patch` files in the `patches/` directory. You should modify the Chromium source tree locally, test your changes, and then use `git diff` to generate the new patch file.
2.  **Upstream Drift:** Chromium updates rapidly. If an upstream update breaks a bobium patch, contributors must manually resolve the merge conflict in `chromium/src` and regenerate the patch file.
3.  **Privacy First:** No Google API keys, no telemetry, no tracking. Ensure all new features align with the core vision of "de-googling" the browser.

## Setting Up Your Environment
Because Chromium is massive, you must have a heavy-compute machine to contribute effectively:
*   **Disk Space:** 150GB+ of free SSD space.
*   **RAM:** 32GB+ (64GB recommended).
*   **CPU:** 8+ cores.
*   **Tools:** `depot_tools` must be installed and in your `$PATH`.

Follow the `docs/BUILD_INSTRUCTIONS.md` guide to execute `fetch-chromium.sh` and `apply-patches.sh`.

## Submitting Pull Requests
1.  Ensure all your custom C++ logic is contained within header-only libraries (e.g., `portable_mode.h`) or cleanly integrated into the existing patch files. Avoid modifying Chromium's `BUILD.gn` files unless absolutely necessary to prevent linker errors and build fragility.
2.  Run the local unit tests via `./scripts/build.sh`.
3.  Ensure your PR does not trigger the GitHub Actions workflow unless you are confident in your changes, as self-hosted runners are resource-intensive.
