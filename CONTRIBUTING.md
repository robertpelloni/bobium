# Contributing to bobium

Thank you for your interest in contributing to bobium!

## Core Principles
- Ensure privacy: No Google services, no telemetry.
- Performance is key: Keep tab memory usage low.
- Preserve Manifest V2: Vital for adblockers.
- Portable First: Respect local filesystem bounds without relying on system registries.

## Submitting Feature Patches

### The "Hibernation Engine" (Milestone 4)
When contributing to Tab Hibernation logic, ensure patches:
1.  **Do Not Block the Main Thread:** VFS (Virtual File System) serialization must occur asynchronously to prevent UI lag.
2.  **Respect Memory Limits:** All serialization buffers must remain under a strict memory ceiling before writing to disk.
3.  **Pathing:** Submit performance patches specifically to `patches/performance/`. Use standard unified diff (`git diff`) format against the target Chromium submodule revision.

### "MV2 Forever" (Milestone 3)
When contributing to extension API preservation:
1.  **Do Not Delete Google's Hooks:** Instead of removing complex deprecation logic, force flags (e.g., `base::FEATURE_DISABLED_BY_DEFAULT`) to neuter the warnings. This simplifies upstream rebases.
2.  **Pathing:** Submit ad-blocking patches specifically to `patches/adblock/`.

## Workflow
1. Create a patch file for your changes instead of modifying the huge Chromium codebase directly.
2. Place the patch in the appropriate folder under `patches/` (e.g., `patches/privacy/`, `patches/performance/`).
3. Update `scripts/apply-patches.sh` if necessary to apply your new patch.
4. Test locally. Note that compiling Chromium takes a massive amount of disk space (>150GB) and time.

## Submitting Pull Requests
- Provide a clear, descriptive PR title and message.
- Explain "why" you made the change in the patch description.
- Ensure your changes do not break existing patches.
