#! /bin/bash

:'
This script allows a user to merge large amounts of json in a single directory into a signle .json file.
Using other methods like python scripts and direct use of jq crashed for lack of memory
This bash script prevents that by iterating through single jq merge processes until completion
'

current_directory=$(pwd)

# from user input, create variable called $filepath
echo -n "Enter path to folder with JSON files to combine: "
read filepath

# from user input, create variable called $filename to be used later in writing final merged file
echo -n "What do you want you want your new JSON file to be called (please add .json)?: "
read filename

#cd $filepath

# create empty array
file_list=()

# iterate through all files in user designated $filepath that are .json files, then append file to the file_list array
for file in "$filepath"/*.json; do
    if [ -f "$file" ]; then
        file_list+=("$file")
    fi
done

echo "Files in the directory:"
# iterate through each file in the file list array and combine it into a single json file using jq.
for file in "${file_list[@]}"; do
    jq -s '.' $file > $filename
done

echo "$filename created in current directory"












