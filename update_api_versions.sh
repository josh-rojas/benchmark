#!/bin/bash

# Update API versions to 57.0 in all XML files that contain apiVersion tags
find force-app -name "*.xml" -type f -exec grep -l "<apiVersion>" {} \; | xargs sed -i '' 's/<apiVersion>[0-9]\+\.[0-9]\+<\/apiVersion>/<apiVersion>57.0<\/apiVersion>/g'

echo "Updated API versions to 57.0 in all XML files" 