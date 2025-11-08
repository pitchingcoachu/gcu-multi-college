#!/usr/bin/env Rscript
# Test script to demonstrate multi-school configuration system

cat("🏫 Multi-College Configuration Test\n")
cat("=====================================\n")

# Source the configuration system
source("config.R")
source("init.R")

cat("\n🎯 Testing School Configurations:\n\n")

# Test GCU
cat("1. 📍 TESTING GCU:\n")
gcu_config <- load_school_config("GCU")
cat("   ✅ School:", gcu_config$school_name, "\n")
cat("   ✅ App Name:", gcu_config$deployment$app_name, "\n")
cat("   ✅ FTP User:", gcu_config$ftp$username, "\n")
cat("   ✅ Admin Emails:", length(gcu_config$admin_emails), "\n")
cat("   ✅ Primary Logo:", gcu_config$branding$primary_logo, "\n\n")

# Test Harvard
cat("2. 🏛️ TESTING HARVARD:\n")
harvard_config <- load_school_config("HARVARD")
cat("   ✅ School:", harvard_config$school_name, "\n")
cat("   ✅ App Name:", harvard_config$deployment$app_name, "\n")
cat("   ✅ FTP User:", harvard_config$ftp$username, "\n")
cat("   ✅ Admin Emails:", length(harvard_config$admin_emails), "\n")
cat("   ✅ Primary Logo:", harvard_config$branding$primary_logo, "\n\n")

# Test file existence
cat("🗂️ TESTING FILE AVAILABILITY:\n")
required_files <- c(
  "www/GCUlogo.png",
  "www/Harvardlogo.png", 
  "www/PCUlogo.png",
  "lookup_table.csv",
  "lookup_table_harvard.csv"
)

for (file in required_files) {
  status <- if(file.exists(file)) "✅ EXISTS" else "❌ MISSING"
  cat("   ", status, "-", file, "\n")
}

cat("\n🚀 DEPLOYMENT COMMANDS:\n")
cat("   GCU:     export SCHOOL_CODE='GCU' && Rscript deploy_script.R\n")
cat("   Harvard: export SCHOOL_CODE='HARVARD' && Rscript deploy_script.R\n")

cat("\n🌐 EXPECTED URLS:\n")
cat("   GCU:     https://yourname.shinyapps.io/gcubaseball/\n")
cat("   Harvard: https://yourname.shinyapps.io/harvardbaseball/\n")

cat("\n✨ Multi-college system is ready! ✨\n")