# Configure Killer AX1650 In Debian/Ubuntu 16.04+

At the time of writing this (20th September 2019) Ubuntu 16.04+ does not recognise the Killer AX1650 Wireless adapter out of the box.
This is pretty frustrating but is easily fixable following [the instructions provided by Killer themselves][killer-instructions].

This repository contains a simple script which pulls together the steps in the instructions and automates them.

Usage:

Clone this repository

    git clone https://github.com/eddgrant/configure-killer-ax-1650-wifi-driver.git
    cd configure-killer-ax-1650-wifi-driver
    
'online' mode assumes you've got some form of internet connectivity e.g. Bluetooth/ Wired Networking

    ./configure-killer-ax-1650-wifi-driver.sh online
    
'offline' mode assumes you've previously copied the [backport-iwlwifi][backport-iwlwifi-repository] and [linux-firmware][linux-firmware-repository] repositories to `./backport-wifi` and `./linux-firmware` respectively and simply want to build and install them.

    ./configure-killer-ax-1650-wifi-driver.sh offline

# Warranty

This script comes with absolutely no warranty, please fully read and understand the script before running it. 

# License

This repository applies the [Apache License, Version 2.0][apache-license]

# Improvements

Improvements are welcome by way of pull request.

[backport-iwlwifi-repository]: https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/$backport-iwlwifi.git
[linux-firmware-repository]: git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[killer-instructions]: https://support.killernetworking.com/knowledge-base/killer-ax1650-in-debian-ubuntu-16-04/
[apache-license]: https://www.apache.org/licenses/LICENSE-2.0
