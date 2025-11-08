# config_gcu.R
# Grand Canyon University Specific Configuration
# This file demonstrates how to set up the configuration for GCU

# Set environment variable to use GCU configuration
Sys.setenv(SCHOOL_CODE = "GCU")

# Source the main configuration system
source("config.R")

# The configuration will automatically load GCU settings
config <- get_config()

# Apply configuration to global environment
apply_config(config)

cat("GCU configuration loaded successfully!\n")
cat("- School:", config$school_name, "\n") 
cat("- App name:", config$deployment$app_name, "\n")
cat("- Primary color:", config$branding$primary_color, "\n")
cat("- Admin emails:", length(config$admin_emails), "configured\n")
cat("- Team players:", length(config$allowed_pitchers), "configured\n")
cat("- Camp players:", length(config$allowed_campers), "configured\n")