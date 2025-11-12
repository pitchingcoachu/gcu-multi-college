#!/bin/bash
# Deploy script for Florida with correct school colors
echo "Deploying Florida Baseball App..."
echo "FLORIDA" > .school_code
export SCHOOL_CODE=FLORIDA
Rscript deploy_script.R
rm -f .school_code