# Harvard University Baseball Configuration
# Generated from existing Harvard repository data

get_harvard_config <- function() {
  list(
    # School identification
    school_code = "HARVARD",
    school_name = "Harvard University",
    team_name = "Crimson",
    app_name = "harvardbaseball",
    
    # Logo files (in www/ directory)
    primary_logo = "Harvardlogo.png",
    secondary_logo = "PCUlogo.png",
    
    # Admin emails (from Harvard app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com",
      "nathancole@fas.harvard.edu",
      "jeffrey_kane@fas.harvard.edu", 
      "mslattery@fas.harvard.edu",
      "cleaden@seas.harvard.edu"
    ),
    
    # FTP Configuration (from Harvard automated_data_sync.R)
    ftp_config = list(
      host = "ftp.trackmanbaseball.com",
      username = "Harvard",
      password = "3ucALn8Gqy"
    ),
    
    # Google Apps Script Configuration
    notes_api_token = "Harvardbaseball",
    
    # Player lookup table
    lookup_table_file = "lookup_table_harvard.csv",
    
    # Color scheme (Harvard colors)
    colors = list(
      primary = "#A51C30",     # Harvard Crimson
      secondary = "#FFFFFF",   # White
      accent = "#1E1E1E"       # Black
    ),
    
    # Data filtering settings
    data_filter_rules = list(
      exclude_patterns = c(),
      include_patterns = c("harvard", "crimson"),
      date_range_days = 365
    ),
    
    # Deployment settings  
    deployment = list(
      app_name = "harvardbaseball1",
      description = "Harvard University Baseball Analytics Dashboard"
    )
  )
}
