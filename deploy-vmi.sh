#!/bin/bash
# Deploy script for VMI with correct school colors
echo "Deploying VMI Baseball App..."
echo "VMI" > .school_code
export SCHOOL_CODE=VMI
Rscript deploy_script.R
rm -f .school_code