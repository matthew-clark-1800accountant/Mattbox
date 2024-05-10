public with sharing class GuidedSellingProductLineController {
    public GuidedSellingProduct productValue {get; set;}
    public String unitPrice; //{get {return formatMoney(productValue?.adjustedPrice);} set;}
    public String prodSubtotal;// {get {return formatMoney(productValue?.subtotal);} set;}

    public Boolean getdisableQuantity(){
        return (productValue.Product.Disable_QTY_on_Calc__c || !productValue.quantityEnabled);
    }
    public void setdisableQuantity(Boolean val){}

    public String getUnitPrice(){
        return formatMoney(productValue?.adjustedPrice);
    }

    public void setUnitPrice(String val){}

    public String getprodSubtotal(){
        return formatMoney(productValue?.subtotal);
    }

    public void setprodSubtotal(String val){}

    public String getdisplayRow(){
        if(productValue.visible){
            return 'table-row';
        } else {
            return 'none';
        }
    }

    public void setdisplayRow(String val){}

    public GuidedSellingProductLineController() {
        
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