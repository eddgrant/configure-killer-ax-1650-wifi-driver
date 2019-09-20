#!/usr/bin/env bash

set -e

FIRMWARE_DIRECTORY="/lib/firmware/"
BACKPORT_IWLWIFI_DIRECTORY="backport-iwlwifi"

clone_or_update_repo() {
	REPOSITORY_ADDRESS="$1"
	LOCAL_DIRECTORY="$2"

	echo "Cloning/ updating repository with address ${REPOSITORY_ADDRESS} to directory ${LOCAL_DIRECTORY}"

	if [[ -d ${LOCAL_DIRECTORY} ]]; then
		echo "Repository already cloned, will update."
		cd "${LOCAL_DIRECTORY}"
		git fetch --all --prune --depth 1
		git pull --rebase --depth 1
		echo "Repository updated successfully."
		cd -
	else
		echo "Repository not present locally, will clone." 
		git clone --depth 1 "${REPOSITORY_ADDRESS}" "${LOCAL_DIRECTORY}"
		echo "Repository successfully cloned."
	fi
}

usage() {
  echo "Usage: $0 offline|online"
  echo "offline mode can be used to rebuild existing local source."
  echo "online mode can be used to clone/ update the remote repositories before building the source."
  exit 1
}

# Main script body.
if [[ $# != 1 ]]; then
  usage
else 
  MODE="$1"
fi
echo "Running in ${MODE} mode."

if [[ "${MODE}" == "online" ]]; then
	sudo apt-get install -y git build-essential
	clone_or_update_repo "https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/${BACKPORT_IWLWIFI_DIRECTORY}.git" "${BACKPORT_IWLWIFI_DIRECTORY}"
	clone_or_update_repo "git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git" "linux-firmware"
elif [[ "${MODE}" != "offline" ]]; then
	usage
fi	

cd "${BACKPORT_IWLWIFI_DIRECTORY}"
make defconfig-iwlwifi-public
make -j4
sudo make install
echo "Successfully built and installed backport-iwlwifi"
cd ../		

cd linux-firmware
sudo cp iwlwifi-* "${FIRMWARE_DIRECTORY}"
echo "Copied iwlwifi drivers to ${FIRMWARE_DIRECTORY}."
cd ../

echo "Completed successfully, please reboot to load new Wifi firmware."
