# config.R
# Multi-College Configuration System for Pitching Dashboard
# This file contains all school-specific configurations that need to be customized
# for different colleges while keeping the core app.R unchanged

# =============================================================================
# CONFIGURATION LOADING SYSTEM
# =============================================================================

# Function to load configuration based on environment or school code
load_school_config <- function(school_code = NULL) {
  # Determine school code from multiple sources (priority order)
  if (is.null(school_code)) {
    school_code <- Sys.getenv("SCHOOL_CODE", unset = "")
  }
  
  if (!nzchar(school_code)) {
    school_code <- Sys.getenv("SHINY_SCHOOL", unset = "")
  }
  
  # Default to GCU if no school code specified
  if (!nzchar(school_code)) {
    school_code <- "GCU"
  }
  
  school_code <- toupper(school_code)
  
  # Load the appropriate configuration
  config <- switch(school_code,
    "GCU" = get_gcu_config(),
    "HARVARD" = get_harvard_config(),
    "TEMPLATE" = get_template_config(),
    {
      warning("Unknown school code: ", school_code, ". Using GCU config as fallback.")
      get_gcu_config()
    }
  )
  
  cat("Loaded configuration for:", config$school_name, "\n")
  return(config)
}

# =============================================================================
# GRAND CANYON UNIVERSITY CONFIGURATION
# =============================================================================

get_gcu_config <- function() {
  list(
    # School Identity
    school_code = "GCU",
    school_name = "Grand Canyon University",
    team_name = "GCU Baseball",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "banni17@yahoo.com", 
      "micaiahtucker@gmail.com", 
      "joshtols21@gmail.com", 
      "james.a.gaynor@gmail.com"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "GCUbaseball"
    ),
    
    # FTP Configuration for Data Sync
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "GrandCanyon",
      password = "F42Y6LiLGS"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "gcubaseball1",
      title = "GCU Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "GCUlogo.png",      # School logo (left side)
      secondary_logo = "PCUlogo.png",    # PCU logo (right side)
      navbar_theme = "inverse",          # Bootstrap navbar theme
      primary_color = "#522d80",         # GCU Purple
      secondary_color = "#ffffff",       # White
      accent_color = "#f5f5f5"          # Light gray
    ),
    
    # Player Lists - Team Pitchers
    allowed_pitchers = c(
      "Lee, Aidan",
      "Limas, Jacob",
      "Higginbottom, Elijah",
      "Cunnings, Cam",
      "Moeller, Luke",
      "Smith, Jace",
      "Frey, Chase",
      "Ahern, Garrett",
      "McGuire, Tommy",
      "Robb, Nicholas",
      "Guerrero, JT",
      "Gregory, Billy",
      "Penzkover, Gunnar",
      "Lewis, JT",
      "Kiemele, Cody",
      "Cohen, Andrew",
      "Lyon, Andrew",
      "Johns, Tanner",
      "Toney, Brock",
      "Sloan, Landon",
      "Key, Chance",
      "Orr, Dillon"
    ),
    
    # Player Lists - Camp/Training Participants
    allowed_campers = c(
      "Bowman, Brock",
      "Daniels, Tyke",
      "Pearson, Blake",
      "Rodriguez, Josiah",
      "James, Brody",
      "Nevarez, Matthew",
      "Nunes, Nolan",
      "Parks, Jaeden",
      "Hill, Grant",
      "McGinnis, Ayden",
      "Morton, Ryker",
      "McGuire, John",
      "Willson, Brandon",
      "Lauterbach, Camden",
      "Turnquist, Dylan",
      "Bournonville, Tanner",
      "Evans, Lincoln",
      "Gnirk, Will",
      "Mann, Tyson",
      "Neneman, Chase",
      "Warmus, Joaquin",
      "Kapadia, Taylor",
      "Stoner, Timothy",
      "Bergloff, Cameron",
      "Hamm, Jacob",
      "Hofmeister, Ben",
      "Moo, Eriksen",
      "Peltz, Zayden",
      "Huff, Tyler",
      "Moseman, Cody"
    ),
    
    # Data Processing Configuration
    data_config = list(
      # Date filtering - start date for data inclusion
      start_date = as.Date("2025-10-20"),
      
      # CSV exclusion patterns (files to skip during sync)
      csv_exclusions = c("playerpositioning"),
      
      # Required data columns for validation
      required_columns = c("Date", "Pitcher", "TaggedPitchType", "RelSpeed"),
      
      # Data quality thresholds
      min_velocity = 60,    # Minimum velocity for valid pitch
      max_velocity = 120    # Maximum velocity for valid pitch
    )
  )
}

