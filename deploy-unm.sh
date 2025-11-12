#!/bin/bash
# Deploy script for UNM with correct school colors
echo "Deploying UNM Baseball App..."
echo "UNM" > .school_code
export SCHOOL_CODE=UNM
Rscript deploy_script.R
rm -f .school_code