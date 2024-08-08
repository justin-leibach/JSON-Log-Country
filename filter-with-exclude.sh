#! /bin/bash

: 'Edit from original filter script. Added functionality for excluding IP addresses. Script will create a CSV file of the same name of input file. Need to integrate into the combine-JSON.sh script.
   The purpuose is then use python to read the file into a list, iterate through geoip populating a country list, then count countrys and
   populate a python dictionary with the key:value of country:count. Final goal is to use python to create a visual chart, probably pie chart'

   # from user input, create variable called $filepath
echo -n "Enter absolute path to JSON file to create new csv for source ip: "
read jsonfilepath

# from user input, create variable called $filename to be used later in writing final merged file
echo -n "What do you want you want your new JSON file to be called (please add .csv)?: "
read csvfilename

# from user inpute, create a variable to exclude ip addresses from the CSV.
# In my case I will exclude any IP address associated with Amazon services, as I am using an AWS honeypot as my source
# Example jq for figuring out top offenders that you would likely exclude: cat Merged.json| jq '.sip' | sort | uniq -c | sort 
echo -n "Enter all IP addresses you wish to exclude here, separated by a space: "
echo -e "\nExample: 192.168.1.1 192.168.1.2 192.168.1.3"
read IP_Addresses

# Convert the IP addresses into a jq filter
jq_filter=$(printf 'select(.sip and (%s)) | [.sip] | @csv' "$(echo $IP_Addresses | sed 's/ /" and .sip != "/g' | sed 's/^/.sip != "/' | sed 's/$/"/')")

# Apply the jq filter to the JSON data and format the output
echo "This will take a little while"
cat $jsonfilepath | jq -r "$jq_filter" | tr ',' '\n' > $csvfilename

echo "$csvfilename created in current directory"