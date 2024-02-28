public without sharing class GuidedSellingProduct{
    public Product2 Product {get;set;}
    public Boolean selected {get;set;}
    public Boolean enabled {get;set;}
    public Double adjustedPrice {get;set;}
    public Integer currentQuantity {get;set;}
    public String currentBillingFrequency {get;set;}
    public String description {get;set;}
    public Double subtotal {get;set;}
    public Integer delayDays {get;set;}
    public Boolean isInOffer {get;set;}
    public Id pbeId {get;set;}
    public Integer numOfPayments {get;set;}
    public Id Id {get {return this.Product?.Id;} set;}

    public GuidedSellingProduct(Product2 prod){
        this.Product = prod;
        this.selected = false;
        this.enabled = true;
        this.currentQuantity = 1;
        this.currentBillingFrequency = prod.Billing_Frequency__c;
        this.delayDays = 0;
        this.isInOffer = false;
        this.adjustedPrice = 0;
        this.subtotal = 0;
        this.numOfPayments = 1;
        this.description = prod.HTML_Description__c;
        this.Product.HTML_Description__c = '';
    }
}