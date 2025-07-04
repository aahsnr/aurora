#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

## Pins and Overrides
## Use this section to pin packages in order to avoid regressions
# Remember to leave a note with rationale/link to issue for each pin!
# Use dnf list --showduplicates package

# Workaround atheros-firmware regression
# see https://bugzilla.redhat.com/show_bug.cgi?id=2365882
dnf -y swap atheros-firmware atheros-firmware-20250311-1$(rpm -E %{dist})

# Workaround for kscreenlocker regression
# see https://bugzilla.redhat.com/show_bug.cgi?id=2375356
dnf -y downgrade qt6-qtwayland-6.9.1-1$(rpm -E %{dist})


# Current aurora systems have the bling.sh and bling.fish in their default locations
mkdir -p /usr/share/ublue-os/aurora-cli
cp /usr/share/ublue-os/bling/* /usr/share/ublue-os/aurora-cli

# Try removing just docs (is it actually promblematic?)
rm -rf /usr/share/doc/just/README.*.md

echo "::endgroup::"
