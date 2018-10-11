public class UpdateExperienceRTs implements Database.Batchable<sObject>, Database.Stateful {
    // track number records processed
    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
          'SELECT Id, RecordTypeId, Course_Name__c, Job_Title__c, Degree_Earned__c FROM Experience__c'  
        );
    }
    public void execute(Database.BatchableContext bc, List<Experience__c> scope){
        //process each batch of records
        Id RecordTypeIdEdu = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Educational').getRecordTypeId();
        Id RecordTypeIdPrDv = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Professional Development').getRecordTypeId();
        List <Experience__c> experiences = new List<Experience__c>();
        for (Experience__c experience : scope){
            if(experience.Degree_Earned__c != null){
            	experience.RecordTypeId = RecordTypeIdEdu;
            	experiences.add(experience);
                recordsProcessed = recordsProcessed + 1;
            } else if (experience.Course_Name__c != null){
                experience.RecordTypeId = RecordTypeIdPrDv;
                experiences.add(experience);
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update experiences;
    }
    public void finish(Database.BatchableContext bc){
        //Validate number of records processed.
        System.debug(recordsProcessed + ' records processed. Shazam!');
    }
}