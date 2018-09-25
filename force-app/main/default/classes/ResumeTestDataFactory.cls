@isTest
public class ResumeTestDataFactory {
    public static Resume__c createTestResume(){
        
        //Create a Test Contact
        Contact testContact = new Contact (FirstName='Ferris', LastName='Bueller', MailingCity='Chicago', MailingState='Il');
        System.debug('Contact ' + testContact.FirstName + ' ' + testContact.LastName + ' created');
        insert testContact;
        
        //Create a Test Resume
        Resume__c testResume = new Resume__c (Contact__c = testContact.Id, Name='Sf Admin', Active__c = true, Summary__c='I am an #AwesomeAdmin, hire me!');
        System.debug('Resume ' + testResume.Name + ' created');
        insert testResume;
        
        //Create 3 Test Technical Skills with a decremental sort order so the controller will re-sort
        List<Technical_Skill__c> testSkills = new List<Technical_Skill__c>();
        for (integer t=3; t>0; t--){
            testSkills.add(new Technical_Skill__c(Name='Skill ' + t,
                                                  Resume__c = testResume.Id,
                                                  Skills_List__c = 'Apex ' + t,
                                                  Sort_Order__c = t));
        }
        insert testSkills;
        
        //Create 3 Test Certifications with a decremental sort order so the controller will re-sort
        //First query the RecordTypeId to use for the test record
        Id RecordTypeIdCert = Schema.SObjectType.Achievement__c.getRecordTypeInfosByName().get('Certification').getRecordTypeId();
        List<Achievement__c> testCerts = new List<Achievement__c>();
        for (integer t=3; t>0; t--){
            testCerts.add(new Achievement__c (Name='Certification ' + t,
                                              Resume__c = testResume.Id,
                                              RecordTypeId = RecordTypeIdCert,
                                              Completion_Date__c = System.today(),
                                              Sort_Order__c = t));
        }
        insert testCerts;
        
        //Create 3 Test Accomplishments with a decremental sort order so the controller will re-sort
        Id RecordTypeIdAccm = Schema.SObjectType.Achievement__c.getRecordTypeInfosByName().get('Accomplishment').getRecordTypeId();
        List<Achievement__c> testAccms = new List<Achievement__c>();
        for (integer t=3; t>0; t--){
            testAccms.add(new Achievement__c (Name='Accomplishment ' + t,
                                              Resume__c = testResume.Id,
                                              RecordTypeId = RecordTypeIdAccm,
                                              Completion_Date__c = System.today(),
                                              Sort_Order__c = t));
        }
        insert testAccms;
        
        //Create 3 Test Training Courses with Completed date as many month completed before todays date by the number of the counter 
        Id RecordTypeIdTrn = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Professional Development').getRecordTypeId();
        List<Experience__c> testTrngs = new List<Experience__c>();
        for (integer g=3; g>0; g--){
            testTrngs.add(new Experience__c(Course_Name__c ='Training ' + g,
                                            Resume__c = testResume.Id,
                                            RecordTypeId = RecordTypeIdTrn,
                                            Completion_Date__c = System.today().addMonths(-g),
                                            Location__c = 'San Francisco, CA'));
        }
        insert testTrngs;
        
        //Create an Education Institution
        Id RecordTypeIdUni = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Education Organization').getRecordTypeId();
        Account testUni = new Account( RecordTypeId = RecordTypeIdUni, Name='The University of the United States', BillingCity='Queens', BillingState='NY' );
        insert testUni;
        // Create a Test Degree
        Id RecordTypeIdEdu = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Educational').getRecordTypeId();
        List<Experience__c> testEdus = new List<Experience__c>();
        for (integer u=0; u<1; u++){
            testEdus.add(new Experience__c(RecordTypeId = RecordTypeIdEdu,
                                           Resume__c = testResume.Id,
                                           Organization__c= testUni.Id,
                                           Degree_Earned__c='BS Comp Sci',
                                           Completion_Date__c = System.today().addYears(-1),
                                           Description__c = 'Test'));
        }
        insert testEdus;
        
        // Create 3 Professional Organization Accounts
        Id RecordTypeIdPro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Professional Organization').getRecordTypeId();
        List<Account> testPros = new List<Account>();
        for (integer p=0; p<3; p++){
            testPros.add(new Account(RecordTypeId = RecordTypeIdPro, 
                                     Name= p + ' Company', 
                                     BillingCity='Chicago' + p,
                                     BillingState='Il' ));
        }
        insert testPros;
        // Create Jobs with the End Date equal to today minus the counter's number of years. The Start date will be 1 year prior. Assign the org from the previous list by counter.
        Id RecordTypeIdJob = Schema.SObjectType.Experience__c.getRecordTypeInfosByName().get('Professional').getRecordTypeId();
        List<Experience__c> testJobs = new List<Experience__c>();
        for (integer u=2; u>=0; u--){
            integer y = u-1;
            testJobs.add(new Experience__c(RecordTypeId = RecordTypeIdJob,
                                           Resume__c = testResume.Id,
                                           Organization__c= testPros[0].Id,
                                           Job_Title__c = 'Job' + u,
                                           Description__c = 'Test',
                                          Start_Date__c = System.today().addYears(-y),
                                          End_Date__c = System.today().addYears(-u)));
        }
        insert testJobs;
                
        // Return the Resume Record
        return testResume;
    }
}