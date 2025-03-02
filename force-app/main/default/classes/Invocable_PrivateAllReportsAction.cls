public without sharing class Invocable_PrivateAllReportsAction {

    // public Invocable_PrivateAllReportsAction() {

    // }

    @InvocableMethod(label='Get All Private Reports' description='Retrieve a list of reports that sit in private folders.' category='Report Management')
    public static List<Report> getPrivateReports_INV(List<InvocableVar_UserStatus> inputUserStatus){

        List<Report> results = new List<Report>();

        for (InvocableVar_UserStatus status : inputUserStatus){
            results.addAll(ReportUtils.invokeGetPrivateReports(status.userStatus));
        }

        return results;
    }

    public class InvocableVar_UserStatus {
        @InvocableVariable(defaultValue='All' label='Active Inactive or All Users' description='Specify whether the private report query should return all private reports, private reports for active users or private reports for inactive users.' required=false placeholderText='All, Active, Inactive')
        public String userStatus;
    }

}