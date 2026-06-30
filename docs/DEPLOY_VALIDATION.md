# DEPLOY VALIDATION

After a successful deployment, the following must be verified:

1.  **Binary Exists**: The compiled binary (`bobium` or `bobium.exe`) must be present in `chromium/out/Release/`.
2.  **Portable Mode**: Creating a `.portable` file in the same directory as the binary and running it should result in the profile being stored in a local `bobium_profile` folder instead of the system default location.
3.  **No Google Services**: The settings page should not contain options to sign in to Google.
4.  **Ad-Blocking**: Manifest V2 extensions like uBlock Origin should install and function correctly without any "deprecated" warnings.
5.  **Performance**: Test with a large number of tabs (e.g., 500+) to ensure hibernation logic is active and memory usage remains low.
