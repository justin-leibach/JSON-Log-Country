# JSON-Log-Country

This repo is for use with log files created by a dshield honeypot, for use in the SANS Internet Storm Center.

Overall improvement needs to be made for excluding AWS sip's

## setup.sh
This is a bash script to set your debian based linux distro.
If using Ubuntu, I recommend creating a VENV for module installation. Instructions will be added here:
Section and script a work in progress

## combine-JSON.sh
This bash script is an easy way to combine a large number of JSON files from a single directory into a single file.
Requires the jq (jquery utility to be installed)
    - JQ github: https://github.com/jqlang/jq
    - Debian: sudo apt install jq
    - RPM (CentOS, Fedora): sudo yum install jq
    - DNF (Fedora => v22): sudo dnf install jq
    - Arch -= sudo pacman -S jq
The output of this is immediately able to be queried and filtered with jq in the command line.

## filter.sh
This bash script will take the source ip form the **combine-JSON.sh** script and create a .csv file for use.

## CountryLookup.py
This python script is a work in progress, and can currently do this:
    - [x] open (and close) the .csv file created by **filter.sh** and write it to a python list
    - [ ] iterate through GEOIP to populate a country list, and count occurences
    - [ ] create a dictionary with the key:value of country:count
    - [ ] create a graphical representation of all countries






