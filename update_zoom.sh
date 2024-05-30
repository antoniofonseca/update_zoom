#!/bin/bash

function update_zoom() {
    echo "Checking for Zoom updates..."

    url="https://zoom.us/client/latest/"
    file="zoom_amd64.deb"
    cd ~/Downloads/Install/Software

    echo "Downloading information about the latest Zoom version..."
    wget -qN $url$file

    downloadedVer=$(dpkg -f $file version)
    echo "Latest Zoom version found: $downloadedVer"

    dpkgReport=$(dpkg -s zoom)
    echo "Checking Zoom installation status..."

    echo "$dpkgReport" | grep '^Status: install ok' > /dev/null && \
    installedVer=$(echo "$dpkgReport" | grep ^Version: | sed -e 's/Version: //')

    if [ "$installedVer" != "$downloadedVer" ]; then
        echo "New version of Zoom available. Updating..."
        sudo dpkg -i $file
        echo "New version of Zoom installed."
    else
        echo "Zoom is already up to date."
    fi
}

update_zoom
