# Deployment Validation Checklist

This document serves as the step-by-step verification checklist for executing the bobium build pipeline on a local heavy-compute machine.

## Phase 1: Environment & Dependency Setup
- [ ] **Hardware Verification:** Ensure the host machine has 150GB+ free disk space and at least 32GB of RAM.
- [ ] **OS Dependencies:** Verify that `git`, `python3`, `curl`, `ninja-build`, and `build-essential` (or equivalent) are installed.
- [ ] **Clone Repository:** `git clone <repo_url> bobium && cd bobium`

## Phase 2: Pipeline Dry-Runs & Execution
- [ ] **Fetch Chromium (Dry-Run):**
  * Execute `bash -x scripts/fetch-chromium.sh` to ensure paths and repository commands resolve correctly without failing silently.
  * Verify `depot_tools` clones successfully into the root directory.
  * Verify `chromium/src` begins downloading (this will take hours).
- [ ] **Apply Patches:**
  * Execute `./scripts/apply-patches.sh`.
  * Verify output explicitly confirms: "Applying portable vault mode patch...", "Applying preserve manifest v2 patch...", etc.
  * Verify the final output reads: "Patches applied successfully."
- [ ] **Build Orchestration:**
  * Execute `./scripts/build.sh`.
  * Verify the custom unit tests pass first: `-> Tests passed.`
  * Verify `gn gen` runs successfully without syntax or dependency errors.
  * Wait for `autoninja` compilation to finish.

## Phase 3: Output Artifacts Validation
- [ ] **Binary Location:** Verify the final compiled executable exists at `chromium/src/out/Release/chrome` (or `bobium.exe`).
- [ ] **Artifact Size:** Verify the binary is roughly 200MB - 400MB stripped.
- [ ] **Execution:** Run the binary from the terminal. Verify it launches without immediate segmentation faults or missing dynamic library errors.
