# VISION: bobium

bobium is a Chromium fork focused strictly on privacy and performance, stripping all Google integration while preserving legacy extension APIs (Manifest V2).

**Core Tenets:**
1.  **De-Googled:** Absolute removal of all Google telemetry, sync services, and API keys.
2.  **Manifest V2 Forever:** Maintenance of the webRequest API to ensure ad blockers continue functioning unhindered.
3.  **Portable by Default:** All user data is stored locally adjacent to the executable. No registry or AppData pollution.
4.  **Performance:** Implementation of a strict Tab Hibernation Engine to serialize DOM states to disk, solving memory hoarding.
