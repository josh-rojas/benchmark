# Beacon Strategies Benchmarking Platform - Data Model Documentation

## Entity Relationship Diagram

```
BENCHMARKING_FIRM (1) ---< BENCHMARKING_SUBMISSION (n)
                   \
                    \---< BENCHMARK_RESULT (n)
                        /
BENCHMARKING_SUBMISSION (n) ---< BENCHMARK_RESULT (n)
```

## Core Objects

The benchmarking platform is built on three primary custom objects:

### 1. Benchmarking_Firm__c

Stores anonymous information about participating firms.

**Key Fields:**
- `Firm_Identifier__c` (Text): Unique identifier for the firm, used for anonymization
- `Industry_Segment__c` (Picklist): Segment of the financial advisory industry
- `Firm_Size_AUM_Range__c` (Picklist): Size range based on AUM
- `Geographic_Region__c` (Picklist): Region where the firm operates
- `Business_Model__c` (Picklist): Primary business model
- `Firm_Structure__c` (Picklist): Legal/organizational structure
- `Founding_Year__c` (Number): Year the firm was founded
- `Data_Sharing_Agreement__c` (Checkbox): Indicates agreement to data sharing terms
- `Last_Submission_Date__c` (Date/Time): Date of last data submission

### 2. Benchmarking_Submission__c

Stores the detailed benchmark data submitted by firms.

**Key Fields:**
- `Benchmarking_Firm__c` (Master-Detail): Related firm record
- `Submission_Year__c` (Number): Year the data represents
- `Submission_Status__c` (Picklist): Status of submission (Submitted, Processed, Error)
- `Submission_Date__c` (Date/Time): Date the submission was created

**Revenue Efficiency Fields:**
- `Total_Revenue__c` (Currency): Total firm revenue
- `Recurring_Revenue__c` (Currency): Revenue from recurring fee arrangements
- `Non_Recurring_Revenue__c` (Currency): Revenue from one-time services
- `AUM__c` (Currency): Assets Under Management
- Various other revenue metrics

**Expense Efficiency Fields:**
- `Total_Operating_Expenses__c` (Currency): Total operating expenses
- `Compensation_Expenses__c` (Currency): Employee compensation costs
- Various expense category breakdowns

**Advisor Efficiency Fields:**
- `Number_of_Advisors__c` (Number): Total number of advisors
- `Number_of_Clients__c` (Number): Total number of clients
- Various advisor productivity metrics

**Operating Efficiency Fields:**
- Various margin and ratio calculations

**Growth Fields:**
- Various growth rate metrics

**Service Level Fields:**
- Various client service metrics

### 3. Benchmark_Result__c

Stores calculated benchmark statistics derived from submissions.

**Key Fields:**
- `Benchmark_Year__c` (Number): Year the benchmark represents
- `Metric__c` (Text): Name of the metric being benchmarked
- `Industry_Segment__c` (Picklist): Segment filter for this benchmark
- `Firm_Size_AUM_Range__c` (Picklist): Size range filter for this benchmark
- `Average__c` (Number): Average value for this metric
- `Median__c` (Number): Median value for this metric
- `Percentile_25__c` (Number): 25th percentile value
- `Percentile_75__c` (Number): 75th percentile value
- `Count__c` (Number): Number of firms in this benchmark

## Security Model

### Object-Level Security
- Community users can:
  - Read/Create/Edit their own Benchmarking_Submission__c records
  - Read their own Benchmarking_Firm__c record
  - Read anonymized Benchmark_Result__c records

- Internal users (with Benchmarking_Administrator permission set) can:
  - Manage all records across all objects

### Field-Level Security
- Community users have:
  - Read-only access to firm identification fields
  - Read/Edit access to submission data fields
  - No access to certain sensitive fields

### Record-Level Security
- Sharing rules ensure community users can only see their own submission data
- All users can view benchmark results

## Validation Rules

1. **Restrict_Status_Changes**: Prevents community users from setting submission status to 'Processed' or 'Error'
2. **Required_Fields**: Ensures all required fields are filled before submission
3. **Data_Consistency_Check**: Validates data consistency across related fields

## Connected Apps & Integration

Remote site settings are configured for API integrations with external systems if needed. 

## Technical Packaging Requirements

1. **Static Resource Packaging**:
   ```
   cd force-app/main/default/staticresources/
   zip -r benchmarkingStyles.zip benchmarkingStyles/
   ``` 