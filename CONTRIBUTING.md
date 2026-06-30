# Contributing to bobium

Thank you for your interest in contributing to bobium!

## Core Principles
- Ensure privacy: No Google services, no telemetry.
- Performance is key: Keep tab memory usage low.
- Preserve Manifest V2: Vital for adblockers.

## Workflow
1. Create a patch file for your changes instead of modifying the huge Chromium codebase directly.
2. Place the patch in the appropriate folder under `patches/` (e.g., `patches/privacy/`, `patches/performance/`).
3. Update `scripts/apply-patches.sh` if necessary to apply your new patch.
4. Test locally. Note that compiling Chromium takes a massive amount of disk space (>150GB) and time.

## Submitting Pull Requests
- Provide a clear, descriptive PR title and message.
- Explain "why" you made the change in the patch description.
- Ensure your changes do not break existing patches.
