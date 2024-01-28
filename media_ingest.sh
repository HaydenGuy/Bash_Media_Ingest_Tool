#!/bin/bash

# If there is not an input and ouput directory echo usage and exit
if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") <input directory> <output directory>"
    exit 1
fi

# If the arguments are directories assign variables, else echo usage and exit
if [ -d $1 ] && [ -d $2 ]; then
    # 1st argument passed will be the input directory otherwise it will be current directory
    input_dir="${1:-.}"

    # 2nd argument passed will be the output directory otherwise it will be current directory
    output_dir="${2:-.}"
else
    echo "Usage: $(basename "$0") <input directory> <output directory>"
    exit 1
fi

# filtering: file type or everything, user defined name

# User selected filter for all files or specific file types
PS3="Convert everything or specific file type?"
options=("All Files" "File Type" "Exit")

select choice in "${options[@]}"; do
    case "$choice" in
        "All Files")
            # List all files in the input directory and subdirectories
            files_list=($(find "$input_dir" -type f))
            break
            ;;
        "File Type")
            # Another filter for the type of file
            break
            ;;
        "Exit")
            exit 1
            ;;
        *)
            echo -e "\nInvalid option. Please enter a number from 1 to ${#options[@]}\n"
            ;;
    esac
done

# Copy all files in the input directory to output directory 
for file in "${files_list[@]}"; do
    cp "$file" "$output_dir"
done