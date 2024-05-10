public without sharing class GuidedSellingQuestionWrapper{
    public Boolean Visible {get;set;}
    public String EngageText {get;set;}
    public Boolean IncludesEngageText {get;set;}
    public String PicklistOptions {get;set;}
    public String QuestionText {get;set;}
    public String QuestionType {get;set;}
    public Boolean Required {get;set;}
    public String DevName {get;set;}
    public Boolean Answered {get;set;}
    public String Value {get;set;}
    public String AccountFieldMapping {get;set;}
    public String BusinessFieldMapping {get;set;}
    public List<String> FilterTags {get;set;}
    public List<String> PicklistValuesFromObject {get;set;}
    public String ParentQuestionName {get;set;}

    public GuidedSellingQuestionWrapper(Guided_Selling_Discovery_Question__mdt questionRecord){
        //System.debug(questionRecord);
        this.Visible = questionRecord.Display_By_Default__c;
        this.EngageText = questionRecord.Engage_Text__c;
        this.IncludesEngageText = questionRecord.Includes_Engage_Text__c;
        this.PicklistOptions = questionRecord.Picklist_Options__c;
        this.QuestionText = questionRecord.Question_Text__c;
        this.QuestionType = questionRecord.Question_Type__c;
        this.Required = questionRecord.Required__c;
        this.DevName = questionRecord.DeveloperName;
        this.Answered = false;
        this.AccountFieldMapping = questionRecord.Account_Field_Mapping__c;
        this.BusinessFieldMapping = questionRecord.Business_Field_Mapping__c;
        this.FilterTags = questionRecord.Filter_Tags__c?.split(';');
        this.PicklistValuesFromObject = new List<String>();
        this.ParentQuestionName = questionRecord.Parent_Question_Label__c;
    }
}