# =============================================================================
# TEMPLATE CONFIGURATION (for new schools)
# =============================================================================

get_template_config <- function() {
  list(
    # School Identity
    school_code = "TEMPLATE",
    school_name = "Your School Name",
    team_name = "Your Team Name",
    
    # Team Code for filtering (if needed)
    team_code = "",
    
    # Admin Configuration  
    admin_emails = c(
      "admin1@yourschool.edu",
      "coach@yourschool.edu"
    ),
    
    # Notes API Configuration (you'll need to create your own Google Apps Script)
    notes_api = list(
      url = "YOUR_GOOGLE_APPS_SCRIPT_URL_HERE",
      token = "YourSchoolToken"
    ),
    
    # FTP Configuration for Data Sync (get from TrackMan)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "YOUR_FTP_USERNAME",
      password = "YOUR_FTP_PASSWORD"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "yourschoolbaseball",
      title = "Your School Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "schoollogo.png",      # Your school logo (add to www folder)
      secondary_logo = "PCUlogo.png",       # Keep PCU logo or replace with conference logo
      navbar_theme = "inverse",             # or "default"
      primary_color = "#003366",            # Your school's primary color
      secondary_color = "#ffffff",          # Secondary color
      accent_color = "#f5f5f5"             # Accent color
    ),
    
    # Player Lists - Team Pitchers (REPLACE WITH YOUR PLAYERS)
    allowed_pitchers = c(
      "LastName, FirstName",
      "Add, Your",
      "Players, Here"
    ),
    
    # Player Lists - Camp/Training Participants (if applicable)
    allowed_campers = c(
      # Add camp participants or external players if needed
      # "CampPlayer1, Name"
    ),
    
    # Data Processing Configuration
    data_config = list(
      # Date filtering - adjust start date as needed
      start_date = as.Date("2025-08-01"),
      
      # CSV exclusion patterns
      csv_exclusions = c("playerpositioning"),
      
      # Required data columns for validation  
      required_columns = c("Date", "Pitcher", "TaggedPitchType", "RelSpeed"),
      
      # Data quality thresholds
      min_velocity = 60,
      max_velocity = 120
    )
  )
}

# =============================================================================
# CONFIGURATION VALIDATION
# =============================================================================

validate_config <- function(config) {
  required_fields <- c(
    "school_code", "school_name", "team_name", "admin_emails",
    "notes_api", "ftp", "deployment", "branding", 
    "allowed_pitchers", "data_config"
  )
  
  missing <- setdiff(required_fields, names(config))
  if (length(missing) > 0) {
    stop("Missing required configuration fields: ", paste(missing, collapse = ", "))
  }
  
  # Validate sub-configurations
  if (is.null(config$notes_api$url) || !nzchar(config$notes_api$url)) {
    warning("Notes API URL is not configured")
  }
  
  if (is.null(config$ftp$username) || !nzchar(config$ftp$username)) {
    warning("FTP credentials are not configured")
  }
  
  if (length(config$admin_emails) == 0) {
    warning("No admin emails configured")
  }
  
  if (length(config$allowed_pitchers) == 0) {
    warning("No allowed pitchers configured")
  }
  
  return(TRUE)
}

# =============================================================================
# HELPER FUNCTIONS
# =============================================================================

# Function to get current school configuration (call this in your app)
get_config <- function() {
  config <- load_school_config()
  validate_config(config)
  return(config)
}

# Function to apply configuration to global environment
apply_config <- function(config = NULL) {
  if (is.null(config)) {
    config <- get_config()
  }
  
  # Set global variables that app.R expects
  assign("TEAM_CODE", config$team_code, envir = .GlobalEnv)
  assign("NOTES_API_URL", config$notes_api$url, envir = .GlobalEnv)
  assign("NOTES_API_TOKEN", config$notes_api$token, envir = .GlobalEnv)
  assign("ADMIN_EMAILS", config$admin_emails, envir = .GlobalEnv)
  assign("ALLOWED_PITCHERS", config$allowed_pitchers, envir = .GlobalEnv)
  assign("ALLOWED_CAMPERS", config$allowed_campers, envir = .GlobalEnv)
  assign("SCHOOL_CONFIG", config, envir = .GlobalEnv)
  
  invisible(config)
}

