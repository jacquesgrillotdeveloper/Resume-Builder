/* This Class will update Experience "Education Experience" and "Professional Development" record types to the proper type based on the Experience's data
To execute run the below script through Execute Anonymous in the Dev Console:

UpdateExperienceRTs batchExperiences = new UpdateExperienceRTs(); 
Id batchId = Database.executeBatch(batchExperiences);

*/
public class UpdateExperienceRTs implements Database.Batchable<sObject>, Database.Stateful {
    // track number records processed
    public Integer recordsProcessed = 0;
    
    // locator start method to query all experience records
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            // sort experience records by Resume since they are detail - prevent future locking
          'SELECT Id, Resume__c, RecordTypeId, Course_Name__c, Job_Title__c, Degree_Earned__c FROM Experience__c ORDER BY Resume__c'  
        );
    }
    public void execute(Database.BatchableContext bc, List<Experience__c> scope){
        //process each batch of records
        // query record types to change to. 
        Id RecordTypeIdEdu = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Educational').getRecordTypeId();
        Id RecordTypeIdPrDv = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Professional Development').getRecordTypeId();
        Id RecordTypeIdProf = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Professional').getRecordTypeId();
        // Declare and instantiate a new list to store updated experience records
        List <Experience__c> experiences = new List<Experience__c>();
        for (Experience__c experience : scope){
            // Records with the Degree earned field populated are Educational experiences. Increment counter by 1 for each record processed.
            if(experience.Degree_Earned__c != null){
            	experience.RecordTypeId = RecordTypeIdEdu;
            	experiences.add(experience);
                recordsProcessed = recordsProcessed + 1;
            } 
            // Records with the Course Name field populated are Professoinal development experiences. Increment counter by 1 for each record processed.
            else if (experience.Course_Name__c != null){
                experience.RecordTypeId = RecordTypeIdPrDv;
                experiences.add(experience);
                recordsProcessed = recordsProcessed + 1;
            }
            else{
                experience.RecordTypeId = RecordTypeIdProf;
                experiences.add(experience);
                recordsProcessed = recordsProcessed + 1;
            }
        }
        // Update all records processed.
        update experiences;
    }
    public void finish(Database.BatchableContext bc){
        //Return number of records processed to debug log.
        System.debug(recordsProcessed + ' Experience records processed.');
    }
}