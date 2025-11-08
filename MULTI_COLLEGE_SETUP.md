# Multi-College Setup Guide

This guide explains how to configure and deploy the pitching dashboard for multiple colleges while keeping the same core application.

## Overview

The application has been restructured to support multiple colleges through a configuration system. Each school can have their own:

- Admin emails and user permissions
- Player/camper rosters (allowed pitchers and campers)
- Notes API configuration (URL and token)
- FTP credentials for data sync
- School branding (logos, colors)
- App name for deployment

## File Structure

```
your-repo/
├── app.R                    # Main application (now school-agnostic)
├── config.R                 # Multi-school configuration system
├── init.R                   # Initialization script
├── automated_data_sync.R    # Updated for multi-school
├── deploy_script.R          # Updated for multi-school
├── config_gcu.R            # GCU-specific configuration example
├── config_template.R       # Template for new schools
├── lookup_table.csv        # Player email lookup (school-specific)
├── www/
│   ├── GCUlogo.png         # School logo
│   └── PCUlogo.png         # Secondary logo (PCU or conference)
└── data/                   # Data folder (auto-created by sync)
```

## Setting Up for a New School

### 1. Copy the Repository

Create a new repository or folder for the new school based on this structure.

### 2. Update Configuration

Edit `config.R` and add a new school configuration function, or modify the template:

```r
# Add to config.R
get_yourschool_config <- function() {
  list(
    school_code = "YOURSCHOOL",
    school_name = "Your School Name",
    team_name = "Your Team Name",
    
    admin_emails = c("admin@yourschool.edu"),
    
    notes_api = list(
      url = "YOUR_GOOGLE_APPS_SCRIPT_URL",
      token = "YourSchoolToken"
    ),
    
    ftp = list(
      host = "ftp.trackmanbaseball.com", 
      username = "YOUR_TRACKMAN_USERNAME",
      password = "YOUR_TRACKMAN_PASSWORD"
    ),
    
    deployment = list(
      app_name = "yourschoolbaseball",
      title = "Your School Dashboard"
    ),
    
    branding = list(
      primary_logo = "yourschool_logo.png",
      secondary_logo = "PCUlogo.png", 
      navbar_theme = "inverse",
      primary_color = "#003366",    # Your school colors
      secondary_color = "#ffffff",
      accent_color = "#f5f5f5"
    ),
    
    allowed_pitchers = c(
      "LastName, FirstName",
      # Add your players here
    ),
    
    allowed_campers = c(
      # Add camp participants if needed
    ),
    
    data_config = list(
      start_date = as.Date("2025-08-01"),  # Adjust as needed
      csv_exclusions = c("playerpositioning"),
      required_columns = c("Date", "Pitcher", "TaggedPitchType", "RelSpeed"),
      min_velocity = 60,
      max_velocity = 120
    )
  )
}

# Update load_school_config() to include your school
load_school_config <- function(school_code = NULL) {
  # ... existing code ...
  
  config <- switch(school_code,
    "GCU" = get_gcu_config(),
    "YOURSCHOOL" = get_yourschool_config(),  # Add this line
    "TEMPLATE" = get_template_config(),
    {
      warning("Unknown school code: ", school_code, ". Using GCU config as fallback.")
      get_gcu_config()
    }
  )
  
  # ... rest of function ...
}
```

### 3. Create School-Specific Files

#### Add Your Logo
- Add your school logo as `yourschool_logo.png` in the `www/` folder
- Keep `PCUlogo.png` or replace with your conference/partner logo

#### Update Lookup Table
Replace `lookup_table.csv` with your school's player roster:

```csv
PlayerName,Email
"LastName, FirstName",player1@yourschool.edu
"AnotherPlayer, Name",player2@yourschool.edu
```

### 4. Set Up External Services

#### Google Apps Script (for Notes)
1. Create a new Google Apps Script project
2. Copy the notes API script (contact PCU for the script code)
3. Deploy as a web app and get the URL
4. Update your configuration with the URL and a unique token

#### TrackMan FTP Access  
1. Contact TrackMan to set up FTP access for your school
2. Get FTP username and password
3. Update your configuration with these credentials

### 5. Deployment

#### Option A: Environment Variable (Recommended)
Set the `SCHOOL_CODE` environment variable before deployment:

```bash
# For local testing
export SCHOOL_CODE="YOURSCHOOL"
Rscript app.R

# For shinyapps.io deployment
# Set SCHOOL_CODE="YOURSCHOOL" in the environment variables section
```

#### Option B: Modify init.R
Change the default in `init.R`:

```r
# Change this line in init.R
if (!nzchar(school_code)) {
  school_code <- "YOURSCHOOL"  # Change from "GCU" to your school
}
```

### 6. Deploy to shinyapps.io

1. Make sure your configuration is correct
2. Set the SCHOOL_CODE environment variable in shinyapps.io settings
3. Run the deployment script:

```bash
Rscript deploy_script.R
```

## Multiple Deployments from Same Codebase

To deploy multiple schools from the same codebase:

### Method 1: Separate Repositories
- Create separate repositories for each school
- Customize config.R for each school
- Deploy each repository independently

### Method 2: Environment-Based (Advanced)
- Keep one codebase
- Use different environment variables for each deployment
- Create separate shinyapps.io applications
- Deploy with different SCHOOL_CODE settings

### Method 3: Branch-Based
- Create branches for each school (e.g., `gcu-main`, `yourschool-main`)
- Customize configurations per branch
- Deploy each branch to its own app

## Configuration Options

### School Identity
- `school_code`: Short code (e.g., "GCU", "UCLA")
- `school_name`: Full school name
- `team_name`: Team name for display

### Admin Configuration
- `admin_emails`: List of admin email addresses
- Controls access to admin features

### Visual Branding
- `primary_logo`: Main school logo file
- `secondary_logo`: Partner/conference logo
- `primary_color`, `secondary_color`, `accent_color`: Color scheme
- `navbar_theme`: "inverse" or "default"

### Player Lists
- `allowed_pitchers`: Team roster
- `allowed_campers`: Camp/training participants
- Controls who appears in the app

### Data Configuration
- `start_date`: Earliest data to include
- `csv_exclusions`: File patterns to skip
- `min_velocity`, `max_velocity`: Data validation

### External Services
- `notes_api`: Google Apps Script configuration
- `ftp`: TrackMan FTP credentials
- `deployment`: Shinyapps.io settings

## Testing Configuration

Test your configuration locally:

```r
# Test configuration loading
source("config.R")
config <- load_school_config("YOURSCHOOL")
print(config)

# Test initialization  
source("init.R")

# Test deployment script (dry run)
# Comment out the actual deployApp() call first
source("deploy_script.R")
```

## Troubleshooting

### Common Issues

1. **Logo not showing**: Check that logo files exist in `www/` folder
2. **FTP sync failing**: Verify FTP credentials and TrackMan access
3. **Notes not working**: Check Google Apps Script URL and token
4. **Wrong colors**: Verify CSS color codes in branding configuration
5. **Player access issues**: Check allowed_pitchers list format

### Debug Configuration

Add debug output to your configuration:

```r
# Add to your config function for debugging
cat("DEBUG: Loading configuration for", school_code, "\n")
cat("DEBUG: Primary color:", config$branding$primary_color, "\n")
cat("DEBUG: App name:", config$deployment$app_name, "\n")
```

## Support

For additional support with setup:
- Contact PCU support team
- Review the GCU configuration as a working example
- Test with template configuration first

## Security Notes

- Never commit FTP passwords to public repositories
- Use environment variables for sensitive configuration
- Limit admin email access appropriately
- Test Notes API security settings