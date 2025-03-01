// Enable OmniStudio Metadata API Support
try {
    // Check if OmniStudio Settings object exists
    Schema.SObjectType omnistudioSettingsType = Schema.getGlobalDescribe().get('vlocity_ins__OrchestrationSetting__c');
    
    if (omnistudioSettingsType != null) {
        // Enable OmniStudio Metadata API Support
        SObject setting = omnistudioSettingsType.newSObject();
        setting.put('Name', 'OmniStudioMetadataAPISupport');
        setting.put('vlocity_ins__Value__c', 'true');
        insert setting;
        System.debug('OmniStudio Metadata API Support enabled successfully');
    } else {
        System.debug('OmniStudio Settings object not found. OmniStudio might not be properly installed.');
    }
} catch (Exception e) {
    System.debug('Error enabling OmniStudio Metadata API Support: ' + e.getMessage());
} 