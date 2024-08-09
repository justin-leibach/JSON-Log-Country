# JSON-Log-Country

This repo is for use with log files created by a dshield honeypot, for use in the SANS Internet Storm Center.

External libraries required (and available from pip): 
            - numpy
            - geoip2
            - matplotlib

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

## filter-with-exclude.sh
This bash script is the same sas **filter.sh** except it filters out ip addresses of your choosing

## CountryLookup.py
This python script will requires the following libraries: numpy, geoip, matplotlip, (**pandas** Still need to add functionality), pillow (may be installed already)

It takes an input csv file and looks up country names based on maxmind's GEOIP2 database.
These countries are then counted, and sorted for uniqueness before they are exported to a python dictionary **and later a pandas dataframe excel**.
The final output is a .png file with the top N (Defualt of 5) countries based on source IP address are graphically represented in a pie chart.






