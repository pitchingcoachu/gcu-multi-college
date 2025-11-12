#!/bin/bash
# Deploy script for Harvard with correct school colors
echo "Deploying Harvard Baseball App..."
echo "HARVARD" > .school_code
export SCHOOL_CODE=HARVARD
Rscript deploy_script.R
rm -f .school_code