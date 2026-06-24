#!/bin/bash
# A build simulation script gating deployment on security checks

echo "Starting build process..."

# Step 1: Scan local configurations for misconfigurations
echo "Checking Dockerfile configurations..."
trivy config --exit-code 1 --severity HIGH,CRITICAL .
if [ $? -ne 0 ]; then
  echo "BUILD FAILED: Dockerfile security misconfigurations detected!"
  exit 1
fi

# Step 2: Scan package dependencies for vulnerabilities
echo "Scanning application dependencies..."
trivy fs --exit-code 1 --severity HIGH,CRITICAL .
if [ $? -ne 0 ]; then
  echo "BUILD FAILED: High or Critical dependency vulnerability detected!"
  exit 1
fi

echo "BUILD SUCCESSFUL! All security gates passed."
exit 0
