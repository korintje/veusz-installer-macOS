#!/bin/sh -e
# Latest veusz installer script on macOS
# Repository URL: https://github.com/korintje/veusz-installer-macOS

set -eu
dirname=$(dirname $0)
cd ${dirname}
latest_url=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/veusz/veusz/releases/latest)
latest_version=$(basename ${latest_url})
download_url="https://github.com/veusz/veusz/releases/download/${latest_version}/${latest_version}-AppleOSX.dmg"
curl -OL ${download_url}
filepath="${dirname%/}/${latest_version}-AppleOSX.dmg"
xattr -rc "${filepath}"
volname=$(hdiutil mount ${filepath} | tail -n 1 | sed -e 's/.*\/Volumes\///')
volpath="/Volumes/${volname}"
\cp -f -r "${volpath%/}/Veusz.app" /Applications
hdiutil unmount "${volpath}"
rm "${filepath}"
echo "${latest_version} has been successfully installed."
