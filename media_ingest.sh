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

# Filter that looks at every file and adds those of a certain type to files_list
file_filter() {
    local all_file=($(find "$input_dir" -type f))
    for file in "${all_file[@]}"; do
        local file_type=$(file -b --mime-type "$file")

        if [[ $file_type == "$user_choice/"* ]]; then
            files_list+=("$file")   
        fi
    done
}

# User selected filter for specific file types
file_type() {
    local PS3="Select a file type: "
    local file_type=("Video" "Image" "Audio" "Exit")

    select choice in "${file_type[@]}"; do
        case "$choice" in
            "Video")
                # Call the file filter function
                user_choice="video"
                file_filter
                break
                ;;
            "Image")
                user_choice="image"
                file_filter
                break
                ;;
            "Audio")
                user_choice="audio"
                file_filter
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
            # Call the file_type function
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
    mv "$file" "$output_dir"
done