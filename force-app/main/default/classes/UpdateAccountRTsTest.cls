@isTest
public class UpdateAccountRTsTest {
    @testSetup
    static void setup(){
        List <Account> testAccounts = new List<Account>();
        // insert 10 accounts with no record type and with the industry Education
        for(integer e=0; e<10; e++){
            testAccounts.add(new Account(
                Name='University of '+e,
                BillingCity='New York', 
                BillingState='NY', 
                Industry='Education'));
        }
        // insert 10 accounts with no record type and no Industry
        for(integer p=0; p<20; p++){
            testAccounts.add(new Account(
                Name='Company'+p,
                BillingCity='Chicago', 
                BillingState='Il'));
        }
        insert testAccounts;
    }
    static testMethod void test(){
        //Call Data Factory to create Test Resume Record
        //Resume__c tr = ResumeTestDataFactory.createTestResume();
        Test.startTest();
        // Call UpdateExperienceRT batch to update record types
        UpdateAccountRTs uacct = new UpdateAccountRTs();
        Id acctBatchId = Database.executeBatch(uacct);
        Test.stopTest();
        //Verify that the 10 accounts with Education industry were changed to education organziaton record type
        System.assertEquals(10, [SELECT count() FROM Account WHERE RecordType.Name = 'Education Organization' AND Industry='Education']);
        //Verify that the 20 accounts with no industry were changed to Professional Organization
        System.assertEquals(20, [SELECT count() FROM Account WHERE RecordType.Name = 'Professional Organization']);
    }
}