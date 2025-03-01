/**
 * @description Controller class for the Benchmarking Platform
 * @author Beacon Strategies
 */
public with sharing class BenchmarkingController {
    
    /**
     * @description Retrieves the Benchmarking Firm record associated with the current user
     * @param userId The Id of the current user
     * @return BenchmarkingFirmWrapper The Benchmarking Firm data with latest submission details
     */
    @AuraEnabled(cacheable=true)
    public static BenchmarkingFirmWrapper getBenchmarkFirm(Id userId) {
        // Get the current user's contact Id (for community users)
        User currentUser = [SELECT Id, ContactId FROM User WHERE Id = :userId WITH SECURITY_ENFORCED LIMIT 1];
        
        if (currentUser.ContactId == null) {
            throw new AuraHandledException('User is not associated with a Contact record.');
        }
        
        try {
            // Query for the Benchmarking Firm record
            Benchmarking_Firm__c firm = [
                SELECT Id, Firm_Identifier__c, Industry_Segment__c, 
                       Firm_Size_AUM_Range__c, Geographic_Region__c, 
                       Business_Model__c, Firm_Structure__c, 
                       Founding_Year__c, Data_Sharing_Agreement__c, 
                       Last_Submission_Date__c
                FROM Benchmarking_Firm__c
                WHERE OwnerId = :userId 
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
            
            // Get the most recent submission
            Benchmarking_Submission__c lastSubmission = null;
            
            List<Benchmarking_Submission__c> submissions = [
                SELECT Id, Submission_Year__c, Submission_Status__c, 
                       Submission_Date__c, Total_Revenue__c
                FROM Benchmarking_Submission__c
                WHERE Benchmarking_Firm__c = :firm.Id
                WITH SECURITY_ENFORCED
                ORDER BY Submission_Date__c DESC
                LIMIT 1
            ];
            
            if (!submissions.isEmpty()) {
                lastSubmission = submissions[0];
            }
            
            // Create and return the wrapper
            BenchmarkingFirmWrapper wrapper = new BenchmarkingFirmWrapper();
            wrapper.firmId = firm.Id;
            wrapper.firmIdentifier = firm.Firm_Identifier__c;
            wrapper.industrySegment = firm.Industry_Segment__c;
            wrapper.firmSizeAumRange = firm.Firm_Size_AUM_Range__c;
            wrapper.geographicRegion = firm.Geographic_Region__c;
            wrapper.businessModel = firm.Business_Model__c;
            wrapper.firmStructure = firm.Firm_Structure__c;
            wrapper.foundingYear = firm.Founding_Year__c;
            wrapper.dataSharingAgreement = firm.Data_Sharing_Agreement__c;
            wrapper.lastSubmissionDate = firm.Last_Submission_Date__c;
            wrapper.lastSubmission = lastSubmission;
            
            return wrapper;
        } catch (QueryException e) {
            throw new AuraHandledException('No Benchmarking Firm record found for this user.');
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving benchmarking firm: ' + e.getMessage());
        }
    }
    
    /**
     * @description Retrieves available benchmark results for the firm based on filters
     * @param firmId The Id of the Benchmarking Firm
     * @param year The benchmark year to filter by
     * @param metricCategory Category of metrics to retrieve
     * @return List<Benchmark_Result__c> List of benchmark results
     */
    @AuraEnabled(cacheable=true)
    public static List<Benchmark_Result__c> getBenchmarkResults(Id firmId, Integer year, String metricCategory) {
        try {
            // First get the firm details to match segment and size
            Benchmarking_Firm__c firm = [
                SELECT Industry_Segment__c, Firm_Size_AUM_Range__c
                FROM Benchmarking_Firm__c
                WHERE Id = :firmId
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
            
            // Build query for benchmark results
            String query = 'SELECT Id, Benchmark_Year__c, Metric__c, ' +
                          'Industry_Segment__c, Firm_Size_AUM_Range__c, ' +
                          'Average__c, Median__c, Percentile_25__c, Percentile_75__c, Count__c ' +
                          'FROM Benchmark_Result__c ' +
                          'WHERE Benchmark_Year__c = :year ';
            
            if (metricCategory != null && metricCategory != 'All') {
                query += 'AND Metric__c LIKE \'%' + String.escapeSingleQuotes(metricCategory) + '%\' ';
            }
            
            query += 'AND (Industry_Segment__c = :firmSegment OR Industry_Segment__c = \'All Segments\') ' +
                     'AND (Firm_Size_AUM_Range__c = :firmSize OR Firm_Size_AUM_Range__c = \'All Sizes\') ' +
                     'WITH SECURITY_ENFORCED ' +
                     'ORDER BY Metric__c ASC';
            
            // Bind variables for the query
            String firmSegment = firm.Industry_Segment__c;
            String firmSize = firm.Firm_Size_AUM_Range__c;
            
            // Execute query
            return Database.query(query);
            
        } catch (Exception e) {
            throw new AuraHandledException('Error retrieving benchmark results: ' + e.getMessage());
        }
    }
    
    /**
     * @description Wrapper class for Benchmarking Firm data
     */
    public class BenchmarkingFirmWrapper {
        @AuraEnabled public Id firmId;
        @AuraEnabled public String firmIdentifier;
        @AuraEnabled public String industrySegment;
        @AuraEnabled public String firmSizeAumRange;
        @AuraEnabled public String geographicRegion;
        @AuraEnabled public String businessModel;
        @AuraEnabled public String firmStructure;
        @AuraEnabled public Decimal foundingYear;
        @AuraEnabled public Boolean dataSharingAgreement;
        @AuraEnabled public Datetime lastSubmissionDate;
        @AuraEnabled public Benchmarking_Submission__c lastSubmission;
    }
} 