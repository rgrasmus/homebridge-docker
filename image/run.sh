#!/bin/bash

sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

cd /root/.homebridge

package_file="/root/.homebridge/package.json"
install_file="/root/.homebridge/install.sh"
plugin_folder="/root/.homebridge/plugins"

# Install plugins via package.json
if [ -f "$package_file" ]
then
    echo "$package_file found."
    echo "Going to install additional plugins."

	npm install
else
    echo "$package_file not found."
fi

# Install plugins via install.sh
if [ -f "$install_file" ]
then
    echo "Executing $install_file."

    sh $install_file
else
    echo "$install_file not found."
fi

rm -f /var/run/dbus/pid /var/run/avahi-daemon/pid

dbus-daemon --system
avahi-daemon -D

# Start Homebridge
homebridge -P $plugin_folder
