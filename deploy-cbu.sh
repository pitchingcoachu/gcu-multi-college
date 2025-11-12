#!/bin/bash
# Deploy script for CBU with correct school colors
echo "Deploying CBU Baseball App..."
echo "CBU" > .school_code
export SCHOOL_CODE=CBU
Rscript deploy_script.R
rm -f .school_code