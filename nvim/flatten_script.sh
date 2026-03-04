#!/bin/bash

# Define the output file
OUTPUT_FILE="flat_structure.txt"

# Clear the output file if it already exists
> "$OUTPUT_FILE"

# Loop through all Lua files in the current directory and subdirectories
find . -type f -name "*.lua" | while read -r file; do
    # Write the path of the file
    echo -e "\n${file}:\n" >> "$OUTPUT_FILE"
    # Append the content of the file
    cat "$file" >> "$OUTPUT_FILE"
done

echo "All Lua files have been collected into $OUTPUT_FILE"