# Function to get CSS for navbar colors
get_navbar_css <- function(config = NULL) {
  if (is.null(config)) {
    config <- get_config()
  }
  
  css <- sprintf('
    .navbar-inverse {
      background-color: %s !important;
      border-color: %s !important;
    }
    .navbar-inverse .navbar-brand {
      color: %s !important;
    }
    .navbar-inverse .navbar-nav > li > a {
      color: %s !important;
    }
    .navbar-inverse .navbar-nav > .active > a,
    .navbar-inverse .navbar-nav > .active > a:hover,
    .navbar-inverse .navbar-nav > .active > a:focus {
      background-color: %s !important;
      color: %s !important;
    }
    .brand-logo, .pcu-right {
      max-height: 40px;
      width: auto;
      vertical-align: middle;
    }
    .brand-title {
      font-weight: bold;
      margin: 0 15px;
      vertical-align: middle;
    }
  ',
  config$branding$primary_color,      # navbar background
  config$branding$primary_color,      # navbar border
  config$branding$secondary_color,    # brand text color
  config$branding$secondary_color,    # nav link color
  config$branding$accent_color,       # active background
  config$branding$primary_color       # active text color
  )
  
  return(css)
}

# Function to check if current user is admin
is_admin_user <- function(email, config = NULL) {
  if (is.null(config)) {
    config <- get_config()
  }
  !is.na(email) && email %in% config$admin_emails
}

# =============================================================================
# HARVARD UNIVERSITY CONFIGURATION  
# =============================================================================

get_harvard_config <- function() {
  list(
    # School Identity
    school_code = "HARVARD",
    school_name = "Harvard University",
    team_name = "Harvard Crimson",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from Harvard app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com",
      "nathancole@fas.harvard.edu",
      "jeffrey_kane@fas.harvard.edu", 
      "mslattery@fas.harvard.edu",
      "cleaden@seas.harvard.edu"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "Harvardbaseball"
    ),
    
    # FTP Configuration for Data Sync (from Harvard automated_data_sync.R)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "Harvard",
      password = "3ucALn8Gqy"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "harvardbaseball1",
      title = "Harvard Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "Harvardlogo.png",     # Harvard logo
      secondary_logo = "PCUlogo.png",       # PCU logo (right side)
      navbar_theme = "inverse",             # Bootstrap navbar theme
      primary_color = "#A51C30",           # Harvard Crimson
      secondary_color = "#ffffff",         # White
      accent_color = "#f5f5f5"            # Light gray
    ),
    
    # Player Lists - Team Pitchers (sample from Harvard lookup table)
    allowed_pitchers = c(
      "Abler, Andrew",
      "Alagheband, Luca", 
      "Burns, Will",
      "Bergsma, Charley",
      "Chen, Jason",
      "Clark, Jack",
      "Cleary, Charlie",
      "Donovan, Brendan",
      "Gochman, Jake"
    ),
    
    # Player Lists - Team Position Players  
    allowed_hitters = c(
      "Abler, Andrew",
      "Burns, Will",
      "Chen, Jason", 
      "Clark, Jack",
      "Donovan, Brendan",
      "Gochman, Jake"
    ),
    
    # Player Lists - Catchers
    allowed_catchers = c(
      "Burns, Will",
      "Chen, Jason"
    ),
    
    # Camp Participants (can be empty if no camps)
    camp_participants = c(),
    
    # Data Processing Configuration
    data_config = list(
      # Date filtering - start date for data inclusion
      start_date = as.Date("2025-10-20"),
      
      # CSV exclusion patterns (files to skip during sync)
      csv_exclusions = c("playerpositioning"),
      
      # Required data columns for validation
      required_columns = c("Date", "Pitcher", "TaggedPitchType", "RelSpeed"),
      
      # Data quality thresholds
      min_velocity = 60,    # Minimum velocity for valid pitch
      max_velocity = 120    # Maximum velocity for valid pitch
    )
  )
}
