/* Test class for Controller Extension */
@isTest
public class ResumeControllerExtensionTest {
    
    //Test that the page renders with a Resume record   
    @isTest static void resumeControllerTestMethod() {
        //Call Data Factory to create Test Resume Record
        Resume__c tr = ResumeTestDataFactory.createTestResume();
        
        // Test Run        
        Test.startTest();
            //Call the Page and Controller. Pass the Id of test Resume 
            ApexPages.StandardController sc = new ApexPages.StandardController(tr);
            ResumeControllerExtension testResumeExt = new ResumeControllerExtension(sc);
            PageReference pageRef = Page.ResumePage;
            pageRef.getParameters().put('id', String.valueOf(tr.Id));
            
            //Test that the Skills records are returned in the correct order (sort order)
            testResumeExt.getTechnicalSkills();
            List<Technical_Skill__c> lstSkills = testResumeExt.technicalSkills;
            Technical_Skill__c[] skills = testResumeExt.technicalSkills;
            System.assertEquals('Skill 1', skills[0].Name);
            
            //Test that the Certification Achievement records are returned in the correct order (sort order)
            testResumeExt.getCertifications();
            List<Achievement__c> lstCerts = testResumeExt.certifications;
            Achievement__c[] certs = testResumeExt.certifications;
            System.assertEquals('Certification 1', certs[0].Name);

            //Test that the Accomplishment Achievement records are returned in the correct order (sort order)
            testResumeExt.getAccomplishments();
            List<Achievement__c> lstAccms = testResumeExt.accomplishments;
            Achievement__c[] accms = testResumeExt.accomplishments;
            System.assertEquals('Accomplishment 1', accms[0].Name);

            //Test that the Professional Development records are returned in the correct order (start date descending)    
            testResumeExt.getTrainingCourses();
            List <Experience__c> lstTrngs = testResumeExt.trainingCourses;
            Experience__c[] trngs = testResumeExt.trainingCourses;
            System.assertEquals('Training 1', trngs[0].Course_Name__c);
            
            //Test that the Professional Experience records are returned in the correct order (start date descending)    
            testResumeExt.getJobExperiences();
            List <Experience__c> lstJobs = testResumeExt.jobExperiences;
            Experience__c[] jobs = testResumeExt.jobExperiences;
            System.assertEquals('0 Company', jobs[0].Organization__r.Name);
                
            //Test that the Educational Experience records are returned in the correct order (start date descending)
            testResumeExt.getEduExperiences();	
            List <Experience__c> lstEdu = testResumeExt.eduExperiences;
            Experience__c[] eds = testResumeExt.eduExperiences;
            System.assertEquals('The University of the United States',eds[0].Organization__r.Name);
                
            Test.setCurrentPage(pageRef);
        Test.stopTest();   
    }
}