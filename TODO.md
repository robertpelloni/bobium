# bobium TODO List

## Core Architecture
- [ ] Implement `patches/portable/0001-portable-vault-mode.patch` (Needs `base::PathService` intercept).
- [ ] Implement `patches/adblock/0001-preserve-manifest-v2.patch` (Disable deprecation flags).
- [ ] Implement `patches/privacy/0001-default-privacy-settings.patch` (Hardcode DNT and 3P cookie blocks).
- [ ] Implement `patches/ungoogled/` suite (Disable safe browsing, remove Google sync, strip API keys).
- [ ] Implement `patches/branding/0001-bobium-branding.patch`.
- [ ] Implement `patches/performance/` suite (Tab hibernation engine with VFS serialization).

## Critical Unresolved Patch Compatibility Gaps
- **Missing Upstream Dependencies:** The standalone helper `portable_mode.h` was successfully patched into `chrome_main_delegate.cc` but relies on `exe_dir.AsUTF8Unsafe()`, which is a Windows-specific Chromium string casting feature. We need to verify cross-platform (`std::string` vs `std::wstring`) behavior before merging.
- **GN Build Linking:** Ensure that all header-only libraries are actually included in the ninja targets and not pruned by aggressive LTO (Link Time Optimization) stripping before full 30GB Chromium compilation.
