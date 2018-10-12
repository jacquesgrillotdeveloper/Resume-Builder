/* This Class will update ALL Achievement record types to the proper type based on the Achievement's data
To execute run the below script through Execute Anonymous in the Dev Console:

UpdateAchievementRTs batchAchievements = new UpdateAchievementRTs(); 
Id batchId = Database.executeBatch(batchAchievements);

*/
public class UpdateAchievementRTs implements Database.Batchable<sObject>, Database.Stateful {
    //track number of records processed
    public Integer recordsProcessed = 0;

    //locator start method to query ALL Achievement records
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
            // sort experience records by Resume since they are detail - prevent future locking
           'SELECT Id, RecordTypeId, Subtitle__c, Resume__c FROM Achievement__c ORDER BY Resume__c' 
        );
    }
    public void execute(Database.BatchableContext bc, List<Achievement__c> scope){
        //process each batch of records
        // query the record types to change to 
        Id RecordTypeIdCert = Schema.SObjectType.Achievement__c.getRecordTypeInfosByName().get('Certification').getRecordTypeId();
        Id RecordTypeIdAccm = Schema.SObjectType.Achievement__c.getRecordTypeInfosByName().get('Accomplishment').getRecordTypeId();
        // Declare and instantiate a new list to story updated experience records
        List<Achievement__c> achievements = new List<Achievement__c>();
        for (Achievement__c achievement : scope){
            // Records with the subtitle field populated are Accomplishments. Increment county by 1 for records processed
            if(achievement.Subtitle__c != null){
                achievement.RecordTypeId = RecordTypeIdAccm;
                achievements.add(achievement);
                recordsProcessed = recordsProcessed +1;
            }
            else{
                achievement.RecordTypeId = RecordTypeIdCert;
                achievements.add(achievement);
                recordsProcessed = recordsProcessed +1;
            }
        }
        // Update all records processed.
        update achievements;
    }
    public void finish(Database.BatchableContext bc){
        //Return number of records processed to debug log.
        System.debug(recordsProcessed + ' Achievement records processed.');
    }

}
