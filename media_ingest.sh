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

file_type() {
    local PS3="Select a file type: "
    local file_type=("Video" "Image" "Audio" "Exit")

    select choice in "${file_type[@]}"; do
        case "$choice" in
            "Video")
                echo "video'"
                break
                ;;
            "Image")
                echo "image'"
                break
                ;;
            "Audio")
                echo "audio"
                break
                ;;            
            "Exit")
                exit 1
                ;;
            *)
                echo -e "\nInvalid option. Please enter a number from 1 to ${#file_type[@]}\n"
                ;;
            esac
        done
}

# User selected filter for all files or specific file types
PS3="Convert everything or specific file type?"
file_choice=("All Files" "File Type" "Exit")

select choice in "${file_choice[@]}"; do
    case "$choice" in
        "All Files")
            # List all files in the input directory and subdirectories
            files_list=($(find "$input_dir" -type f))
            break
            ;;
        "File Type")
            file_type
            break
            ;;
        "Exit")
            exit 1
            ;;
        *)
            echo -e "\nInvalid option. Please enter a number from 1 to ${#file_choice[@]}\n"
            ;;
    esac
done

# Copy all files in the input directory to output directory 
for file in "${files_list[@]}"; do
    cp "$file" "$output_dir"
done