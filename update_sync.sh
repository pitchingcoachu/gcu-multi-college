#!/usr/bin/env bash

echo "Updating automated_data_sync.R for multi-college..."

# Update FTP credentials section
sed -i '' 's/# FTP credentials/# Load school configuration\
if (file.exists("config.R")) {\
  source("config.R", local = FALSE)\
  config <- get_config()\
} else {\
  # Fallback to environment variables if config system not available\
  config <- list(\
    ftp = list(\
      host = Sys.getenv("FTP_HOST", "ftp.trackmanbaseball.com"),\
      username = Sys.getenv("FTP_USER", "GrandCanyon"),\
      password = Sys.getenv("FTP_PASS", "F42Y6LiLGS")\
    ),\
    data_config = list(\
      start_date = as.Date(Sys.getenv("DATA_START_DATE", "2025-10-20")),\
      csv_exclusions = strsplit(Sys.getenv("CSV_EXCLUSIONS", "playerpositioning"), ",")[[1]]\
    )\
  )\
  cat("Using fallback FTP configuration from environment variables\\n")\
}\
\
# Load CSV filtering utilities\
source("csv_filter_utils.R")\
\
# FTP credentials from configuration/' automated_data_sync.R

sed -i '' 's/FTP_HOST <- "ftp.trackmanbaseball.com"/FTP_HOST <- config$ftp$host/' automated_data_sync.R
sed -i '' 's/FTP_USER <- "GrandCanyon"/FTP_USER <- config$ftp$username/' automated_data_sync.R  
sed -i '' 's/FTP_PASS <- "F42Y6LiLGS"/FTP_PASS <- config$ftp$password\
\
cat("Connecting to FTP server:", FTP_HOST, "as user:", FTP_USER, "\\n")/' automated_data_sync.R

# Update date range function
sed -i '' 's/start_date <- as.Date("2025-10-20")/start_date <- config$data_config$start_date/' automated_data_sync.R

# Update main sync function
sed -i '' 's/cat("Starting VMI data sync at"/cat("Starting data sync for", config$school_name %||% "Unknown School", "at"/' automated_data_sync.R

echo "Updated automated_data_sync.R successfully!"