# DEPLOY

## Prerequisites

1.  A dedicated build machine with at least:
    *   150GB Free Disk Space
    *   32GB+ RAM
    *   8+ Core CPU
2.  Supported OS: Linux (Ubuntu 22.04+ recommended), Windows 11, or macOS.
3.  Installed dependencies: `git`, `python3`.

## Deployment Steps

1.  Clone this repository: `git clone --recursive https://github.com/robertpelloni/bobium.git`
2.  Navigate to the repository: `cd bobium`
3.  Run pre-flight checks: `./scripts/pre_flight_check.sh`
4.  Fetch Chromium (this will take a long time): `./scripts/fetch-chromium.sh`
5.  Fetch ungoogled patches: `./scripts/fetch-ungoogled.sh`
6.  Apply patches: `./scripts/apply-patches.sh`
7.  Build the binary: `./scripts/build.sh`
8.  Package the release: `./scripts/package_release.sh`
