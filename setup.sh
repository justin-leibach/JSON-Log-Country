#! /bin/bash

# Script to set up system with required dependancies
# needs work

sudo add-apt-repository ppa:maxmind/ppa
sudo apt update

# this installs a "C" extension to increase performance of database lookups
sudo apt install libmaxminddb0 libmaxminddb-dev mmdb-bin

# Keeping this portion commented out, as you should consider setting up a virtual environment in ubuntu (Working copy)
: 'install pip
	(can create a BASH script to do the setup...CONSIDER THIS Bk2 pg 28)
		(can hardcode the topline to auto activate the venv 
			example: #!/home/j/python-envs/jsonLogUtility/bin/python3)
	(may require venv for my machine, look into)
		-sudo apt install python3-venv
		python3 -m venv ~/python-envs/jsonLogUtility
		#change to the new venv
			source ~/python-envs/jsonLogUtility/bin/activate
			(to go back to original environment just use command "deactivate")
		Install all libraries needed once in new venv

		follow instructions here: https://dev.maxmind.com/geoip/geolocate-an-ip/databases/#1-install-the-geoip2-client-library
		# remember to include the -m flag to install pip as a module
			Example: python3 -m pip install geoip2
		1. Install GEOIP library (this is not the database, rather ability to use reader)
			python3 -m pip install geoip2
		2. sudo apt install geoipupdate
		3. create free account @ https://www.maxmind.com/en/geolite2/signup
			- follow instructions in email
			- follow instructions here: https://dev.maxmind.com/geoip/updating-databases
				- Did not set up cronjob
				- to run had to designate the config file when running:
					sudo geoipupdate -f /usr/local/etc/GeoIP.conf -v
                    
Install pip jq (in the venv)
	While in the VENV:
		python3 -m pip install jq
'