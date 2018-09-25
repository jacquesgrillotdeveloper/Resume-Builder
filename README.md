# Resume Builder App
The Resume builder app is meant for Admins, Developers, and other Salesforce afficianados to store their Resume on the Force.com platform. The app leverages declarative and programmatic features of the Force.com platform. 
I welcome any contributions to improve this app (especially for UI enhancements).
## Object Schema
The App uses standard and custom objects. It is recommended that this app is installed in a dev org. 
### Standard Objects
* Account object - Stores Organization information for Employers and Educational institutions (2 record types).
* Contact object - Main record for which the Resume is for.
### Custom Objects
* Resume Object - Main object for Resume record. Child of Contact record. Lookup relationship used in order to expose resume to an external page. Master of Achievement, Experience, and Tech Skills objects.
* Achievement object - Stores Certifications and Achievements (2 record types).
* Experience object - Stores Education, Professional, and Professional Development (training) information (3 record types).
* Technical Skills object - listing of technical skills.
## Dev, Build and Test
### Dev Status
#### Dev In Progress
* Visualforce page for Resume internal, external 90% complete.
* Visualforce page for Resume in PDF version under development.
* Controller Extension complete. Test classes under development.
* Launching the Vf Pages will be configured.
#### Dev Complete
* Object configuation completed.
* Process builder to set location for Experience records complete.
* Lightning App configured with Help in Lightning Bar.
* Help documentation in App complete.
#### Build
* App is still under development - packaging, distributed, and public page still pending.
#### Test
* Lightning App testing for entering data for resume complete.
## Description of Files and Directories
### To be populated once app is ready for distribution.
## Issues
### To be populated once app is ready for distribution.
## Installation
* COMING SOON - If you simply want to use this app for your resume on a developer org navigate to the App Exchange
* If you want to use this Project with Salesforce DX for getting used to the tool fork this repo and deploy via SFDX
* After forking my repo, clone the repo to your machine
* Ensure you have a DevOrg authorized and create a scratch org
* Push the project: sfdx:force:source:push
* Assign the Resume_Builder permission set to your default user: sfdx force:user:permset:assign --permsetname Resume_Builder
* Push data from the TestData folder: sfdx force:data:tree:import --plan TestData/resume-data-tree-plan.json
* Open your org: sfdx force:org:open
* Set the record types for Account, Experience, and Achievement records
* Set the page layouts for Account, Contact, and Experience record types
* Edit the Resume Lightning App page - drag the Visualforce component under the Details component. Set the component to the ResumePagePDF, and the height to 500. 