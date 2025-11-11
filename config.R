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
    "VMI" = get_vmi_config(),
    "FLORIDA" = get_florida_config(),
    "CBU" = get_cbu_config(),
    "CREIGHTON" = get_creighton_config(),
    "UNM" = get_unm_config(),
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
# =============================================================================
# VMI CONFIGURATION  
# =============================================================================

get_vmi_config <- function() {
  list(
    # School Identity
    school_code = "VMI",
    school_name = "Virginia Military Institute",
    team_name = "VMI Keydets",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from VMI app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "crosbyac@vmi.edu"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "VMIbaseball"
    ),
    
    # FTP Configuration for Data Sync (from VMI automated_data_sync.R)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "VMI",
      password = "q7MvFhmAEN"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "vmibaseball1",
      title = "VMI Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "VMIlogo.png",        # VMI logo
      secondary_logo = "PCUlogo.png",      # PCU logo (right side)
      navbar_theme = "inverse",            # Bootstrap navbar theme
      primary_color = "#FF0000",          # VMI Red
      secondary_color = "#FFD700",        # VMI Gold
      accent_color = "#f5f5f5"           # Light gray
    ),
    
    # Player Lists - Team Pitchers (from VMI repository)
    allowed_pitchers = c(
      "Jones, Andrew",
      "Driscoll, Clark",
      "Biernot, Gavin",
      "Sipe, Hunter",
      "Douthat, Jim",
      "Spiegel, Justin",
      "Williamson, Nolan",
      "Riley, Owen",
      "Dhein, Peyton",
      "Velasquez, Roberto",
      "Taylor, Carson",
      "Tyndall, Eli",
      "Ahrens, Gary",
      "Chevalier, George",
      "Melescu, Miles",
      "Lafine, Noah",
      "Monroe, Trace",
      "Bassett, Tyler"
    ),
    
    # Player Lists - Team Position Players (VMI does not have separate hitters list)
    allowed_hitters = c(),
    
    # Player Lists - Catchers (VMI does not have separate catchers list) 
    allowed_catchers = c(),
    
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

# =============================================================================
# UNIVERSITY OF FLORIDA CONFIGURATION  
# =============================================================================

get_florida_config <- function() {
  list(
    # School Identity
    school_code = "FLORIDA",
    school_name = "University of Florida",
    team_name = "Florida Gators",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from Florida app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "zachc@gators.ufl.edu", 
      "davidk@gators.ufl.edu", 
      "davidkopp47@gmail.com"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "Floridabaseball"
    ),
    
    # FTP Configuration for Data Sync (from Florida automated_data_sync.R)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "Florida Gators",
      password = "yWFB84w2eJ"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "floridabaseball1",
      title = "Florida Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "UFlogo.png",         # Florida logo
      secondary_logo = "PCUlogo.png",      # PCU logo (right side)
      navbar_theme = "inverse",            # Bootstrap navbar theme
      primary_color = "#FF6600",          # Gator Orange
      secondary_color = "#003366",        # Gator Blue
      accent_color = "#f5f5f5"           # Light gray
    ),
    
    # Player Lists - Team Pitchers (from Florida repository)
    allowed_pitchers = c(
      "Rodriguez, Christian",
      "McNeillie, Luke", 
      "Peterson, Liam",
      "Whritenour, Joshua",
      "Whritenour, Josh",
      "Gomberg, Jacob",
      "Coppola, Pierce",
      "Clemente, Jake",
      "McDonald, Caden",
      "Barberi, Jackson",
      "Barlow, Billy",
      "Janssens, Niko",
      "Rowland, Blaine",
      "Menendez, Frank",
      "Biemiller, McCall",
      "Philpott, Alex",
      "Jenkins, Matthew",
      "Jenkins, Matt",
      "Laurito, Mason",
      "Ong, Felix",
      "Sandford, Schuyler",
      "King, Aidan",
      "Montsdeoca, Carson",
      "Sandefer, Russell",
      "Moss, Cooper",
      "Reeth, Ricky",
      "Kurland, Rivers",
      "Blair, Eli",
      "Hoyt, Jackson",
      "Walls, Cooper",
      "Seo, Minjae",
      "Lugo-Canchola, Ernesto"
    ),
    
    # Player Lists - Team Position Players (Florida does not have separate hitters list)
    allowed_hitters = c(),
    
    # Player Lists - Catchers (Florida does not have separate catchers list)
    allowed_catchers = c(),
    
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

# =============================================================================
# CALIFORNIA BAPTIST UNIVERSITY CONFIGURATION  
# =============================================================================

