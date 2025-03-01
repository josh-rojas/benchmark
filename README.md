# Financial Advisory Benchmarking Application

A Salesforce application for financial advisory firms to submit performance metrics and compare against industry benchmarks.

## Overview

This application enables financial advisory firms to:
- Submit key performance metrics securely
- Access anonymized industry benchmark data
- Compare performance against industry averages, medians, and percentiles
- Track performance trends over time

## Data Model

The application uses three primary custom objects:

1. **Benchmarking Firm** - Stores firm information and categorization
   - Firm Identifier (anonymized)
   - Firm Size (AUM Range)
   - Industry Segment

2. **Benchmarking Submission** - Contains firm metrics for a specific year
   - Financial metrics (revenue, AUM, profitability)
   - Operational metrics (staff, client ratios)
   - Client satisfaction indicators
   - Links to Benchmarking Firm

3. **Benchmark Result** - Aggregated statistical results
   - Average, median, 25th and 75th percentiles
   - Segmented by year and metric name

## Features

- **Data Submission Form**: OmniStudio-based form for submitting annual metrics
- **Firm Identification**: DataRaptor extraction for retrieving firm information
- **Data Processing**: Logic for saving and processing submissions
- **LWC Interface**: Custom components for user interaction

## Calculation Methodology

Benchmark statistics are calculated after submission deadlines using the following process:
1. Data validation and cleaning
2. Segmentation by firm size and industry segment
3. Statistical aggregation (mean, median, percentiles)
4. Anonymization and publishing of results

## Installation

1. Clone the repository
2. Deploy to a Salesforce org using:
   ```
   sfdx force:source:deploy -p force-app
   ```
3. Assign appropriate permission sets to users

## Usage

1. Firms submit data through the Benchmarking Data Submission form
2. Administrators validate and process submissions
3. Benchmark calculations are run after submission deadlines
4. Firms can access benchmark reports through dashboards

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Submit a pull request

## License

Proprietary - All Rights Reserved