#!/bin/bash

# This script exports specified file types from the root of a GitHub repository,
# concatenates their contents, and encodes them in base64 format.

# Function to display usage information
usage() {
    printf "Usage: %s [output file]\n" "$0"
    printf "Run this script at the root of the repository to export code files in base64 format.\n"
    printf "Example: %s output.txt\n" "$0"
}

# Function to check for necessary command availability
check_requirements() {
    local requirements=("find" "base64")
    for cmd in "${requirements[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            printf "Error: Required command %s is not installed.\n" "$cmd" >&2
            return 1
        fi
    done
}

# Function to find, concatenate, and encode files
export_and_encode_files() {
    local output_file=$1
    local file_count=0
    local file_list=()
    local temp_file="file_list.tmp"
    # Define your file extensions here. Add more extensions as needed.
    local extensions=(-name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.ipynb" -o -name "*.html" -o -name "*.sol")

    # Finding and storing specified file types in a temporary file
    find . -type f \( "${extensions[@]}" \) -print0 > "$temp_file"

    # Processing each file from the temporary file
    while IFS= read -r -d $'\0' file; do
        printf "Processing %s\n" "$file"
        # Append each file's base64-encoded content to the output file
        if base64 "$file" >> "$output_file"; then
            ((file_count++))
            file_list+=("$file")
        else
            printf "Error processing %s\n" "$file"
        fi
    done < "$temp_file"

    rm "$temp_file"  # Cleanup the temporary file

    if [[ $file_count -gt 0 ]]; then
        printf "Total files processed: %d\n" "$file_count"
        printf "Files processed:\n"
        for f in "${file_list[@]}"; do
            printf "%s (%s)\n" "$f" "${f##*.}"
        done
        return 0
    else
        printf "No files were processed. Ensure there are files with specified extensions in the directory.\n" >&2
        return 1
    fi
}

# Main function orchestrating the script operations
main() {
    if [[ $# -ne 1 ]]; then
        usage
        return 1
    fi

    local output_file=$1

    if ! check_requirements; then
        return 1
    fi

    if export_and_encode_files "$output_file"; then
        printf "All files have been processed and output to %s\n" "$output_file"
    else
        printf "Failed to process files.\n" >&2
    fi
}

# Starting point of the script
main "$@"
