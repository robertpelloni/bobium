# ROADMAP: Strategic Milestones

## Milestone 1: The Core Foundation (v0.1.x) - [HANDOFF READY]
- Establish patch infrastructure and documentation.
- Implement "Portable Vault Mode" to isolate browser state.
- Create script scaffolding for the massive Chromium source fetch.
- *Status: AI Sandbox draft complete. All patches drafted and ready for local build validation.*

## Milestone 2: De-Googling & Independence (v0.2.x) - [HANDOFF READY]
- Merge upstream patches from ungoogled-chromium to completely severe Google telemetry, sync, and safe-browsing reliance.
- Introduce foundational privacy defaults.
- *Status: Patches staged. All patches drafted and ready for local build validation.*

## Milestone 3: Manifest V2 Forever (v0.3.x) - [HANDOFF READY]
- Permanently neuter Google's Manifest V2 deprecation logic.
- Ensure uBlock Origin and other standard MV2 extensions function without warnings.
- *Status: Hooks bypassed via feature flags. All patches drafted and ready for local build validation.*

## Milestone 4: The Hibernation Engine (v0.4.x) - [HANDOFF READY]
- Implement aggressive process snapshotting for tabs.
- Resolve the "500+ tabs" memory crash problem.
- *Status: C++ VFS drafts completed. All patches drafted and ready for local build validation.*

## Milestone 5: Stable Release (v1.0.0)
- End-to-end automated build pipeline.
- Cross-platform binaries (Windows, Linux, macOS).
