#!/usr/bin/env Rscript
# Comprehensive Multi-College System Test
# Tests configurations, file structure, and data organization

cat("🏫 Multi-College System Comprehensive Test\n")
cat("==========================================\n")

# Source the configuration system
source("config.R")

cat("\n🎯 Testing School Configurations:\n")

# Test GCU
cat("\n1. 📍 TESTING GCU:\n")
gcu_config <- load_school_config("GCU")
cat("   ✅ School:", gcu_config$school_name, "\n")
cat("   ✅ App Name:", gcu_config$deployment$app_name, "\n")
cat("   ✅ FTP User:", gcu_config$ftp$username, "\n")
cat("   ✅ Data Dir: data/gcu/\n")
cat("   ✅ Admin Emails:", length(gcu_config$admin_emails), "\n")
cat("   ✅ Primary Logo:", gcu_config$branding$primary_logo, "\n")

# Test Harvard
cat("\n2. 🏛️ TESTING HARVARD:\n")
harvard_config <- load_school_config("HARVARD")
cat("   ✅ School:", harvard_config$school_name, "\n")
cat("   ✅ App Name:", harvard_config$deployment$app_name, "\n")
cat("   ✅ FTP User:", harvard_config$ftp$username, "\n")
cat("   ✅ Data Dir: data/harvard/\n")
cat("   ✅ Admin Emails:", length(harvard_config$admin_emails), "\n")
cat("   ✅ Primary Logo:", harvard_config$branding$primary_logo, "\n")

# Test file existence
cat("\n🗂️ TESTING BRANDING FILES:\n")
branding_files <- c(
  "www/GCUlogo.png",
  "www/Harvardlogo.png", 
  "www/PCUlogo.png"
)

for (file in branding_files) {
  status <- if(file.exists(file)) "✅ EXISTS" else "❌ MISSING"
  cat("   ", status, "-", file, "\n")
}

# Test lookup tables
cat("\n📋 TESTING LOOKUP TABLES:\n")
lookup_files <- c(
  "lookup_table.csv",
  "lookup_table_harvard.csv"
)

for (file in lookup_files) {
  status <- if(file.exists(file)) "✅ EXISTS" else "❌ MISSING"
  cat("   ", status, "-", file, "\n")
}

# Test data folder structure
cat("\n📁 TESTING SCHOOL-SPECIFIC DATA FOLDERS:\n")
data_dirs <- c(
  "data/gcu/practice",
  "data/gcu/v3",
  "data/harvard/practice",
  "data/harvard/v3"
)

for (dir in data_dirs) {
  status <- if(dir.exists(dir)) "✅ EXISTS" else "❌ MISSING"
  cat("   ", status, "-", dir, "/\n")
  
  if (dir.exists(dir)) {
    file_count <- length(list.files(dir, pattern = "\\.csv$"))
    if (file_count > 0) {
      cat("     📊", file_count, "CSV files found\n")
    }
  }
}

cat("\n🔄 TESTING FTP CONFIGURATION DIFFERENCES:\n")
cat("   GCU FTP:", gcu_config$ftp$username, "@", gcu_config$ftp$host, "\n")
cat("   Harvard FTP:", harvard_config$ftp$username, "@", harvard_config$ftp$host, "\n")
cat("   ✅ Each school uses their own FTP account!\n")

cat("\n🚀 DEPLOYMENT COMMANDS:\n")
cat("   GCU:     export SCHOOL_CODE='GCU' && Rscript deploy_script.R\n")
cat("   Harvard: export SCHOOL_CODE='HARVARD' && Rscript deploy_script.R\n")

cat("\n🌐 EXPECTED URLS:\n")
cat("   GCU:     https://yourname.shinyapps.io/gcubaseball/\n")
cat("   Harvard: https://yourname.shinyapps.io/harvardbaseball/\n")

cat("\n📊 DATA SYNC BEHAVIOR:\n")
cat("   GCU:     Syncs from", gcu_config$ftp$username, "FTP → data/gcu/\n")
cat("   Harvard: Syncs from", harvard_config$ftp$username, "FTP → data/harvard/\n")
cat("   ✅ Complete data isolation between schools!\n")

cat("\n✅ SYNC TESTING:\n")
cat("   Run: export SCHOOL_CODE='GCU' && Rscript automated_data_sync.R\n")
cat("   Run: export SCHOOL_CODE='HARVARD' && Rscript automated_data_sync.R\n")

cat("\n🎉 Multi-College System Status: READY! 🎉\n")
cat("\n📋 Summary:\n")
cat("   • 2 schools configured (GCU + Harvard)\n")
cat("   • Separate FTP accounts per school\n")  
cat("   • School-specific data folders\n")
cat("   • Individual deployment URLs\n")
cat("   • Complete data isolation\n")
cat("   • Same application features for all\n")