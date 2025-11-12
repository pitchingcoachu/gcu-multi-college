#!/bin/bash
# Deploy script for GCU with correct school colors
echo "Deploying GCU Baseball App..."
echo "GCU" > .school_code
export SCHOOL_CODE=GCU
Rscript deploy_script.R
rm -f .school_code