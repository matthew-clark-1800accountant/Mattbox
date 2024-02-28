public with sharing class GuidedSellingProductLineController {
    public GuidedSellingProduct productValue {get; set;}
    public String unitPrice; //{get {return formatMoney(productValue?.adjustedPrice);} set;}
    public String prodSubtotal;// {get {return formatMoney(productValue?.subtotal);} set;}

    public String getUnitPrice(){
        return formatMoney(productValue?.adjustedPrice);
    }

    public void setUnitPrice(String val){}

    public String getprodSubtotal(){
        return formatMoney(productValue?.subtotal);
    }

    public void setprodSubtotal(String val){}

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