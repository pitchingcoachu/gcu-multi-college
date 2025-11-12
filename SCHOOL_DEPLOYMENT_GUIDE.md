# Multi-College Baseball Analytics - Deployment Guide

## Overview
This multi-college system serves 7 different schools with school-specific branding, colors, and configurations:

- **GCU** (Grand Canyon University) - Purple (#522d80)
- **Harvard** (Harvard University) - Crimson (#A51C30)  
- **VMI** (Virginia Military Institute) - Red (#c1121f)
- **Florida** (University of Florida) - Orange (#FF6600)
- **CBU** (California Baptist University) - Gold (#C8A882)
- **Creighton** (Creighton University) - Blue (#005EB8)
- **UNM** (University of New Mexico) - Red (#c1121f)

## Navbar Color Fix
If you're seeing black navbar colors instead of school-specific colors, this is because the deployment needs to be configured with the correct school code.

## School-Specific Deployment

### Using Deployment Scripts (Recommended)
Each school has a dedicated deployment script that sets the correct configuration:

```bash
# Deploy Harvard with crimson colors
./deploy-harvard.sh

# Deploy VMI with red colors  
./deploy-vmi.sh

# Deploy Florida with orange colors
./deploy-florida.sh

# Deploy CBU with gold colors
./deploy-cbu.sh

# Deploy Creighton with blue colors
./deploy-creighton.sh

# Deploy UNM with red colors
./deploy-unm.sh

# Deploy GCU with purple colors (default)
./deploy-gcu.sh
```

### Manual Deployment
If you need to deploy manually, set the school code:

```bash
# Set environment variable
export SCHOOL_CODE=HARVARD

# Or create a school code file
echo "HARVARD" > .school_code

# Then deploy
Rscript deploy_script.R
```

### Environment Variable Method
For production deployments, set the `SCHOOL_CODE` environment variable:

- **Harvard**: `SCHOOL_CODE=HARVARD`
- **VMI**: `SCHOOL_CODE=VMI`
- **Florida**: `SCHOOL_CODE=FLORIDA` 
- **CBU**: `SCHOOL_CODE=CBU`
- **Creighton**: `SCHOOL_CODE=CREIGHTON`
- **UNM**: `SCHOOL_CODE=UNM`
- **GCU**: `SCHOOL_CODE=GCU` (or leave unset for default)

## Testing Colors Locally
To test school colors locally before deployment:

```bash
# Test Harvard colors
SCHOOL_CODE=HARVARD R -e "shiny::runApp('app.R')"

# Test Florida colors
SCHOOL_CODE=FLORIDA R -e "shiny::runApp('app.R')"

# Test any school
SCHOOL_CODE=CREIGHTON R -e "shiny::runApp('app.R')"
```

## Configuration System
The system automatically:
1. Checks for `SCHOOL_CODE` environment variable
2. Falls back to `.school_code` file if present
3. Defaults to GCU if neither is set
4. Loads school-specific colors, logos, and configuration
5. Applies navbar CSS with the correct school colors

## Troubleshooting
If navbar colors still appear black:
1. Verify the school code is set correctly
2. Check that the deployment completed successfully
3. Clear browser cache to see updated colors
4. Check console logs for any CSS loading errors

## Files Modified
- `init.R` - Enhanced school code validation and error handling
- `deploy-[school].sh` - School-specific deployment scripts
- `SCHOOL_DEPLOYMENT_GUIDE.md` - This documentation

All school colors are properly configured and tested. The issue should be resolved by using the correct deployment method for each school.