@isTest
public class UpdateExperienceRTsTest {
    static testMethod void test(){
        //Call Data Factory to create Test Resume Record
        Resume__c tr = ResumeTestDataFactory.createTestResume();
        Test.startTest();
        UpdateExperienceRTs ue = new UpdateExperienceRTs();
        Id batchId = Database.executeBatch(ue);
        Test.stopTest();
        System.assertEquals(3, [SELECT count() FROM Experience__c WHERE RecordType.Name = 'Professional Development']);
    }
}