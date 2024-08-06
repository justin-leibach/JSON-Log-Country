#! /bin/bash

: 'This script allows a user to merge large amounts of json in a single directory into a signle .json file.
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

temp="ThisIsTemporary1654321.json"

file_list=()

# iterate through all files in user designated $filepath that are .json files, then append file to the file_list array
for file in "$filepath"/*.json; do
    if [ -f "$file" ]; then
        file_list+=("$file")
    fi
done

# Debugging output to check the contents of file_list
echo "Files in file_list:"
for f in "${file_list[@]}"; do
    echo "$f"
done

echo "This may take a while"

# iterate through each file in the file list array and combine it into a single json file using jq.
for file in "${file_list[@]}"; do
    jq -s '.' $file >> $temp
done

# command to remove the all arrays in the JSON file. Necessary to properly filter with jq
cat $temp | jq '.[]' > $filename

echo "$filename created in current directory"

# delete the temporary file created
rm $temp
echo "$temp deleted"











