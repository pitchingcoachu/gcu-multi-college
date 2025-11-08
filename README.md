# Multi-College Pitching Dashboard

A configurable Shiny application for baseball pitching analytics that supports multiple colleges with school-specific customization.

## 🎯 Multi-College Features

This application supports unlimited colleges through a comprehensive configuration system:

- **🏫 School-specific branding** (logos, colors, team names)
- **👥 Custom player rosters** (team players and camp participants)  
- **🔐 Individual admin permissions** per school
- **📊 Separate data sources** (FTP credentials per school)
- **📝 Custom notes API** integration per school
- **🚀 Independent deployments** with unique app names

## 🚀 Quick Start

### For GCU (Current Setup)
The app is already configured for Grand Canyon University. Simply deploy:

```bash
Rscript deploy_script.R
```

### For New Schools
1. Review the setup guide: [MULTI_COLLEGE_SETUP.md](MULTI_COLLEGE_SETUP.md)
2. Copy the repository
3. Update `config.R` with your school's configuration
4. Add your school logo to `www/` folder
5. Update `lookup_table.csv` with your player roster
6. Set environment variable: `SCHOOL_CODE="YOURSCHOOL"`
7. Deploy: `Rscript deploy_script.R`

## 📁 File Structure

### Core Application Files
- `app.R` - Main Shiny application (now school-agnostic)
- `init.R` - Initialization script that loads school configurations
- `config.R` - Multi-school configuration system

### School-Specific Files
- `lookup_table.csv` - Player email lookup (customize per school)
- `www/GCUlogo.png` - Primary school logo
- `www/PCUlogo.png` - Secondary logo (PCU or conference logo)

### Configuration Examples
- `config_gcu.R` - GCU configuration example
- `config_template.R` - Template for new schools

### Support Scripts
- `automated_data_sync.R` - Data synchronization (now multi-school)
- `deploy_script.R` - Deployment script (now multi-school)

### Documentation
- `MULTI_COLLEGE_SETUP.md` - Detailed setup guide for new schools
- `README.md` - This file

## 🏫 School-Specific URLs

Each school gets their own unique URL when deployed:

- **GCU**: `https://yourname.shinyapps.io/gcubaseball/`
- **UCLA**: `https://yourname.shinyapps.io/uclabaseball/`
- **Your School**: `https://yourname.shinyapps.io/yourschoolbaseball/`

## 🔧 Configuration System

The configuration system uses three main components:

1. **config.R** - Central configuration management
2. **init.R** - Loads and applies school-specific settings
3. **Environment variables** - School selection mechanism

### Environment Variables

Set `SCHOOL_CODE` to select configuration:

```bash
# Local development
export SCHOOL_CODE="GCU"

# For other schools
export SCHOOL_CODE="YOURSCHOOL"
```

### Adding New Schools

1. Add configuration function to `config.R`:
```r
get_yourschool_config <- function() {
  list(
    school_code = "YOURSCHOOL",
    school_name = "Your School Name",
    # ... other configuration
  )
}
```

2. Update the switch statement in `load_school_config()`

3. Test with `source("init.R")`

## 📊 Features

- **Pitching Analytics**: Comprehensive pitch analysis and metrics
- **Hitting Analytics**: Batted ball analysis and hitting metrics  
- **Catching Analytics**: Framing and throwing analysis
- **Leaderboards**: Player comparisons and rankings
- **Player Plans**: Individual development tracking with heatmaps
- **Notes System**: Collaborative coaching notes with media uploads
- **Correlations**: Statistical relationship analysis
- **Comparison Tools**: Side-by-side player analysis

## 🔒 Security & Privacy

- Player-specific data access controls
- Admin-only features for sensitive operations
- Secure FTP data synchronization
- Environment-based configuration for credentials

## 🚀 Deployment Options

### Single School Deployment
- Customize configuration for one school
- Deploy to unique shinyapps.io app name
- Set school-specific environment variables

### Multi-School from Same Codebase
- Use environment variables for school selection
- Deploy multiple apps with different configurations
- Maintain single codebase with branch-based customization

## 📈 Data Sources

- **TrackMan Baseball**: Primary data source via FTP sync
- **CSV Upload**: Manual data import capability
- **Real-time Sync**: Automated data updates with modification tracking

## 🛠️ Development

### Local Development
```bash
# Set up for specific school
export SCHOOL_CODE="GCU"
Rscript -e "shiny::runApp('app.R')"
```

### Testing Configuration
```r
# Test configuration loading
source("config.R")
config <- load_school_config("YOURSCHOOL")
print(config)
```

### Debugging
- Enable debug output in configuration functions
- Check environment variable settings
- Verify file paths and external service connections

## 📋 Requirements

- R 4.0+
- Shiny ecosystem packages (automatically installed)
- Internet connection for external APIs
- TrackMan FTP access (per school)
- Google Apps Script setup (per school)

## 📞 Support

For setup assistance with new schools:
- Review [MULTI_COLLEGE_SETUP.md](MULTI_COLLEGE_SETUP.md) for detailed instructions
- Use GCU configuration as working example
- Contact PCU support team for technical assistance

## 🎉 What's New

This multi-college version adds:

✅ **Configuration System** - Easy school setup  
✅ **Dynamic Branding** - School colors and logos  
✅ **Isolated Data** - Separate sources per school  
✅ **Multiple URLs** - Each school gets their own app  
✅ **Admin Controls** - School-specific permissions  
✅ **Easy Deployment** - Environment variable controls  

---

**Note**: This system maintains full backward compatibility with existing GCU setup while enabling unlimited expansion to new schools.
