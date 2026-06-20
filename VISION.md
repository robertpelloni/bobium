# VISION.md

## The Ultimate Goal
**bobium** aims to be the universal compatibility king of web browsers—a Chromium fork that completely strips Google surveillance, permanently preserves Manifest V2 for real ad blocking, revolutionizes tab performance, and operates seamlessly via a portable Vault mode. It is the pragmatic counterpart to `bobzilla` (the Firefox fork) within the bob software ecosystem.

## Core Foundational Concepts

### 1. Radical Privacy Without Compromise
Chromium is fast and universally compatible, but heavily entrenched in Google's telemetry, account sync, and centralized Safe Browsing. **bobium** leverages ungoogled-chromium patches and native integrations to rip out all phone-home mechanics, ensuring absolute local control over data.

### 2. The Ad-Blocking Imperative (Manifest V2 Forever)
Google's push to Manifest V3 neuters effective ad blockers like uBlock Origin. **bobium** takes a hardline stance: Manifest V2's `webRequest` API will be preserved natively. If upstream Chromium forcibly removes it, **bobium** will implement an abstraction layer or fallback to a built-in WASM-based adblock engine (Brave-style) to ensure YouTube and pervasive trackers are blocked permanently.

### 3. Hyper-Optimized Resource Management
Modern browsers fail under the weight of 400+ tabs. **bobium** aims to rethink memory management with a native "Hibernation Engine"—writing long-inactive tab states to disk and killing their memory footprints entirely, allowing users to keep thousands of tabs open without slowing down the OS.

### 4. Portable Freedom (The Vault)
A browser should not be tied to an OS registry or AppData folder. **bobium** features a "Vault Mode" inspired by Vivaldi, allowing the entire browser (executables, profiles, history, and extensions) to live in a single directory, run directly from a USB stick, and optionally feature AES-256 encryption.

## User-Satisfaction Design
*   **Zero-Config Security:** Privacy features (DNT, tracking protection, ad blocking) are on by default. No hidden menus.
*   **The "bob" Convergence:** A unified sidebar integrates the broader ecosystem (Bobfilez, Bobtrax, Brobocallz), making the browser a centralized operating environment.
*   **Absolute Transparency:** Telemetry is completely disabled. Any required network diagnostics will be explicitly opt-in and utilize fully homomorphic encryption to ensure zero-knowledge data gathering.
