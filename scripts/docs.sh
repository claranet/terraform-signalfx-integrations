#!/bin/bash

find . -type f -name 'versions.tf' -printf "%h\0" | 
while IFS= read -r -d '' dir; do
    printf 'Update terraform-docs for: %s\n' "$dir"
    terraform-docs markdown "${dir}"  --output-file README.md
done
