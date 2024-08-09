#! /bin/bash

# Script to set up system with required dependancies

sudo add-apt-repository ppa:maxmind/ppa
sudo apt update

# this installs a "C" extension to increase performance of database lookups
sudo apt install libmaxminddb0 libmaxminddb-dev mmdb-bin

# Consider installing all of this in a VENV (virtual Environment) if running certain distros of linux.
sudo apt install python3-pip
sudo apt update
python3 -m pip install numpy geoip2 pandas openpyxl pillow

#### follow instructions here: https://dev.maxmind.com/geoip/geolocate-an-ip/databases/#1-install-the-geoip2-client-library ####

sudo apt install geoipupdate
######################## create free account @ https://www.maxmind.com/en/geolite2/signup ##################################
: 'follow instructions in email
	- follow instructions here: https://dev.maxmind.com/geoip/updating-databases
	- can set up cronjob
	- to run had to designate the config file when running:'
		#### sudo geoipupdate -f /usr/local/etc/GeoIP.conf -v ####
                    