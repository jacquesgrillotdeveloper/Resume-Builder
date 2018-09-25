/****************************************************************************************
* ResumeController extension allows for custom lists for the Resume visualforce pages 	*
* Authored by Jacques Grillot for the SfResume App										*
* *************************************************************************************/
// Public class with res variable to accept Resume__c id
Public with sharing class ResumeControllerExtension {
    private final Resume__c res;
    
    public resumeControllerExtension(ApexPages.StandardController stdController){
        this.res = (Resume__c)stdController.getRecord();
    }
    
    // Declare a list for "Certification" achievements
    Public List<Achievement__c> certifications {get;set;}
    // Instantiate the get method to query Certifications
    Public List<Achievement__c> getCertifications(){
        if(certifications == null) certifications = [SELECT Id, Name, Sort_Order__c 
                                                     FROM Achievement__c 
                                                     WHERE Resume__r.Id= :res.Id AND RecordType.Name = 'Certification'
                                                     ORDER BY Sort_Order__c];    
        //Return the Certification list so the records can be rendered in the Page
        return certifications;
    }
    
    //Declare a list for "Professional" experiences
    Public List<Experience__c> jobExperiences {get;set;}
    //Instantiate a get method to query the Professional experiences
    Public List<Experience__c> getJobExperiences(){
        if (jobExperiences == null) jobExperiences = [SELECT Id, Job_Title__c, Experience_Span__c, Organization__r.Name, Description__c, Location__c, Start_Date__c 
                                                      FROM Experience__c
                                                      WHERE Resume__r.Id= :res.Id
                                                      AND RecordType.Name = 'Professional'
                                                      ORDER BY Start_Date__c DESC];
        //Return the Job Experience list so the records can be rendered in the Page
        return jobExperiences;
    }
    
    //Declare a list for "Educational" experiences
    Public List<Experience__c> eduExperiences {get;set;}
    //Instantiate a get method to query the Educational experiences
    Public List<Experience__c> getEduExperiences(){
        if (eduExperiences == null) eduExperiences = [SELECT Id, Degree_Earned__c, Completion_Date_Text__c, Organization__r.Name, Description__c, Location__c 
                                                      FROM Experience__c
                                                      WHERE Resume__r.Id= :res.Id
                                                      AND RecordType.Name = 'Educational'
                                                      ORDER BY Start_Date__c DESC];
        //Return the Educational Experience list so the records can be rendered in the Page
        return eduExperiences;
    }
    
    // Declare a list for "Training Courses" experiences
    Public List<Experience__c> trainingCourses {get;set;}
    // Instantiate the get method to query Professional Development experiences as Training Courses
    Public List<Experience__c> getTrainingCourses(){
        if(trainingCourses == null) trainingCourses = [SELECT Id, RecordType.Name, Course_Name__c, Completion_Date__c, Location__c, Organization__r.Name 
                                                       FROM Experience__c
                                                       WHERE Resume__r.Id= :res.Id AND RecordType.Name ='Professional Development' 
                                                       ORDER BY Completion_Date__c DESC];
        //Return the Training Course list so the records can be rendered in the Page
        return trainingCourses;
    }
    
    // Declare a list for "Accomplishment" achievements
    Public List<Achievement__c> accomplishments {get;set;}
    // Instantiate the get method to query Accomplishments
    Public List<Achievement__c> getAccomplishments(){
        if(accomplishments == null) accomplishments = [SELECT Id, Name, Subtitle__c, Completion_Date__c, Sort_Order__c 
                                                       FROM Achievement__c 
                                                       WHERE Resume__r.Id= :res.Id AND RecordType.Name ='Accomplishment' 
                                                       ORDER BY Sort_Order__c];
        //Return the Accomplishment list so the records can be rendered in the Page
        return accomplishments;
    }
    
    // Declare a list for Technical Skills
    Public List <Technical_Skill__c> technicalSkills {get;set;}
    // Instantiate the get method to query Technical Skills
    Public List <Technical_Skill__c> getTechnicalSkills(){
        if(technicalSkills == null) technicalSkills = [SELECT Id, Name, Skills_List__c, Sort_Order__c 
                                                       FROM Technical_Skill__c 
                                                       WHERE Resume__r.Id= :res.Id
                                                       ORDER BY Sort_Order__c];
        //Return the Technical Skill list so the records can be rendered in the Page
        return technicalSkills;
    }
}