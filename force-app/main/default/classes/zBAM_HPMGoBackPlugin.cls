global class zBAM_HPMGoBackPlugin implements zqu.PaymentPageController.IHostedPageLiteGoBackPlugin{
    global PageReference navigateBack(String paymentMethodType) {
        return new PageReference('/apex/Manage_Billing_Account?id=' + System.currentPageReference().getParameters().get('field_passthrough1') + '&retId=' + System.currentPageReference().getParameters().get('field_passthrough2'));
    }
}