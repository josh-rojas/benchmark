#!/bin/bash

# Ensure all CustomField files have the correct namespace
find force-app -name "*.field-meta.xml" -type f -exec sed -i '' 's/<CustomField>/<CustomField xmlns="http:\/\/soap.sforce.com\/2006\/04\/metadata">/' {} \;

# Ensure all CustomObject files have the correct namespace
find force-app -name "*.object-meta.xml" -type f -exec sed -i '' 's/<CustomObject>/<CustomObject xmlns="http:\/\/soap.sforce.com\/2006\/04\/metadata">/' {} \;

# Ensure all LightningComponentBundle files have the correct namespace
find force-app -name "*.meta.xml" -type f -exec sed -i '' 's/<LightningComponentBundle>/<LightningComponentBundle xmlns="http:\/\/soap.sforce.com\/2006\/04\/metadata">/' {} \;

echo "Fixed XML namespace declarations in all XML files" 