#!/bin/bash
# Deploy script for Creighton with correct school colors
echo "Deploying Creighton Baseball App..."
echo "CREIGHTON" > .school_code
export SCHOOL_CODE=CREIGHTON
Rscript deploy_script.R
rm -f .school_code