# JSON-Log-Country
<pre>
This repo is for use with log files created by a dshield honeypot, for use in the SANS Internet Storm Center.

External libraries required (and available from pip): 

            - numpy
            - geoip2
            - matplotlib
            - pandas
            - openpyxl
</pre>
# General Instructions:
<pre>
Follow this readme in cronological order. 4 Total steps.

Python3 must be installed.

Remember to change the permissions of your script files to run ( example: chmod 744 **setup.sh** )

These scripts will ask for absolute file paths. ( Example: /home/myname/mergedData.csv )

If you don't know, check this out: https://linuxhandbook.com/absolute-vs-relative-path/

Finally, don't be afraid to tweek any of the scripts, especially the Python script. 
I have been very liberal with the comments to allow non-programmers the ability to modify.
</pre>
## 1. setup.sh
<pre>
This is a bash script to set your debian based linux distro.

If using Ubuntu, I recommend creating a VENV for module installation.

Read script comments for detailed instructions.

Requires (unaffiliated) free account creation: https://www.maxmind.com/en/geolite2/signup
</pre>

## 2. combine-JSON.sh
<pre>
This script is a very useful standalone utility to follow up with jqueries of large datasets. You could stop here! (or not)

I tested this using an entire month of log files, and the grand total combined line count of the merged file was **163,510,310**!
Took my laptop approximately 5 minutes to complete.

This bash script is an easy way to combine a large number of JSON files from a single directory into a single file.

The output of this is immediately able to be queried and filtered with jq in the command line.

Prepare by placing all of your log files you want to combine into a single directory.

This script requires the absolute path to a directory ( example: /home/myname/julyWebHoneyPotLogs/ ).

I chose to use BASH to combine files for portability and memory management. Larger tasks crashed python scripts.

This script takes the longest of all, and depending on your dataset and processing power could be a minute to many minutes.
</pre>

## 3a. filter.sh
<pre>
This bash script will take the source ip from the **combine-JSON.sh** script and create a .csv file for use in **CountryLookup.py**

You will notice that each entry is encapsulated in [] ... the **CountryLookup.py** takes care of this little problem.
</pre>
## 3b. filter-with-exclude.sh
<pre>
Use this or the previous. Using this filter file does not take more time, only has prompt associated.

This bash script is the same sas **filter.sh** except it filters out your choice of ip addresses.
</pre>

## 4. CountryLookup.py
<pre>
This python script will requires the following libraries: numpy, geoip, matplotlip, pandas, openpyxl, 
pillow (may be installed already). If you used the **setup.sh** script, they have been installed.

It takes an input csv file and looks up country names based on maxmind's GEOIP2 database.

These countries are then counted and sorted for uniqueness before they are exported to a python dictionary, 
and turned into a panda dataframe.

The final output is a pie-chart (.png) and .xlsx file with the top N (Defualt of 6) countries based on source IP address.

This will overwrite any file in your current directory that is the default name of **country_DataFrame.xlsx** and
**countryPieChart.png**
</pre>





