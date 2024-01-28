#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") <input directory> <output directory>"
    exit 1
fi

# 1st argument passed will be the input directory otherwise it will be current directory
input_dir="${1:-.}"

# 2nd argument passed will be the output directory otherwise it will be current directory
output_dir="${2:-.}"

echo "$input_dir"
echo "$output_dir"