# Phase 2: Experience Cloud Implementation

## Overview

This document outlines the Experience Cloud site implementation for the Beacon Strategies Benchmarking Platform. The Experience Cloud site provides a secure, branded portal where financial advisory firms can submit their benchmarking data and view comparative results.

## Site Configuration

The Experience Cloud site has been configured with the following settings:

- **Site Name**: Benchmarking Platform
- **URL Path Prefix**: /benchmarking
- **Template**: Customer Service
- **Authentication**: Requires login (no public access)
- **Member Access**: Limited to users with the Benchmarking_Participant_Profile or Benchmarking_Admin profiles

## Navigation Structure

The site includes the following navigation items:

1. **Home** - Dashboard with firm information and submission history
2. **Submit Benchmark Data** - OmniScript-based data collection interface
3. **View Benchmarks** - Results visualizations and comparisons
4. **My Firm Profile** - Information about the participating firm
5. **Contact Us** - Support information and contact form

## Components

### Homepage (benchmarkingHomepage LWC)

The homepage component provides:
- A welcome message customized to the firm
- Information about the most recent benchmark submission
- Quick links to submit new data or view benchmarks
- Educational resources about the benchmarking program

### Apex Controllers

- **BenchmarkingController**: Provides data access for the Lightning Web Components in the Experience site
  - `getBenchmarkFirm`: Retrieves the firm record associated with the current user
  - `getBenchmarkResults`: Retrieves benchmark results based on filters

### OmniScript Integration

The Experience site integrates with the previously created OmniScript for benchmark data collection:

1. The OmniScript is accessible via the "Submit Benchmark Data" navigation item
2. Form validation is handled within the OmniScript
3. Data is saved using the DataRaptor created in the previous phase

## Security Model

The Experience site enforces the following security measures:

1. **Authentication**: All users must log in with credentials
2. **Authorization**: 
   - Community users can only see their own firm data
   - Community users cannot modify the status of submissions
   - Admin users have full access to all data
3. **Field-Level Security**: 
   - Enforced through profiles
   - Apex controller enforces WITH SECURITY_ENFORCED for all SOQL queries

## Static Resources

- **benchmarkingStyles**: Contains CSS stylesheets for consistent branding across the site

## Branding

The site uses Beacon Strategies branding:
- Primary Color: #0076d6
- Secondary Color: #2a3a4a
- Accent Color: #62b5e5

## Deployment Notes

When deploying the Experience Cloud site:

1. Ensure all files in the `experiences` directory are included
2. Upload the static resource ZIP file with all CSS files
3. Verify user permissions are correctly configured
4. Activate the site after deployment 