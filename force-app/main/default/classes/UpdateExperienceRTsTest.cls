@isTest
public class UpdateExperienceRTsTest {
    static testMethod void test(){
        //Call Data Factory to create Test Resume Record
        Resume__c tr = ResumeTestDataFactory.createTestResume();
        Test.startTest();
            // Call UpdateExperienceRT batch to update record types
            UpdateExperienceRTs ue = new UpdateExperienceRTs();
            Id batchId = Database.executeBatch(ue);
        Test.stopTest();
        // The Data Factory creates 3 Professional development records, this validates that those records have the correct record type.
        System.assertEquals(3, [SELECT count() FROM Experience__c WHERE RecordType.Name = 'Professional Development']);
    }
}