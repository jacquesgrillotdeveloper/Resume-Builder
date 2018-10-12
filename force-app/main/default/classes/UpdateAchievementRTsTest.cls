@isTest
public class UpdateAchievementRTsTest {
    static testMethod void test(){
        //Call Data Factory to create Test Resume Record
        Resume__c tr = ResumeTestDataFactory.createTestResume();
        Test.startTest();
            // Call UpdateExperienceRT batch to update record types
            UpdateAchievementRTs uacv = new UpdateAchievementRTs();
            Id acvBatchId = Database.executeBatch(uacv);
        Test.stopTest();
        // The Data Factory creates 4 Accomplishment and 3 Certifications, this validates that those records have the correct record type.
        System.assertEquals(4, [SELECT count() FROM Achievement__c WHERE RecordType.Name = 'Accomplishment']);
        System.assertEquals(3, [SELECT count() FROM Achievement__c WHERE RecordType.Name = 'Certification']);
    }
}