public without sharing class ReportUtils {

    // public static List<Report> getPrivateReports(){

    //     return [SELECT Id, FolderName, Name FROM Report WHERE FolderName = 'Private Reports'];

    // }

    //@InvocableMethod(label='Get Orphan Private Reports' description='Retrieve a list of reports that sit in private folders where users are no longer active.' category='Report Management')
    public static List<Report> getPrivateOrphanReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = false AND IsDeleted = false];
        
        return reports;
    }

    //@InvocableMethod(label='Get Active User Private Reports' description='Retrieve a list of reports that sit in private folders where users are active.' category='Report Management')
    public static List<Report> getPrivateReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = true AND IsDeleted = false];
        
        return reports;
    }

    //@InvocableMethod(label='Get Stale Private Reports By Age' description='Retrieve a list of reports that sit in private folders where users are active and have not been run for a period of time.' category='Report Management')
    public static List<Report> getStalePrivateReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = true AND IsDeleted = false];
        
        return reports;
    }

    public static void undeletedReports(){

        List<Report> reports = [SELECT Id, IsDeleted FROM Report USING SCOPE allPrivate WHERE IsDeleted = true ALL ROWS];

        if (reports.size() > 0){

            try{
                undelete reports;
            } catch (DmlException e) {
                System.debug(ERROR, 'Error occurred undeleting report records ' + e.getMessage());
            }

        }
    }

    public static void testDeletedReports(){

        List<Report> reports = [SELECT Id, IsDeleted FROM Report USING SCOPE allPrivate WHERE IsDeleted = false LIMIT 1];

        if (reports.size() > 0){

            try{
                delete reports;
            } catch (DmlException e) {
                System.debug(ERROR, 'Error occurred deleting report records ' + e.getMessage());
            }

        }
    }

}