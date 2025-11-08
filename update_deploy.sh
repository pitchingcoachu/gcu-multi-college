#!/usr/bin/env bash

echo "Updating deploy_script.R for multi-college..."

# Backup original
cp deploy_script.R deploy_script_original.R

# Add configuration loading after the library loading
sed -i '' '/library(rsconnect)/a\
})\
\
# Load school configuration\
if (file.exists("config.R")) {\
  source("config.R", local = FALSE)\
  config <- get_config()\
  cat("Loaded configuration for:", config$school_name, "\\n")\
  cat("Will deploy to app name:", config$deployment$app_name, "\\n")\
} else {\
  # Fallback configuration\
  config <- list(\
    school_name = "Unknown School",\
    deployment = list(\
      app_name = Sys.getenv("APP_NAME", "schoolbaseball"),\
      title = "Baseball Dashboard"\
    )\
  )\
  cat("WARNING: config.R not found, using fallback configuration\\n")\
  cat("App name:", config$deployment$app_name, "\\n")\
}' deploy_script.R

# Fix the closing brace
sed -i '' 's/})/})/' deploy_script.R

# Update deployment messages
sed -i '' 's/cat("Starting deployment of Harvard app/cat("Starting deployment of", config$school_name, "app/' deploy_script.R
sed -i '' 's/appName = "gcubaseball"/appName = config$deployment$app_name/' deploy_script.R
sed -i '' 's/cat("CBU - Deployment Script/cat(config$school_name, "- Deployment Script/' deploy_script.R

echo "Updated deploy_script.R successfully!"