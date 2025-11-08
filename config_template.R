# config_template.R  
# Template Configuration for New Schools
# Copy this file and customize it for your school

# Set environment variable to use TEMPLATE configuration
Sys.setenv(SCHOOL_CODE = "TEMPLATE")

# Source the main configuration system
source("config.R")

# You can customize the template configuration here if needed
# Or modify the get_template_config() function in config.R

config <- get_config()

# Apply configuration to global environment  
apply_config(config)

cat("Template configuration loaded - please customize!\n")
cat("- School:", config$school_name, "\n")
cat("- App name:", config$deployment$app_name, "\n")
cat("- Primary color:", config$branding$primary_color, "\n")

# Print reminders for customization
cat("\n=== CUSTOMIZATION CHECKLIST ===\n")
cat("1. Update school_name, team_name in get_template_config()\n")
cat("2. Add your admin email addresses\n") 
cat("3. Set up Google Apps Script for notes API\n")
cat("4. Get FTP credentials from TrackMan\n")
cat("5. Choose your school colors\n")
cat("6. Add school logo to www/ folder\n")
cat("7. Update allowed_pitchers with your team roster\n")
cat("8. Test deployment with your app name\n")