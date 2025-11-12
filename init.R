# init.R
# Initialization script for multi-college pitching dashboard
# This file should be sourced at the beginning of app.R to load school-specific configurations

# Source the configuration system
if (file.exists("config.R")) {
  source("config.R", local = FALSE)
} else {
  stop("config.R file not found. Please ensure configuration system is properly installed.")
}

# Initialize configuration for this deployment
cat("Initializing multi-college pitching dashboard...\n")

# Determine school code from multiple sources (priority order)
school_code <- Sys.getenv("SCHOOL_CODE", unset = "")

# If not in environment, try reading from deployment file
if (!nzchar(school_code) && file.exists(".school_code")) {
  school_code <- trimws(readLines(".school_code", n = 1, warn = FALSE))
  cat("Loaded school code from deployment file:", school_code, "\n")
}

# If still no school code, default to GCU
if (!nzchar(school_code)) {
  school_code <- "GCU"
  cat("Using default school code: GCU\n")
} else {
  cat("Using school code:", school_code, "\n")
}

# Validate school code
valid_schools <- c("GCU", "HARVARD", "VMI", "FLORIDA", "CBU", "CREIGHTON", "UNM")
if (!toupper(school_code) %in% valid_schools) {
  cat("WARNING: Unknown school code '", school_code, "'. Valid schools are:", paste(valid_schools, collapse = ", "), "\n")
  cat("Falling back to GCU configuration.\n")
  school_code <- "GCU"
}

# Load and apply school configuration
tryCatch({
  school_config <- load_school_config(school_code)
  apply_config(school_config)
  
  cat("Successfully loaded configuration for:", school_config$school_name, "\n")
  cat("- School code:", school_config$school_code, "\n")
  cat("- Team name:", school_config$team_name, "\n")
  cat("- App name:", school_config$deployment$app_name, "\n")
  cat("- Primary logo:", school_config$branding$primary_logo, "\n")
  cat("- Admin emails:", length(school_config$admin_emails), "configured\n")
  cat("- Allowed pitchers:", length(school_config$allowed_pitchers), "configured\n")
  cat("- Allowed campers:", length(school_config$allowed_campers), "configured\n")
  
}, error = function(e) {
  cat("ERROR: Failed to initialize school configuration\n")
  cat("Error message:", e$message, "\n")
  cat("Using fallback GCU configuration...\n")
  
  # Fallback to basic GCU config if loading fails
  school_config <- get_gcu_config()
  apply_config(school_config)
})

# Set environment variables for scripts that need them
Sys.setenv(SCHOOL_CODE = school_config$school_code)
Sys.setenv(FTP_HOST = school_config$ftp$host)
Sys.setenv(FTP_USER = school_config$ftp$username) 
Sys.setenv(FTP_PASS = school_config$ftp$password)
Sys.setenv(APP_NAME = school_config$deployment$app_name)

# Assign global variables for backward compatibility and testing
assign("SCHOOL_NAME", school_config$school_name, envir = .GlobalEnv)
assign("SCHOOL_CODE", school_config$school_code, envir = .GlobalEnv)
assign("SCHOOL_CONFIG", school_config, envir = .GlobalEnv)
assign("PRIMARY_LOGO_FILE", school_config$branding$primary_logo, envir = .GlobalEnv)
assign("FTP_USERNAME", school_config$ftp$username, envir = .GlobalEnv)
assign("APP_NAME", school_config$deployment$app_name, envir = .GlobalEnv)
assign("ADMIN_EMAILS", school_config$admin_emails, envir = .GlobalEnv)
assign("ALLOWED_PITCHERS_DL", school_config$allowed_pitchers, envir = .GlobalEnv)
assign("ALLOWED_CAMPERS_DL", school_config$allowed_campers, envir = .GlobalEnv)

# Validate that required files exist
required_files <- c(
  file.path("www", school_config$branding$primary_logo),
  file.path("www", school_config$branding$secondary_logo),
  "lookup_table.csv"
)

missing_files <- required_files[!file.exists(required_files)]
if (length(missing_files) > 0) {
  cat("WARNING: Missing required files:\n")
  for (file in missing_files) {
    cat("  -", file, "\n")
  }
  cat("Please ensure all required files are present before deployment.\n")
}

cat("Initialization complete.\n")
cat("===============================================\n")