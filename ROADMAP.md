# ROADMAP.md

## Phase 1: Foundation & Bootstrapping
- **Chromium Submodule Integration**: Setup depot_tools, sync the massive Chromium source repository.
- **Initial Build Pipeline**: Automate the build process using GN and Ninja via robust scripts.
- **Google Service Decoupling**: Apply ungoogled-chromium patches to strip telemetry, account integration, and Safe Browsing phone-home.

## Phase 2: Core Privacy & Ad-Blocking
- **Manifest V2 Preservation Layer**: Disable Google's MV2 deprecation flags, ensure `webRequest` remains fully functional.
- **Legacy Bridge Architecture**: Implement an isolated extension subsystem to permanently support MV2, mapping legacy calls to new internal APIs if upstream code is removed.
- **WASM-Based Native Ad-Blocker**: Integrate Brave's Rust-based ad-blocking engine as a high-performance fallback for MV2.

## Phase 3: Performance & Resource Management
- **The "Hibernation" Engine**: Implement full process snapshotting for tabs inactive for long periods, writing DOM to disk to free 100% of memory.
- **Resource-Gated Rendering**: Introduce CPU limits per domain to prevent heavy background scripts from locking the browser.

## Phase 4: Portability & Ecosystem Integration
- **Portable "Vault" Mode**: Vivaldi-style USB portable mode with AES-256 workspace encryption for total security on-the-go.
- **Bob Ecosystem Convergence**: Integrate Bobcoin for privacy milestones, add a sidebar for Bobfilez, Bobtrax, and Brobocallz.

## Phase 5: Autonomous Security & Maintenance
- **Local P2P Safe Browsing**: Develop a decentralized DHT for malicious domain blocklists, bypassing centralized authorities.
- **Automated "Patch Sync"**: Implement a background agent to autonomously backport privacy patches from upstream privacy forks.
