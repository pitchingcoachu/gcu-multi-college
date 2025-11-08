#!/usr/bin/env bash

# Script to update app.R for multi-college configuration

echo "Updating app.R for multi-college configuration..."

# Create backup of original
cp app.R app_original.R

# Replace the first few lines to add configuration initialization
sed -i '' '3a\
\
# Initialize multi-college configuration system\
source("init.R", local = FALSE)\
' app.R

echo "Added configuration initialization to app.R"

# Replace hardcoded team code
sed -i '' 's/if (!exists("TEAM_CODE", inherits = TRUE)) TEAM_CODE <- ""/# Team code is now loaded from configuration system in init.R/' app.R

# Replace hardcoded Notes API config
sed -i '' 's/NOTES_API_URL.*<-.*/# Notes API configuration is now loaded from school configuration in init.R/' app.R
sed -i '' 's/NOTES_API_TOKEN.*<-.*//' app.R

# Replace hardcoded admin emails
sed -i '' 's/admin_emails <- c("jgaynor@pitchingcoachu.com.*)/# Admin emails are now loaded from school configuration in init.R\
  admin_emails <- ADMIN_EMAILS/' app.R

# Replace hardcoded player lists
sed -i '' '/^ALLOWED_PITCHERS.*<-.*c(/,/^)/c\
# ==== PLAYER WHITELISTS ====\
# Player lists are now loaded from school configuration in init.R\
# Configuration system provides ALLOWED_PITCHERS and ALLOWED_CAMPERS' app.R

sed -i '' '/^ALLOWED_CAMPERS.*<-.*c(/,/^)/d' app.R

# Replace logo references  
sed -i '' 's/"GCUlogo\.png"/SCHOOL_CONFIG$branding$primary_logo/g' app.R
sed -i '' 's/"PCUlogo\.png"/SCHOOL_CONFIG$branding$secondary_logo/g' app.R

echo "Updated app.R successfully!"
echo "Original backup saved as app_original.R"