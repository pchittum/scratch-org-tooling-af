public without sharing class ReportUtils {

    public static List<Report> invokeGetPrivateReports(String userStatus){

        List<Report> resultReports;

        switch on userStatus {
            when 'All' {
                resultReports = getPrivateReports();
            }
            when 'Active' {
                resultReports = getPrivateActiveUserReports();
            }
            when 'Inactive' {
                resultReports = getPrivateOrphanReports();
            }
            when else {
                resultReports = new List<Report>();
            }
        }

        return resultReports;
    }

    public static List<Report> getPrivateOrphanReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = false AND IsDeleted = false];

        for (Report rpt: reports){
            System.debug('Developer Name: ' + rpt.DeveloperName);
            System.debug('Owner: ' + rpt.Owner.Name);
            System.debug('Active User? : ' + rpt.Owner.IsActive);
        }
        
        
        return reports;
    }

    public static List<Report> getPrivateActiveUserReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = true AND IsDeleted = false];

        for (Report rpt: reports){
            System.debug('Developer Name: ' + rpt.DeveloperName);
            System.debug('Owner: ' + rpt.Owner.Name);
            System.debug('Active User? : ' + rpt.Owner.IsActive);
        }
        
        
        return reports;
    }

    public static List<Report> getPrivateReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE IsDeleted = false];

        for (Report rpt: reports){
            System.debug('Developer Name: ' + rpt.DeveloperName);
            System.debug('Owner: ' + rpt.Owner.Name);
            System.debug('Active User? : ' + rpt.Owner.IsActive);
        }
        
        return reports;
    }

    public static List<Report> getStalePrivateReports() {
        List<Report> reports = new List<Report>();

        reports = [SELECT Id, Name, DeveloperName, Owner.Name, Owner.IsActive FROM Report USING SCOPE allPrivate WHERE Owner.IsActive = true AND IsDeleted = false];
        
        return reports;
    }

    // public static void undeletedReports(){

    //     List<Report> reports = [SELECT Id, IsDeleted FROM Report USING SCOPE allPrivate WHERE IsDeleted = true ALL ROWS];

    //     if (reports.size() > 0){

    //         try{
    //             undelete reports;
    //         } catch (DmlException e) {
    //             System.debug(ERROR, 'Error occurred undeleting report records ' + e.getMessage());
    //         }

    //     }
    // }

    // public static void testDeletedReports(){

    //     List<Report> reports = [SELECT Id, IsDeleted FROM Report USING SCOPE allPrivate WHERE IsDeleted = false LIMIT 1];

    //     if (reports.size() > 0){

    //         try{
    //             delete reports;
    //         } catch (DmlException e) {
    //             System.debug(ERROR, 'Error occurred deleting report records ' + e.getMessage());
    //         }

    //     }
    // }

}