#!/bin/bash

# Fix trailing spaces in XML files
find force-app -name "*.xml" -type f -exec sed -i '' -e 's/[[:space:]]*$//' {} \;

# Fix trailing spaces in meta.xml files
find force-app -name "*.meta.xml" -type f -exec sed -i '' -e 's/[[:space:]]*$//' {} \;

echo "Fixed trailing spaces in XML files" 