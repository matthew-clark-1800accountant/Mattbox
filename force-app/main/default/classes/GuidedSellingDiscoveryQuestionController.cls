public without sharing class GuidedSellingDiscoveryQuestionController {
    public GuidedSellingQuestionWrapper questionRecord {get; set;}
    public String defaultFromRecord {get;set;}
    /*
        Metadata fields:
        Display_By_Default__c - Checkbox
        Engage_Text__c - Text Area(255)
        Includes_Engage_Text__c - Checkbox
        Picklist_Options__c - Long Text Area(32768)
        Question_Text__c - Text Area(255)
        Question_Type__c - Picklist (Boolean, Date, State, Single Selection, Multi Selection, Text Only)
        Required__c - Checkbox
    */
   
    public String unitPrice; //{get {return formatMoney(productValue?.adjustedPrice);} set;}
    public String prodSubtotal;// {get {return formatMoney(productValue?.subtotal);} set;}

    public List<SelectOption> optionList {get{
        if(questionRecord == null){
            return new List<SelectOption>{new SelectOption('Select an option', 'Select an option', true), new SelectOption('No question found','No question found')};
        }
        if((questionRecord.QuestionType == 'Single Selection' || questionRecord.QuestionType == 'Multi Selection') && questionRecord.PicklistOptions != null){
            return stringsToOptions(questionRecord.PicklistOptions.split(';'), true);
        }
        if(!questionRecord.PicklistValuesFromObject.isEmpty()){
            return stringsToOptions(questionRecord.PicklistValuesFromObject, false);
        }
        if(questionRecord.QuestionType == 'State') {
            return getStateList();
        }
        System.debug(questionRecord);
        return new List<SelectOption>{new SelectOption('Select an option', 'Select an option', true), new SelectOption('No answers found','No answers found')};
    } set;}

    public String defaultValue {get{
        String returnValue = 'Select an option';
        System.debug(questionRecord);
        // if(questionRecord?.QuestionType == 'State'){
        //     System.debug('QuestionType: '+questionRecord?.QuestionType);
        //     returnValue = 'Select a State';
        // }
        if(defaultFromRecord != null){
            System.debug('defaultFromRecord: '+defaultFromRecord);
            returnValue = defaultFromRecord;
        }
        if(questionRecord?.Value != null){
            System.debug('Value: '+questionRecord.Value);
            returnValue = questionRecord.Value;
        }
        // if(optionList.size() > 0 && questionRecord.PicklistValuesFromObject.isEmpty()){
        //     return optionList[0].getLabel();
        // }

        return returnValue;
    } set;}

    public List<String> defaultValueList {get{
        if(questionRecord == null || questionRecord.Value == null){
            return new List<String>();
        } else {
            return questionRecord.Value.split(';');
        }
        
    } set;}

    public Boolean isPicklist {get{
        return questionRecord.QuestionType == 'Single Selection' || questionRecord.QuestionType == 'Multi Selection' || questionRecord.QuestionType == 'State';
    } set;}

    public Boolean isSinglePicklist {get{
        return questionRecord.QuestionType == 'Single Selection' || questionRecord.QuestionType == 'State';
    } set;}

    public List<SelectOption> getStateList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select an option', 'Select an option', true));
        options.add(new SelectOption('Alabama', 'Alabama'));
        options.add(new SelectOption('Alaska', 'Alaska'));
        options.add(new SelectOption('Arizona', 'Arizona'));
        options.add(new SelectOption('Arkansas', 'Arkansas'));
        options.add(new SelectOption('California', 'California'));
        options.add(new SelectOption('Colorado', 'Colorado'));
        options.add(new SelectOption('Connecticut', 'Connecticut'));
        options.add(new SelectOption('Dist. of Columbia', 'Dist. of Columbia'));
        options.add(new SelectOption('Delaware', 'Delaware'));
        options.add(new SelectOption('Florida', 'Florida'));
        options.add(new SelectOption('Georgia', 'Georgia'));
        options.add(new SelectOption('Hawaii', 'Hawaii'));
        options.add(new SelectOption('Idaho', 'Idaho'));
        options.add(new SelectOption('Illinois', 'Illinois'));
        options.add(new SelectOption('Indiana', 'Indiana'));
        options.add(new SelectOption('Iowa', 'Iowa'));
        options.add(new SelectOption('Kansas', 'Kansas'));
        options.add(new SelectOption('Kentucky', 'Kentucky'));
        options.add(new SelectOption('Louisiana', 'Louisiana'));
        options.add(new SelectOption('Maine', 'Maine'));
        options.add(new SelectOption('Maryland', 'Maryland'));
        options.add(new SelectOption('Massachusetts', 'Massachusetts'));
        options.add(new SelectOption('Michigan', 'Michigan'));
        options.add(new SelectOption('Minnesota', 'Minnesota'));
        options.add(new SelectOption('Mississippi', 'Mississippi'));
        options.add(new SelectOption('Missouri', 'Missouri'));
        options.add(new SelectOption('Montana', 'Montana'));
        options.add(new SelectOption('Nebraska', 'Nebraska'));
        options.add(new SelectOption('Nevada', 'Nevada'));
        options.add(new SelectOption('New Hampshire', 'New Hampshire'));
        options.add(new SelectOption('New Jersey', 'New Jersey'));
        options.add(new SelectOption('New Mexico', 'New Mexico'));
        options.add(new SelectOption('New York', 'New York'));
        options.add(new SelectOption('North Carolina', 'North Carolina'));
        options.add(new SelectOption('North Dakota', 'North Dakota'));
        options.add(new SelectOption('Ohio', 'Ohio'));
        options.add(new SelectOption('Oklahoma', 'Oklahoma'));
        options.add(new SelectOption('Oregon', 'Oregon'));
        options.add(new SelectOption('Pennsylvania', 'Pennsylvania'));
        options.add(new SelectOption('Rhode Island', 'Rhode Island'));
        options.add(new SelectOption('South Carolina', 'South Carolina'));
        options.add(new SelectOption('South Dakota', 'South Dakota'));
        options.add(new SelectOption('Tennessee', 'Tennessee'));
        options.add(new SelectOption('Texas', 'Texas'));
        options.add(new SelectOption('Utah', 'Utah'));
        options.add(new SelectOption('Vermont', 'Vermont'));
        options.add(new SelectOption('Virginia', 'Virginia'));
        options.add(new SelectOption('Washington', 'Washington'));
        options.add(new SelectOption('West Virginia', 'West Virginia'));
        options.add(new SelectOption('Wisconsin', 'Wisconsin'));
        options.add(new SelectOption('Wyoming', 'Wyoming'));
        return options;
    }

    public List<SelectOption> stringsToOptions(List<String> stringList, Boolean disableFirst){
        List<SelectOption> options = new List<SelectOption>();
        if(isSinglePicklist){
            options.add(new SelectOption('Select an option', 'Select an option', true));
        }
        
        for(String s : stringList){
            options.add(new SelectOption(s, s));
        }
        // if(!options.isEmpty()){
        //     options[0].setDisabled(disableFirst);
        // }
        return options;
    }



    public GuidedSellingDiscoveryQuestionController() {
    }

    public String formatMoney(Decimal amount){
        if(amount == null){
            return '';
        } else if(amount == 0){
            return '$0.00';
        }
        return '$'+String.valueOf(amount.setScale(2)).replaceAll('/\\d(?=(\\d{3})+\\.)/g', '$&,');
   }
}