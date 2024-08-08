#! /bin/bash

: 'Script will create a CSV file of the same name of input file. Need to integrate into the combine-JSON.sh script.
   The purpuose is then use python to read the file into a list, iterate through geoip populating a country list, then count countrys and
   populate a python dictionary with the key:value of country:count. Final goal is to use python to create a visual chart, probably pie chart'

   # from user input, create variable called $filepath
echo -n "Enter absolute path to JSON file to create new csv for source ip: "
read jsonfilepath

# from user input, create variable called $filename to be used later in writing final merged file
echo -n "What do you want you want your new JSON file to be called (please add .csv)?: "
read csvfilename

echo "Be patient"

cat $jsonfilepath | jq -r 'select(.sip) | [.sip] | @csv' > $csvfilename

echo "$csvfilename created in current directory"