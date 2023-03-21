global class Z_PaymentPage_IHostedPageLitePluginWiz implements zqu.PaymentPageController.IHostedPageLitePlugin {
    global Map < String, String > getAdditionalParameters(String paymentMethodType) {
        Map < String, String > defaultValues = new Map < String, String >();
        // Default client parameters
        defaultValues.put('field_creditCardCountry', 'USA');
        
        return defaultValues;
    }
}