#!/bin/bash
set -e

UNGOOGLED_DIR="ungoogled-chromium"
UNGOOGLED_REPO="https://github.com/ungoogled-software/ungoogled-chromium.git"

echo "Fetching ungoogled-chromium dependency..."

if [ ! -d "$UNGOOGLED_DIR" ]; then
    git clone "$UNGOOGLED_REPO" "$UNGOOGLED_DIR"
else
    echo "Updating existing ungoogled-chromium repo..."
    cd "$UNGOOGLED_DIR"
    git fetch origin
    git reset --hard origin/master
    cd ..
fi

echo "Extracting relevant patches to patches/ungoogled..."
mkdir -p patches/ungoogled

# In a real environment, we would copy specific patches from ungoogled-chromium/patches/
# into our patches/ungoogled directory. For bobium, we already have our customized versions
# drafted in the patches directory, so this script just ensures the upstream repo is synced
# for reference or future automated porting.

echo "Ungoogled-chromium dependency updated."
