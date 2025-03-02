# Documentation for Agentforce Actions and Agents in this project. 

## Actions

### Get All Private Reports
**Type:** Apex
**Source Metadata:** `Invocable_PrivateAllReportsAction.cls`

#### Agent Action Instructions
Retrieve a list of reports that sit in private folders. 

This action is good for getting information about all of the private reports in this org, in other words reports which sit in private folders. 

In the context of reports and report folders, a private folder means a folder that is only directly accessible by the user who created the report. Without extra work there is no easy way for a Salesforce administrator to access, view, or even list reports that are in private folders. 

This action helps a user with the following tasks: 
- List names of reports in private folders 
- List the developer name of reports in private folders
- list the names of the users with reports in private folders and whether they are active users or not

This action accesses records from the report object but only where those records are in private folders. 

Each report record will have information from the following fields: 
- Id
- Name (the human readable name of the report)
- DeveloperName (the unique report name, which can also be used as a unique referent to the report to delete it using the tooling API)
- Owner.Name (the name of the user who owns the report and whose private folder the report resides in)
- Owner.IsActive (a true/false value where true identifies and active user and false identifies an inactive or deactivated user)

You might expect some of the following phrases to indicate this action is useful: 
- "private reports"
- "reports in private folders"
- "private user reports"
- "reports that are private"
- "reports that are in private folders"
- "all private reports" 

#### Output Format Instructions
Display the list of reports with the following fields: 
- Name
- DeveloperName (as "Developer Name")
- Owner.Name (as "User")
- Owner.IsActive (as "User Active?")