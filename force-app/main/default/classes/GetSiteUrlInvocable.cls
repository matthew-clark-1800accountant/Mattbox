public with sharing class GetSiteUrlInvocable {
    @InvocableMethod(label='Get Base URL For Guided Selling Site' description='Get Base URL For Guided Selling Site')
    public static List<String> getSiteBaseUrl(){
        Site mySite = [select Id from Site where Name = 'Guided_Selling_Client_View'];
        SiteDetail mySiteDetail = [select SecureURL from SiteDetail where DurableId = :mySite.Id];
        String url = mySiteDetail.SecureURL.substring(0, mySiteDetail.SecureURL.indexOf('.com/')+4);
        System.debug(url);
        return new List<String>{url};
    }
}