get_cbu_config <- function() {
  list(
    # School Identity
    school_code = "CBU",
    school_name = "California Baptist University",
    team_name = "CBU Lancers",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from CBU app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "andalvarez@calbaptist.edu", 
      "msilberman@calbaptist.edu"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "CBUbaseball"
    ),
    
    # FTP Configuration for Data Sync (from CBU automated_data_sync.R)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "CalBaptist",
      password = "5tz7saLl5Z"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "cbubaseball1",
      title = "CBU Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "CBUlogo.png",        # CBU logo
      secondary_logo = "PCUlogo.png",      # PCU logo (right side)
      navbar_theme = "inverse",            # Bootstrap navbar theme
      primary_color = "#003366",          # CBU Blue
      secondary_color = "#FFD700",        # CBU Gold
      accent_color = "#f5f5f5"           # Light gray
    ),
    
    # Player Lists - Team Pitchers
    allowed_pitchers = c(
      "Malki, Michael",
      "Orozco, Julian", 
      "Smathers, Kody",
      "Fernandez, Marco",
      "Berrios, Osvaldo",
      "Wagner, Cole",
      "Dillon, Joey",
      "Hernandez, Erick",
      "Hill, Kobe",
      "Tate, Riley",
      "Smith, Holden",
      "Walker, Carson",
      "Doughty, Ethan",
      "Herrington, Maddox",
      "Perry, Logan",
      "Lewis, Colby",
      "Flores, Pablo",
      "Cardenas, Edwin",
      "Rea, Andrew"
    ),
    
    # Player Lists - Team Position Players  
    allowed_hitters = c(
      "Sample, Player1",
      "Sample, Player2"
    ),
    
    # Player Lists - Catchers
    allowed_catchers = c(
      "Sample, Player1"
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

# =============================================================================
# CREIGHTON UNIVERSITY CONFIGURATION  
# =============================================================================

get_creighton_config <- function() {
  list(
    # School Identity
    school_code = "CREIGHTON",
    school_name = "Creighton University",
    team_name = "Creighton Bluejays",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from Creighton app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "michaelcurrent@creighton.edu", 
      "billymohl@creighton.edu", 
      "willmcgillis@creighton.edu", 
      "markkingston@creighton.edu", 
      "logantolbert@creighton.edu"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "Creightonbaseball"
    ),
    
    # FTP Configuration for Data Sync (from Creighton automated_data_sync.R)
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "Creighton",
      password = "tbp2gaDXmB"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "creightonbaseball1",
      title = "Creighton Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "CREIGHTONlogo.png",  # Creighton logo
      secondary_logo = "PCUlogo.png",      # PCU logo (right side)
      navbar_theme = "inverse",            # Bootstrap navbar theme
      primary_color = "#003366",          # Creighton Blue
      secondary_color = "#FFFFFF",        # White
      accent_color = "#f5f5f5"           # Light gray
    ),
    
    # Player Lists - Team Pitchers
    allowed_pitchers = c(
      "Pineau, Jack",
      "Wendt, Shea",
      "Stratton, Evan",
      "Erickson, Braden",
      "Barr, Tyler",
      "Mach, Sam",
      "Snyder, Cole",
      "Heidemann, Luke",
      "Mangiameli, Vince",
      "Reifenrath, Caden",
      "Benak, Rory",
      "Dufek, Luke",
      "Morrison, Jake",
      "Clausen, Zach",
      "Fedje, Parker",
      "Wichman, Tate",
      "Wegener, Matthew",
      "Blase, Max",
      "Chebulski, Nick",
      "Reckewey, Ethan"
    ),
    
    # Player Lists - Team Position Players  
    allowed_hitters = c(
      "Sample, Player1",
      "Sample, Player2"
    ),
    
    # Player Lists - Catchers
    allowed_catchers = c(
      "Sample, Player1"
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

# =============================================================================
# UNIVERSITY OF NEW MEXICO CONFIGURATION  
# =============================================================================

get_unm_config <- function() {
  list(
    # School Identity
    school_code = "UNM",
    school_name = "University of New Mexico",
    team_name = "UNM Lobos",
    
    # Team Code for filtering (if needed)
    team_code = "",  # Blank = no filter
    
    # Admin Configuration (from UNM app.R)
    admin_emails = c(
      "jgaynor@pitchingcoachu.com", 
      "mlopez41@unm.edu", 
      "jstill@unm.edu"
    ),
    
    # Notes API Configuration
    notes_api = list(
      url = "https://script.google.com/macros/s/AKfycbwuftWhRZGV7f1lWFJnC5mBcxaXh7P7Xhlc7_Lvr5r6ZO_GYKbv6YxCp7B0AXsvCKY0/exec",
      token = "UNMbaseball"
    ),
    
    # FTP Configuration for Data Sync (from UNM automated_data_sync.R)
    # Note: UNM has separate Practice and V3 FTP accounts
    ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "UNewMexico",
      password = "nPyLmUW9gJ"
    ),
    
    # Practice folder FTP Configuration (Jared Gaynor account)
    practice_ftp = list(
      host = "ftp.trackmanbaseball.com",
      username = "Jared%20Gaynor",
      password = "Wev4SdE2a8"
    ),
    
    # App Deployment Configuration
    deployment = list(
      app_name = "unmbaseball1",
      title = "UNM Baseball Dashboard"
    ),
    
    # Visual Configuration
    branding = list(
      primary_logo = "UNMlogo.png",        # UNM logo
      secondary_logo = "PCUlogo.png",      # PCU logo (right side)
      navbar_theme = "inverse",            # Bootstrap navbar theme
      primary_color = "#BA0C2F",          # UNM Cherry Red
      secondary_color = "#C4D600",        # UNM Turquoise
      accent_color = "#f5f5f5"           # Light gray
    ),
    
    # Player Lists - Team Pitchers
    allowed_pitchers = c(
      "White, Tommy",
      "Alvarez, Diego",
      "Woltz, Ethin",
      "Nance, Carson",
      "Hanson, Liam",
      "Green, Cooper",
      "Montoya, Ethan",
      "Vaca, JP",
      "Gonzalez, Isaiah",
      "Brauer, Garrett",
      "Allison, Carson",
      "Gallegos, Gabe",
      "Dufault, Kade",
      "Guzman, Sebastian",
      "Majerus, Bennett",
      "Apodaca, Antonio",
      "Cline, Evan",
      "Wilcox, Liam",
      "McAleer, Jake",
      "Groshans, Jordan"
    ),
    
    # Player Lists - Team Position Players  
    allowed_hitters = c(
      "Sample, Player1",
      "Sample, Player2"
    ),
    
    # Player Lists - Catchers
    allowed_catchers = c(
      "Sample, Player1"
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
