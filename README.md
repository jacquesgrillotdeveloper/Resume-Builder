# Resume Builder App
The Resume builder app is meant for Admins, Developers, and other Salesforce afficianados to store their Resume on the Force.com platform. The app leverages declarative and programmatic features of the Force.com platform. 
I welcome any contributions to improve this app (especially for UI enhancements).

## Design
Please refer to the [Wiki](https://github.com/jacquesgrillotdeveloper/Resume-Builder/wiki) for Design.

## Dev, Build and Test
### Dev Status
#### Dev In Progress
* App is Dev Complete.
* A CSS version of the PDF resume is planned. No current estimate. The PDF version is using a bootstrapped design (via Visualstrap).
#### Dev Complete
* Object configuation completed.
* Process builder to set location for Experience records complete.
* Lightning App configured with Help in Lightning Bar.
* Help documentation in App complete.
* All Apex and Vf is complete.
### Build
* App is still under development - packaging, distributed, and public page still pending.
### Test
* Lightning App testing for entering data for resume complete.
## Issues
* PDF version of Resume is not perfect. I haven't figured out how to prevent pageblocks from splitting across pages. May be resolved via CSS version.
## Installation
* This App is intended to be developed and deployed through Salesforce DX.
    * Simply  fork this repo and deploy via SFDX.
* After forking my repo, clone the repo to your machine.
* Ensure you have a DevOrg authorized and create a scratch org.
* Push the project: 
    `sfdx:force:source:push`
* Assign the Resume_Builder permission set to your default user:
    `sfdx force:user:permset:assign --permsetname Resume_Builder`
* Push data from the TestData folder: 
    `sfdx force:data:tree:import --plan TestData/resume-data-tree-plan.json`
* Open your org: 
    `sfdx force:org:open`
* Set the record types for Account, Experience, and Achievement records
* Set the page layouts for Account, Contact, and Experience record types
* Edit the Resume Lightning App page - drag the Visualforce component under the Details component. Set the component to the ResumePagePDF, and the height to 500. 
