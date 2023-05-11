public class PricingCalcController {
    public class MisconfiguredMetadataException extends Exception {}

    public List<SelectOption> entityType {get;set;}
    public List<SelectOption> foreignOwners {get;set;}
    public List<SelectOption> industryType {get;set;}
    public List<SelectOption> livingAbroad {get;set;}
    public List<SelectOption> numberOfContractors {get;set;}
    public List<SelectOption> numberOfEmployees {get;set;}
    public List<SelectOption> numberOfK1s {get;set;}
    public List<SelectOption> numberOfOwners {get;set;}
    public List<SelectOption> numberOfTransactions {get;set;}
    public List<SelectOption> numberOfRentalProperties {get;set;}
    public List<SelectOption> personalIncome {get;set;}
    public List<SelectOption> projectedFirstYearProfit {get;set;}
    public List<SelectOption> projectedFirstYearRevenue {get;set;}
    public List<SelectOption> stateOfIncorporation {get;set;}
    public List<SelectOption> totalInvestorFunding {get;set;}
    public List<SelectOption> totalStartupCost {get;set;}
    public List<SelectOption> websiteSellingGoods {get;set;}
    public List<SelectOption> workedWithAccountantInPast {get;set;}
    public List<SelectOption> runPayrollBefore {get;set;}
    public List<SelectOption> filingStatus {get;set;}
    
    public List<SelectOption> businessMiles {get;set;}
    public List<SelectOption> officeSqFt {get;set;}
    public List<SelectOption> foreignState {get;set;}
    public List<SelectOption> yearsInBusiness {get;set;}
    
    public List<SelectOption> bundleItems {get;set;}
    public List<SelectOption> billingItems {get;set;}
    public List<SelectOption> timeItems {get;set;}
    public List<SelectOption> billingStateItems {get;set;}
    public List<SelectOption> billingCountryItems {get;set;}
    public List<SelectOption> stateOfResidenceItems {get;set;}
    
    public List<Product2> acListP {get;set;}
    public List<Product2> acListProducts {get;set;}
    //public List<Product2> bundle1List {get;set;}
    //public List<String> acList {get;set;}
    
    Public String entityTypeInput {get;set;}
    public String foreignOwnersInput {get;set;}
    public String industryTypeInput {get;set;}
    public String livingAbroadInput {get;set;}
    public String numberOfContractorsInput {get;set;}
    public String numberOfEmployeesInput {get;set;}
    public String numberOfK1sInput {get;set;}
    public String numberOfOwnersInput {get;set;}
    public String numberOfTransactionsInput {get;set;}
    public String numberOfRentalPropertiesInput {get;set;}
    public String personalIncomeInput {get;set;}
    public String projectedFirstYearProfitInput {get;set;}
    public String projectedFirstYearRevenueInput {get;set;}
    public String stateOfIncorporationInput {get;set;}
    public String totalInvestorFundingInput {get;set;}
    public String totalStartupCostInput {get;set;}
    public String websiteSellingGoodsInput {get;set;}
    public String workedWithAccountantInPastInput {get;set;}
    public String runPayrollBeforeInput {get;set;}
    public String filingStatusInput {get;set;}
    
    public String businessMilesInput {get;set;}
    public String officeSqFtInput {get;set;}
    public String foreignStateInput {get;set;}
    public String yearsInBusinessInput {get;set;}
    
    public String emailCampaignIDInput {get;set;}
    
    public String bundle {get;set;}
    public String billingTime {get;set;}
    public String accountNameInput {get;set;}
    public String billingStateInput {get;set;}
    public String billingCountryInput {get;set;}
    public String billingStreetInput {get;set;}
    public String billingCityInput {get;set;}
    public String billingZipInput {get;set;}
    public String LeadTypeNew = '';
    public String LeadSource = '';
    public String UserSkill {get;set;}
    public String BundleOverride {get;set;}
    
    public String stateOfResidenceInput {get;set;}
    
    Public String entityTypeClass {get;set;}
    public String foreignOwnersClass {get;set;}
    public String industryTypeClass {get;set;}
    public String livingAbroadClass {get;set;}
    public String numberOfContractorsClass {get;set;}
    public String numberOfEmployeesClass {get;set;}
    public String numberOfK1sClass {get;set;}
    public String numberOfOwnersClass {get;set;}
    public String numberOfTransactionsClass {get;set;}
    public String numberOfRentalPropertiesClass {get;set;}
    public String personalIncomeClass {get;set;}
    public String projectedFirstYearProfitClass {get;set;}
    public String projectedFirstYearRevenueClass {get;set;}
    public String stateOfIncorporationClass {get;set;}
    public String totalInvestorFundingClass {get;set;}
    public String totalStartupCostClass {get;set;}
    public String websiteSellingGoodsClass {get;set;}
    public String workedWithAccountantInPastClass {get;set;}
    public String runPayrollBeforeClass {get;set;}
    public String filingStatusClass {get;set;}
    
    public String businessMilesClass {get;set;}
    public String officeSqFtClass {get;set;}
    
    public String foreignStateClass {get;set;}
    public String yearsInBusinessClass {get;set;}
    
    public String redirURL {get;set;}
    
    public Boolean doBusinessReturn {get;set;}
    public Boolean doPersonalReturn {get;set;}
    public Boolean doPayroll {get;set;}
    public Boolean doAdvisory {get;set;}
    public Boolean doBookkeeping {get;set;}
    public Boolean doStateFiling {get;set;}
    public Boolean doStateFilingCorp {get;set;}
    public Boolean doBackBookkeeping {get;set;}
    public Boolean doForeignState {get;set;}
    
    public Boolean doBackPayroll {get;set;}
    public Boolean doBackBusiness {get;set;}
    public Boolean doBackPersonal {get;set;}
    public Boolean doNonProfitBookkeeping {get;set;}
    
    public Boolean excludeBusinessReturn {get;set;}
    public Boolean excludePersonalReturn {get;set;}
    public Boolean excludePayroll {get;set;}
    public Boolean excludeAdvisory {get;set;}
    public Boolean excludeBookkeeping {get;set;}
    public Boolean excludeStateFiling {get;set;}
    public Boolean excludeStateFilingCorp {get;set;}
    public Boolean excludeBackBookkeeping {get;set;}
    public Boolean excludeForeignState {get;set;}
    
    public Boolean excludeBackPayroll {get;set;}
    public Boolean excludeBackBusiness {get;set;}
    public Boolean excludeBackPersonal {get;set;}
    public Boolean excludeNonProfitBookkeeping {get;set;}
    
    public Boolean disableBusinessReturn {get;set;}
    public Boolean disablePersonalReturn {get;set;}
    public Boolean disablePayroll {get;set;}
    public Boolean disableAdvisory {get;set;}
    public Boolean disableBookkeeping {get;set;}
    public Boolean disableStateFiling {get;set;}
    public Boolean disableStateFilingCorp {get;set;}
    public Boolean disableBackBookkeeping {get;set;}
    public Boolean disableForeignState {get;set;}
    
    public Boolean disableBackPayroll {get;set;}
    public Boolean disableBackBusiness {get;set;}
    public Boolean disableBackPersonal {get;set;}
    public Boolean disableNonProfitBookkeeping {get;set;}
    
    public String disableBusinessReturnMessage {get;set;}
    public String disablePersonalReturnMessage {get;set;}
    public String disablePayrollMessage {get;set;}
    public String disableAdvisoryMessage {get;set;}
    public String disableBookkeepingMessage {get;set;}
    public String disableStateFilingMessage {get;set;}
    public String disableStateFilingCorpMessage {get;set;}
    public String disableBackBookkeepingMessage {get;set;}
    public String disableForeignStateMessage {get;set;}
    
    public String disableBackPayrollMessage {get;set;}
    public String disableBackBusinessMessage {get;set;}
    public String disableBackPersonalMessage {get;set;}
    public String disableNonProfitBookkeepingMessage {get;set;}
    
    public Boolean disableQTYBusinessReturn {get;set;}
    public Boolean disableQTYPersonalReturn {get;set;}
    public Boolean disableQTYPayroll {get;set;}
    public Boolean disableQTYAdvisory {get;set;}
    public Boolean disableQTYBookkeeping {get;set;}
    public Boolean disableQTYStateFiling {get;set;}
    public Boolean disableQTYStateFilingCorp {get;set;}
    public Boolean disableQTYBackBookkeeping {get;set;}
    public Boolean disableQTYForeignState {get;set;}
    
    public Boolean disableQTYBackPayroll {get;set;}
    public Boolean disableQTYBackBusiness {get;set;}
    public Boolean disableQTYBackPersonal {get;set;}
    public Boolean disableQTYNonProfitBookkeeping {get;set;}
    
    public Boolean showBundles {get;set;}
    
    public Boolean optionBusinessReturn {get;set;}
    public Boolean optionPersonalReturn {get;set;}
    public Boolean optionPayroll {get;set;}
    public Boolean optionAdvisory {get;set;}
    public Boolean optionBookkeeping {get;set;}
    public Boolean optionStateFiling {get;set;}
    public Boolean optionStateFilingCorp {get;set;}
    public Boolean optionBackBookkeeping {get;set;}
    public Boolean optionForeignState {get;set;}
    
    public Boolean optionBackPayroll {get;set;}
    public Boolean optionBackBusiness {get;set;}
    public Boolean optionBackPersonal {get;set;}
    public Boolean optionNonProfitBookkeeping {get;set;}
    
    // platform access
    public Boolean hasPlatformAccess {get;set;}
 
    // hold relevant ids
    public String opportunityID {get;set;}
    public String accountID {get;set;}
    public String quoteID {get;set;}
    public String cOQuoteID {get;set;}
    public String cOQuoteIDMonth {get;set;}
    public String cOQuoteIDOneTime {get;set;}
    
    // variables for main pricing
    public Decimal businessAdjustment {get;set;}
    public Decimal personalAdjustment {get;set;}
    public Decimal payrollAdjustment {get;set;}
    public Decimal taxAdvisoryPrice {get;set;}
    public Decimal totalBPPPAd {get;set;}
    public Decimal bookkeepingAdjustment {get;set;}
    public Decimal stateFilingAdjustment {get;set;}
    public Decimal stateFilingCorpAdjustment {get;set;}
    public Decimal backBookkeepingAdjustment {get;set;}
    public Decimal foreignStateAdjustment {get;set;}
    
    public Decimal backPayrollAdjustment {get;set;}
    public Decimal backBusinessAdjustment {get;set;}
    public Decimal backPersonalAdjustment {get;set;}
    public Decimal nonProfitBookkeepingAdjustment {get;set;}
    
    // variables for setup fees
    public Decimal businessFee {get;set;}
    public Decimal personalFee {get;set;}
    public Decimal payrollFee {get;set;}
    public Decimal taxAdvisoryFee {get;set;}
    public Decimal bookkeepingFee {get;set;}
    public Decimal stateFilingFee {get;set;}
    public Decimal stateFilingCorpFee {get;set;}
    public Decimal backBookkeepingFee {get;set;}
    public Decimal foreignStateFee {get;set;}
    
    public Decimal backPayrollFee {get;set;}
    public Decimal backBusinessFee {get;set;}
    public Decimal backPersonalFee {get;set;}
    public Decimal nonProfitBookkeepingFee {get;set;}
    
    public Decimal totalAdjustment {get;set;}
    
    public Integer businessQuantity {get;set;}
    public Integer personalQuantity {get;set;}
    public Integer payrollQuantity {get;set;}
    public Integer taxAdvisoryQuantity {get;set;}
    public Integer bookkeepingQuantity {get;set;}
    public Integer stateFilingQuantity {get;set;}
    public Integer stateFilingCorpQuantity {get;set;}
    public Integer backBookkeepingQuantity {get;set;}
    public Integer foreignStateQuantity {get;set;}
    
    public Integer backPayrollQuantity {get;set;}
    public Integer backBusinessQuantity {get;set;}
    public Integer backPersonalQuantity {get;set;}
    public Integer nonProfitBookkeepingQuantity {get;set;}
    
    public Decimal businessSort {get;set;}
    public Decimal personalSort {get;set;}
    public Decimal payrollSort {get;set;}
    public Decimal taxAdvisorySort {get;set;}
    public Decimal bookkeepingSort {get;set;}
    public Decimal stateFilingSort {get;set;}
    public Decimal stateFilingCorpSort {get;set;}
    public Decimal backBookkeepingSort {get;set;}
    public Decimal foreignStateSort {get;set;}
    
    public Decimal backPayrollSort {get;set;}
    public Decimal backBusinessSort {get;set;}
    public Decimal backPersonalSort {get;set;}
    public Decimal nonProfitBookkeepingSort {get;set;}
    
    public String businessTime {get;set;}
    public String personalTime {get;set;}
    public String payrollTime {get;set;}
    public String taxAdvisoryTime {get;set;}
    public String bookkeepingTime {get;set;}
    public String stateFilingTime {get;set;}
    public String stateFilingCorpTime {get;set;}
    public String backBookkeepingTime {get;set;}
    public String foreignStateTime {get;set;}
    
    public String backPayrollTime {get;set;}
    public String backBusinessTime {get;set;}
    public String backPersonalTime {get;set;}
    public String nonProfitBookkeepingTime {get;set;}
    
    public String businessTimeDef {get;set;}
    public String personalTimeDef {get;set;}
    public String payrollTimeDef {get;set;}
    public String taxAdvisoryTimeDef {get;set;}
    public String bookkeepingTimeDef {get;set;}
    public String stateFilingTimeDef {get;set;}
    public String stateFilingCorpTimeDef {get;set;}
    public String backBookkeepingTimeDef {get;set;}
    public String foreignStateTimeDef {get;set;}
    
    public String backPayrollTimeDef {get;set;}
    public String backBusinessTimeDef {get;set;}
    public String backPersonalTimeDef {get;set;}
    public String nonProfitBookkeepingTimeDef {get;set;}
    
    public String stateFilingSetupFee {get; set;}
    public String stateFilingCorpSetupFee {get; set;}
    
    public String uniqueToken {get;set;}
    
    public String environment {get;set;}
    
    public String sCorpSavings {get;set;}
    public String homeOfficeSavings {get;set;}
    public String busMileSavings {get;set;}
    public String qbiSavings {get;set;}
    public String startupExpSavings {get;set;}
    public String potentialSavings {get;set;}
    
    public String bizTaxPrepID {get;set;}
    public String personalTaxPrepID {get;set;}
    public String payrollID {get;set;}
    public String taxAdvisoryID {get;set;}
    public String bookkeepingID {get;set;}
    public String stateFilingID {get;set;}
    public String stateFilingCorpID {get;set;}
    public String backBookkeepingID {get;set;}
    public String foreignStateID {get;set;}
    
    public String backPayrollID {get;set;}
    public String backBusinessID {get;set;}
    public String backPersonalID {get;set;}
    public String nonProfitBookkeepingID {get;set;}
    
    public Boolean bizTaxPrepNoSplit {get;set;}
    public Boolean personalTaxPrepNoSplit {get;set;}
    public Boolean payrollNoSplit {get;set;}
    public Boolean taxAdvisoryNoSplit {get;set;}
    public Boolean bookkeepingNoSplit {get;set;}
    public Boolean stateFilingNoSplit {get;set;}
    public Boolean stateFilingCorpNoSplit {get;set;}
    public Boolean backBookkeepingNoSplit {get;set;}
    public Boolean foreignStateNoSplit {get;set;}
    
    public Boolean backPayrollNoSplit {get;set;}
    public Boolean backBusinessNoSplit {get;set;}
    public Boolean backPersonalNoSplit {get;set;}
    public Boolean nonProfitBookkeepingNoSplit {get;set;}
    
    public static List<String> disqualifiers = new List<String>{'C Corporation', 'Non-Profit', 'Cryptocurrency', 'Investments', 'Not For Profit', 'Real Estate'};
    public Map<String,String> stateMap_toAbbrev = new Map<String,String>{ 'alabama'=>'AL','alaska'=>'AK','arizona'=>'AZ','arkansas'=>'AR','california'=>'CA','colorado'=>'CO','connecticut'=>'CT','delaware'=>'DE','district of columbia'=>'DC','florida'=>'FL','georgia'=>'GA','guam'=>'GU','hawaii'=>'HI','idaho'=>'ID','illinois'=>'IL','indiana'=>'IN','iowa'=>'IA','kansas'=>'KS','kentucky'=>'KY','louisiana'=>'LA','maine'=>'ME','maryland'=>'MD','massachusetts'=>'MA','michigan'=>'MI','minnesota'=>'MN','mississippi'=>'MS','missouri'=>'MO','montana'=>'MT','nebraska'=>'NE','nevada'=>'NV','new hampshire'=>'NH','new jersey'=>'NJ','new mexico'=>'NM','new york'=>'NY','north carolina'=>'NC','north dakota'=>'ND','ohio'=>'OH','oklahoma'=>'OK','oregon'=>'OR','pennsylvania'=>'PA','puerto rico'=>'PR','rhode island'=>'RI','south carolina'=>'SC','south dakota'=>'SD','tennessee'=>'TN','texas'=>'TX','utah'=>'UT','vermont'=>'VT','virginia'=>'VA','washington'=>'WA','west virginia'=>'WV','wisconsin'=>'WI','wyoming'=>'WY' };
    public Map<String,String> stateMap_toName = new Map<String,String>{ 'al'=>'Alabama','ak'=>'Alaska','az'=>'Arizona','ar'=>'Arkansas','ca'=>'California','co'=>'Colorado','ct'=>'Connecticut','de'=>'Delaware','dc'=>'District of Columbia','fl'=>'Florida','ga'=>'Georgia','gu'=>'Guam','hi'=>'Hawaii','id'=>'Idaho','il'=>'Illinois','in'=>'Indiana','ia'=>'Iowa','ks'=>'Kansas','ky'=>'Kentucky','la'=>'Louisiana','me'=>'Maine','md'=>'Maryland','ma'=>'Massachusetts','mi'=>'Michigan','mn'=>'Minnesota','ms'=>'Mississippi','mo'=>'Missouri','mt'=>'Montana','ne'=>'Nebraska','nv'=>'Nevada','nh'=>'New Hampshire','nj'=>'New Jersey','nm'=>'New Mexico','ny'=>'New York','nc'=>'North Carolina','nd'=>'North Dakota','oh'=>'Ohio','ok'=>'Oklahoma','or'=>'Oregon','pa'=>'Pennsylvania','pr'=>'Puerto Rico','ri'=>'Rhode Island','sc'=>'South Carolina','sd'=>'South Dakota','tn'=>'Tennessee','tx'=>'Texas','ut'=>'Utah','vt'=>'Vermont','va'=>'Virginia','wa'=>'Washington','wv'=>'West Virginia','wi'=>'Wisconsin','wy'=>'Wyoming' };
    
    //Wrapper list 
    public List<myWrapperClass> acList {get;set;}
    
    public List<priceWrapper> adjustList {get;set;}
    
    public List<bundleWrapperClass> bundleProductList {get;set;}
    
    public List<offerMasterWrapperClass> offerMasterList {get;set;}
    public List<offerProductWrapperClass> offerProductList {get;set;}
    
    public Set<String> excludeProductList {get;set;}
    public Set<String> disableProductList {get;set;}
    public Set<String> excludeOfferList {get;set;}
    
    public List<priceOverrideWrapper> overrideList {get;set;}
    
    public List<priceAdjustmentWrapper> adjustPriceList {get;set;}
    
    public List<productWrapper> envProductList {get;set;}
    
    public List<Active_Subscriptions__c> activeSubList {get;set;}
    
    public List<discountWrapper> discountList {get;set;}
    
    public List<dynamicRuleClass> dynamicRules {get;set;}
    
    //Your wrapper 
    public class myWrapperClass{

        public String id {get;set;}
        public String name {get;set;}
        public Decimal price {get; set;} 
        public String pbeid {get; set;}
        public Boolean doIt {get; set;}
        public Integer quantity {get; set;}
        public Boolean disableQTY {get; set;}
        public String billingTime {get; set;}
        public String billingTimeDef {get; set;}
        public String billingFreq {get; set;}
        public Boolean annualMonthlyOption {get; set;}
        public String htmlDescription {get; set;}
        public String productDescription {get; set;}
        public Boolean disableProduct {get; set;}
        public String disableMessage {get; set;}
        public Decimal quoteSort {get; set;}
        public String setupFee {get; set;}
        public Boolean masterOffer {get;set;}
        public Boolean noSplit {get;set;}
        // add billing schedule property
        
    }
    
    // dynamic wrapper class
    public class dynamicRuleClass{
    
        public String productId {get;set;}
        public String fieldName {get;set;}
        public String fieldValue {get;set;}
        public String fieldOperator {get;set;}
        public String action {get;set;}
        public String productLabel {get;set;}
    
    }
    
    public class bundleWrapperClass{
        
        public String id {get;set;}
        public String calcid {get;set;}
        public String bundlelist {get;set;}
        
    }
    
    public class offerMasterWrapperClass{
    
        public String id {get;set;}
        public String name {get;set;}
        public Boolean doIt {get;set;}
        public Integer sortOrder {get;set;}
        public Boolean defaultSel {get;set;}
    
    }
    
    public class offerProductWrapperClass{
        
        public String id {get;set;}
        public String offerId {get;set;}
        public String productName {get;set;}
        public String productId {get;set;}
        public Decimal amount {get;set;}
        public Decimal delayDays {get;set;}
        public Boolean master {get;set;}
        public Boolean upsell {get;set;}
        public String calcId {get;set;}
        public Boolean usePricebook {get;set;}
        
    }
    
    public class priceWrapper{
    
        public String field {get;set;}
        public String value {get;set;}
        public String product {get;set;}
        public Decimal amount {get;set;}
        public Boolean setupFee {get; set;} 
        // add billing schedule property
     
    }
    
    public class priceOverrideWrapper{
        
        public String productId {get;set;}
        public Decimal amount {get;set;}
        public String productPostion {get;set;}
        
    }
    
    public class priceAdjustmentWrapper{
        
        public String productId {get;set;}
        public Decimal amount {get;set;}
        public Decimal percent {get;set;}
        public String productPostion {get;set;}
        
    }
    
    public class productWrapper{
        
        public String Id {get;set;}
        public String Name {get;set;}
        public String Bundles {get;set;}
        public Boolean Disable_QTY_on_Calc {get;set;}
        public String RevenueInstallmentPeriod {get;set;}
        public String Billing_Frequency {get;set;}
        public String AnnualMonthlyOption {get;set;}
        public String Description {get;set;}
        public String HTML_Description {get;set;}
        public String Sort_Order {get;set;}
        public String Setup_Fee {get;set;}
        public String Calculator_Location {get;set;}
        public String EnvironmentList {get;set;}
        public Boolean MasterOffer {get;set;}
        
    }
    
    public class discountWrapper{
        
        public String DiscountType {get;set;}
        public Boolean DisplayDiscount {get;set;}
        public Decimal Amount {get;set;}
        
    }
    
    public String changeStateToAbbrev(String state_name){ 
      
        if(state_name==NULL){ return state_name; }
        
        String state_name_lCase = state_name.toLowerCase().trim(); // lower case and trim for better matching.
        
        return stateMap_toAbbrev.containsKey(state_name_lCase) ? stateMap_toAbbrev.get(state_name_lCase) : state_name; // return a match if there is one.
        
    }

    public static void kobyTest(String test){
        System.debug(test);
    }

    public PricingCalcController(){
        
    
        showBundles = false;
    
        businessAdjustment = 0.00;
        personalAdjustment = 0.00;
        payrollAdjustment = 0.00;
        taxAdvisoryPrice = 0.00;
        bookkeepingAdjustment = 0.00;
        stateFilingAdjustment = 0.00;
        stateFilingCorpAdjustment = 0.00;
        backBookkeepingAdjustment = 0.00;
        foreignStateAdjustment = 0.00;
        backPayrollAdjustment = 0.00;
        backBusinessAdjustment = 0.00;
        backPersonalAdjustment = 0.00;
        nonProfitBookkeepingAdjustment = 0.00;
        
        totalAdjustment = 0.00;
        
        sCorpSavings = '0.00';
        homeOfficeSavings = '0.00';
        busMileSavings = '0.00';
        qbiSavings = '0.00';
        startupExpSavings = '0.00';
        potentialSavings = '0.00';
        
        businessQuantity = 1;
        personalQuantity = 1;
        payrollQuantity = 1;
        taxAdvisoryQuantity = 1;
        bookkeepingQuantity = 1;
        stateFilingQuantity = 1;
        stateFilingCorpQuantity = 1;
        backBookkeepingQuantity = 1;
        foreignStateQuantity = 1;
        backPayrollQuantity = 1;
        backBusinessQuantity = 1;
        backPersonalQuantity = 1;
        nonProfitBookkeepingQuantity = 1;
        
        excludeBusinessReturn = false;
        excludePersonalReturn = false;
        excludePayroll = false;
        excludeAdvisory = false;
        excludeBookkeeping = false;
        excludeStateFiling = false;
        excludeStateFilingCorp = false;
        excludeBackBookkeeping = false;
        excludeForeignState = false;
        excludeBackPayroll = false;
        excludeBackBusiness = false;
        excludeBackPersonal = false;
        excludeNonProfitBookkeeping = false;
        
        disableQTYBusinessReturn = false;
        disableQTYPersonalReturn = false;
        disableQTYPayroll = false;
        disableQTYAdvisory = false;
        disableQTYBookkeeping = false;
        disableQTYStateFiling = false;
        disableQTYStateFilingCorp = false;
        disableQTYBackBookkeeping = false;
        disableQTYForeignState = false;
        disableQTYBackPayroll = false;
        disableQTYBackBusiness = false;
        disableQTYBackPersonal = false;
        disableQTYNonProfitBookkeeping = false;
        
        disableBusinessReturn = false;
        disablePersonalReturn = false;
        disablePayroll = false;
        disableAdvisory = false;
        disableBookkeeping = false;
        disableStateFiling = false;
        disableStateFilingCorp = false;
        disableBackBookkeeping = false;
        disableForeignState = false;
        disableBackPayroll = false;
        disableBackBusiness = false;
        disableBackPersonal = false;
        disableNonProfitBookkeeping = false;
        
        disableBusinessReturnMessage = '';
        disablePersonalReturnMessage = '';
        disablePayrollMessage = '';
        disableAdvisoryMessage = '';
        disableBookkeepingMessage = '';
        disableStateFilingMessage = '';
        disableStateFilingCorpMessage = '';
        disableBackBookkeepingMessage = '';
        disableForeignStateMessage = '';
        disableBackPayrollMessage = '';
        disableBackBusinessMessage = '';
        disableBackPersonalMessage = '';
        disableNonProfitBookkeepingMessage = '';
        
        hasPlatformAccess = false;
        
        environment = 'Standard';
        
        BundleOverride = 'no';

        opportunityID = ApexPages.currentPage().getParameters().get('O');
        accountID = ApexPages.currentPage().getParameters().get('A');
        
        excludeProductList = new Set<String>();
        disableProductList = new Set<String>();
        excludeOfferList = new Set<String>();
        
        overrideList = new List<priceOverrideWrapper>();
        
        adjustPriceList = new List<priceAdjustmentWrapper>();
        
        offerMasterList = new List<offerMasterWrapperClass>();
        offerProductList = new List<offerProductWrapperClass>();
        
        dynamicRules = new List<dynamicRuleClass>();
        
        activeSubList = new List<Active_Subscriptions__c>();
        
        List<String> masterProductIDList = new List<String>();
        
        //String UserSalesSkill;
        //Boolean SellClientBooks;
        
        Boolean isBTPPrecheck = false;
        
        // quote id is passed only in cases where we are editing an existing quote
        quoteID = ApexPages.currentPage().getParameters().get('Q');
        //accountNameInput = quoteID;
        Boolean isLocked = false;
        
        // get values to use for rules
        Boolean SellClientBooks = false;
        String UserSalesSkill = '';
        String UserRole = '';
        String UserAlias = '';

        List<User> myUserList = [Select Sell_Client_Books__c, Skills_Sales__c, UserRoleId, Alias From User Where Id = :UserInfo.getUserId()];
        for (User uItem : myUserList){
            
            SellClientBooks = uItem.Sell_Client_Books__c;
            UserSalesSkill = uItem.Skills_Sales__c;
            UserRole = uItem.UserRoleId;
            UserAlias = uItem.Alias;
            
        }
        
        if (UserSalesSkill == null) {
            UserSalesSkill = '';
        }
        
        // check to see if we need to lock the pricing calculator
        List<Opportunity> existO = [SELECT Id, StageName, OwnerId, Email_Campaign_ID__c FROM Opportunity WHERE Id = :opportunityID];
        
        for(Opportunity eoItem : existO){
        
            if (eoItem.StageName == 'Closed Won') {
                
                // lock the calculator
                isLocked = true;
                
            }
            
            if (eoItem.OwnerId != UserInfo.getUserId()) {
            
                if (UserSalesSkill.contains('Calculator Owner Override') == false && UserSalesSkill.contains('Calculator Override') == false) {
                            
                    isLocked = true;
                
                }

            }
            
            emailCampaignIDInput = eoItem.Email_Campaign_ID__c;
        
        }
        
        if (quoteID != '') {
        
            List<Quote> checkQuoteOA = [SELECT OpportunityId, AccountId FROM Quote WHERE Id = :quoteID];
            
            for(Quote qoaItem : checkQuoteOA){
            
                accountID = qoaItem.AccountId;
                opportunityID = qoaItem.OpportunityId;
            
            }
        
        } else {
            
            List<Quote> quoteList = [SELECT Id, Calc_Entity_Type__c FROM Quote WHERE OpportunityId = :opportunityID];
            for (Quote qItem : quoteList){
            
                isLocked = true;
            
            }
        
        }
        
        //Boolean SellClientBooks = [Select Sell_Client_Books__c From User Where Id = :UserInfo.getUserId()][0].Sell_Client_Books__c;
        //String UserSalesSkill = [Select Skills_Sales__c From User Where Id = :UserInfo.getUserId()][0].Skills_Sales__c;
        
        UserSkill = UserSalesSkill;
        
        // check for platform access
        List<Active_Subscriptions__c> activeSubList = [SELECT Id, Product__c, Subscription_Status__c FROM Active_Subscriptions__c WHERE Account__c = :accountID AND Product__c = '01tf1000003JjrwAAC'];
        for (Active_Subscriptions__c aSubItem : activeSubList) {
        
            if (aSubItem.Subscription_Status__c == 'Active') {
                
                hasPlatformAccess = true;
                
            }
        
        }
        
        //String LeadSource = '';
        String Campaign = '';
        
        List<Account> ruleAccList = [SELECT Lead_Type_New__c, Lead_Source__c, Campaign__c FROM Account WHERE Id = :accountID];
        for (Account raItem : ruleAccList){
            
            LeadTypeNew = raItem.Lead_Type_New__c;
            LeadSource = raItem.Lead_Source__c;
            Campaign = raItem.Campaign__c;
        
        }
        
        if (LeadTypeNew == null) {
            LeadTypeNew = '';
        }
        
        if (LeadSource == null) {
            LeadSource = '';
        }
        
        if (Campaign == null) {
            Campaign = '';
        }
        
        //String LeadTypeNew = [Select Lead_Type_New__c From Account Where Id = :accountID][0].Lead_Type_New__c;
        //String LeadSource = [Select Lead_Source__c From Account Where Id = :accountID][0].Lead_Source__c;
        
        //String LeadTypeNew = '';
        //String LeadSource = '';
        
        if (UserSalesSkill == null) {
            UserSalesSkill = '';
        }
        
        if (UserRole == null) {
            UserRole = '';
        }
        
        String DefaultProductID = '';
        
        Map<String, String> productMessages = new Map<String, String>();

        Boolean doThisRule = false;
        Boolean tempRuleCheck = false;
        
        // get products to exclude by user and account details
        List<Calculator_Rule__c> ruleList = [SELECT Action__c, Criteria_Field_1__c, Criteria_Field_2__c, Criteria_Object__c, Field_1_Operator__c, Field_1_Value__c, Field_2_Operator__c, Field_2_Value__c, Message__c, Product__c, Amount__c, Environment__c, Calculator_Offer__c, Price_Adjustment_Percent__c FROM Calculator_Rule__c WHERE (Criteria_Object__c = 'User' OR Criteria_Object__c = 'Account' OR Criteria_Object__c = 'Form') AND Active__c = true];
        for (Calculator_Rule__c ruleItem : ruleList){
            
            doThisRule = false;
            
            if (ruleItem.Criteria_Object__c == 'Form') {
                
                dynamicRuleClass tempDRC = new dynamicRuleClass();
                
                tempDRC.productId = ruleItem.Product__c;
                tempDRC.fieldName = ruleItem.Criteria_Field_1__c;
                tempDRC.fieldValue = ruleItem.Field_1_Value__c;
                tempDRC.fieldOperator = ruleItem.Field_1_Operator__c;
                tempDRC.action = ruleItem.Action__c;
                
                dynamicRules.add(tempDRC);
                
            }
            
            if (ruleItem.Criteria_Object__c == 'User') {
                
                if (ruleItem.Criteria_Field_1__c == 'Sell_Client_Books__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Equal Checkbox') {
                        
                        if (ruleItem.Field_1_Value__c == 'TRUE' || ruleItem.Field_1_Value__c == 'true') {
                        
                            if (SellClientBooks == true) {
                            
                                doThisRule = true;
                                
                            }
                            
                        } else {
                        
                            if (SellClientBooks == false) {
                            
                                doThisRule = true;
                                
                            }
                        
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_1__c == 'Skills_Sales__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Does Not Contain String') {
                        
                        // check to see if there is more than one value in the string
                        if (ruleItem.Field_1_Value__c.contains(',')) {
                        
                            doThisRule = true;
                        
                            List<String> resSkill = ruleItem.Field_1_Value__c.split(',', 0);
                            for (String resItem : resSkill){
                                
                                if (UserSalesSkill.contains(resItem)) {
                            
                                    doThisRule = false;
                                
                                }
                                
                            }
                        
                        } else {
                        
                            if (UserSalesSkill.contains(ruleItem.Field_1_Value__c)) {
                            
                                
                                
                            } else {
                            
                                doThisRule = true;
                            
                            }
                        
                        }
                        
                    }
                    
                    if (ruleItem.Field_1_Operator__c == 'Contains String') {
                    
                        if (ruleItem.Field_1_Value__c.contains(',')) {
                        
                            doThisRule = true;
                        
                            List<String> resSkill = ruleItem.Field_1_Value__c.split(',', 0);
                            for (String resItem : resSkill){
                                
                                if (UserSalesSkill.contains(resItem)) {
                            
                                    
                                
                                } else {
                                    
                                    doThisRule = false;
                                    
                                }
                                
                            }
                        
                        } else {
                        
                            if (UserSalesSkill.contains(ruleItem.Field_1_Value__c)) {
                            
                                doThisRule = true;
                                
                            } else {
                            
                                
                            
                            }
                        
                        }
                        
                    }
                    
                } else if (ruleItem.Criteria_Field_1__c == 'UserRoleId') {
                
                    if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                        if (UserRole == ruleItem.Field_1_Value__c) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                    
                } else if (ruleItem.Criteria_Field_1__c == 'Alias') {
                
                    if (ruleItem.Field_1_Value__c.contains(',')) {
                    
                        tempRuleCheck = true;
                    
                        List<String> resAlias = ruleItem.Field_1_Value__c.split(',', 0);
                        for (String resItem : resAlias){
                            
                            if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                                if (UserAlias == resItem) {
                                
                                    doThisRule = true;
                                    
                                }
                                
                            } else if (ruleItem.Field_1_Operator__c == 'Not Equal String') {
                        
                                if (UserAlias == resItem) {
                                    
                                    tempRuleCheck = false;
                                    
                                }
                                
                            }
                            
                        }
                        
                        if (ruleItem.Field_1_Operator__c == 'Not Equal String') {
                            
                            doThisRule = tempRuleCheck;
                            
                        }
                    
                    } else {
                    
                        if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                            if (UserAlias == ruleItem.Field_1_Value__c) {
                            
                                doThisRule = true;
                                
                            }
                            
                        } else if (ruleItem.Field_1_Operator__c == 'Not Equal String') {
                        
                            if (UserAlias != ruleItem.Field_1_Value__c) {
                            
                                doThisRule = true;
                                
                            }
                            
                        }
                    
                    }
                
                }
                
                if (ruleItem.Criteria_Field_2__c == 'Sell_Client_Books__c') {
                
                    if (ruleItem.Field_2_Operator__c == 'Equal Checkbox') {
                        
                        if (ruleItem.Field_2_Value__c == 'TRUE' || ruleItem.Field_2_Value__c == 'true') {
                        
                            if (SellClientBooks == false) {
                            
                                doThisRule = false;
                                
                            } 
                            
                        } else {
                        
                            if (SellClientBooks == true) {
                            
                                doThisRule = false;
                                
                            }
                        
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_2__c == 'Skills_Sales__c') {
                    
                    if (ruleItem.Field_2_Operator__c == 'Does Not Contain String') {
                    
                        // check to see if there is more than one value in the string
                        if (ruleItem.Field_2_Value__c.contains(',')) {
                        
                            List<String> resSkill = ruleItem.Field_2_Value__c.split(',', 0);
                            for (String resItem : resSkill){
                                
                                if (UserSalesSkill.contains(resItem)) {
                            
                                    doThisRule = false;
                                
                                }
                                
                            }
                        
                        } else {
                        
                            if (UserSalesSkill.contains(ruleItem.Field_2_Value__c)) {
                            
                                doThisRule = false;
                                
                            } else {
                            
                                
                            
                            }
                        
                        }
                        
                    }
                    
                    if (ruleItem.Field_2_Operator__c == 'Contains String') {
                    
                        if (ruleItem.Field_2_Value__c.contains(',')) {
                        
                            List<String> resSkill = ruleItem.Field_2_Value__c.split(',', 0);
                            for (String resItem : resSkill){
                                
                                if (UserSalesSkill.contains(resItem)) {
                            
                                    
                                
                                } else {
                                    
                                    doThisRule = false;
                                    
                                }
                                
                            }
                        
                        } else {
                        
                            if (UserSalesSkill.contains(ruleItem.Field_2_Value__c)) {
                            
                                
                                
                            } else {
                            
                                doThisRule = false;
                            
                            }
                        
                        }
                        
                    }
                    
                } else if (ruleItem.Criteria_Field_2__c == 'UserRoleId') {
                
                    if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                        if (UserRole == ruleItem.Field_2_Value__c) {
                        
                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                    
                } else if (ruleItem.Criteria_Field_2__c == 'Alias') { 
                
                    if (ruleItem.Field_2_Value__c.contains(',')) {
                    
                        tempRuleCheck = false;
                    
                        List<String> resAlias = ruleItem.Field_2_Value__c.split(',', 0);
                        for (String resItem : resAlias){
                            
                            if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                                if (UserAlias == resItem) {
                                
                                    tempRuleCheck = true;
                                    
                                } 
                                
                            } else if (ruleItem.Field_2_Operator__c == 'Not Equal String') {
                        
                                if (UserAlias == resItem) {
                                
                                    doThisRule = false;
                                
                                }
                                
                            }
                            
                        }
                        
                        if (ruleItem.Field_2_Operator__c == 'Equal String') {
                            
                            if (tempRuleCheck == false) {
                            
                                doThisRule = false;
                            
                            }
                            
                        }
                    
                    } else {
                    
                        if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                            if (UserAlias == ruleItem.Field_2_Value__c) {
                            
                                
                                
                            } else { 
                            
                                doThisRule = false;
                            
                            }
                            
                        } else if (ruleItem.Field_2_Operator__c == 'Not Equal String') {
                        
                            if (UserAlias == ruleItem.Field_2_Value__c) {
                            
                                doThisRule = false;
                            
                            }
                            
                        }
                    
                    }
                
                }
                
            }
            
            if (ruleItem.Criteria_Object__c == 'Account') {
                // Lead_Type_New__c
                // Lead_Source__c
                
                if (ruleItem.Criteria_Field_1__c == 'Lead_Type_New__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Contains String') {
                        
                        if (LeadTypeNew.contains(ruleItem.Field_1_Value__c)) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                    
                    if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                        if (LeadTypeNew == ruleItem.Field_1_Value__c) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_1__c == 'Lead_Source__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                        if (LeadSource == ruleItem.Field_1_Value__c) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_1__c == 'Campaign__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Contains String') {
                        
                        if (Campaign.contains(ruleItem.Field_1_Value__c)) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                
                    if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                        if (Campaign == ruleItem.Field_1_Value__c) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                
                }
                
                if (ruleItem.Criteria_Field_2__c == 'Lead_Type_New__c') {
                
                    if (ruleItem.Field_2_Operator__c == 'Contains String') {
                        
                        if (LeadTypeNew.contains(ruleItem.Field_2_Value__c)) {

                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                    
                    if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                        if (LeadTypeNew == ruleItem.Field_2_Value__c) {
                        
                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_2__c == 'Lead_Source__c') {
                
                    if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                        if (LeadSource == ruleItem.Field_2_Value__c) {
                        
                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                
                } else if (ruleItem.Criteria_Field_2__c == 'Campaign__c') {
                
                    if (ruleItem.Field_2_Operator__c == 'Contains String') {
                        
                        if (Campaign.contains(ruleItem.Field_2_Value__c)) {

                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                
                    if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                        if (Campaign == ruleItem.Field_2_Value__c) {
                        
                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                
                }
                
            }
            
            if (doThisRule == true) {
            
                if (ruleItem.Action__c == 'Environment Whitelist') {
                    environment = ruleItem.Environment__c;
                }
                
                if (ruleItem.Action__c == 'Remove Product' && UserSalesSkill.contains('Calculator Override') == false) {
                    
                    excludeProductList.add(ruleItem.Product__c);
                    
                }
                
                if (ruleItem.Action__c == 'Remove Offer' && UserSalesSkill.contains('Calculator Override') == false) {
                    
                    excludeOfferList.add(ruleItem.Calculator_Offer__c);
                    
                }
                
                if (ruleItem.Action__c == 'Default Product') {
                
                    DefaultProductID = ruleItem.Product__c;
                
                }
                
                if (ruleItem.Action__c == 'Disable Product' && UserSalesSkill.contains('Calculator Override') == false) {
                    
                    disableProductList.add(ruleItem.Product__c);
                    
                    // todo, add message
                    productMessages.put(ruleItem.Product__c,ruleItem.Message__c);
                    
                }
                
                if (ruleItem.Action__c == 'Flat Price Override') {
                    
                    priceOverrideWrapper orPrice = new priceOverrideWrapper();
                    
                    orPrice.productId = ruleItem.Product__c;
                    orPrice.amount = ruleItem.Amount__c;
                    
                    // query calculator location
                    List<Product2> locP = [SELECT Id, Calculator_Location__c FROM Product2 WHERE Id = :ruleItem.Product__c];
    
                    for(Product2 locItem : locP){
                        orPrice.productPostion = locItem.Calculator_Location__c;
                    }
                    
                    overrideList.add(orPrice);
                    
                }
                
                // logic for price adjustment rule
                if (ruleItem.Action__c == 'Price Adjustment') {
                    
                    priceAdjustmentWrapper adjPrice = new priceAdjustmentWrapper();
                    
                    adjPrice.productId = ruleItem.Product__c;
                    
                    // should default to 0 so we can always add amount in addition to percent
                    adjPrice.amount = ruleItem.Amount__c;
                    
                    if (adjPrice.amount == NULL) {
                        adjPrice.amount = 0;
                    }
                    
                    // need to convert this into a percentage value we can work with
                    if (ruleItem.Price_Adjustment_Percent__c == NULL) {
                    
                        adjPrice.percent = 1.0;
                    
                    } else {
                    
                        // normal positive value
                        adjPrice.percent = 1.0 + (ruleItem.Price_Adjustment_Percent__c / 100);
                    
                    }
                    
                    // query calculator location
                    List<Product2> locP = [SELECT Id, Calculator_Location__c FROM Product2 WHERE Id = :ruleItem.Product__c];
                
                    for(Product2 locItem : locP){
                        adjPrice.productPostion = locItem.Calculator_Location__c;
                    }
                    
                    adjustPriceList.add(adjPrice);
                    
                }

            }
            
        }
        
        // default class data
        entityTypeClass = '';
        foreignOwnersClass = '';
        industryTypeClass = '';
        livingAbroadClass = '';
        numberOfContractorsClass = '';
        numberOfEmployeesClass = '';
        numberOfK1sClass = '';
        numberOfOwnersClass = '';
        numberOfTransactionsClass = '';
        numberOfRentalPropertiesClass = '';
        personalIncomeClass = '';
        projectedFirstYearProfitClass = '';
        projectedFirstYearRevenueClass = '';
        stateOfIncorporationClass = '';
        totalInvestorFundingClass = '';
        totalStartupCostClass = '';
        websiteSellingGoodsClass = '';
        workedWithAccountantInPastClass = '';
        runPayrollBeforeClass = '';
        filingStatusClass = '';
        businessMilesClass = '';
        officeSqFtClass = '';
        foreignStateClass = '';
        yearsInBusinessClass = '';
        
        List<Calculator_Field__c> myFieldList = [SELECT Id, Name, Required_In_Environment__c FROM Calculator_Field__c];
        for(Calculator_Field__c fieldItem : myFieldList){
        
            if (fieldItem.Required_In_Environment__c  != null && fieldItem.Required_In_Environment__c.contains(environment)) {
            
                if (fieldItem.Name == 'Entity Type') {
                    entityTypeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Foreign Owners') {
                    foreignOwnersClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Industry Type') {
                    industryTypeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Living Abroad') {
                    livingAbroadClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Contractors') {
                    numberOfContractorsClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Employees') {
                    numberOfEmployeesClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of K1s') {
                    numberOfK1sClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Owners') {
                    numberOfOwnersClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Transactions') {
                    numberOfTransactionsClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Rental Properties') {
                    numberOfRentalPropertiesClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Personal Income') {
                    personalIncomeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Projected 1st Year Profit') {
                    projectedFirstYearProfitClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Projected 1st Year Revenue') {
                    projectedFirstYearRevenueClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'State of Incorporation') {
                    stateOfIncorporationClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Total Investor Funding') {
                    totalInvestorFundingClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Total Startup Cost') {
                    totalStartupCostClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Website Selling Goods') {
                    websiteSellingGoodsClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Worked With Accountant in Past') {
                    workedWithAccountantInPastClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Run Payroll Before') {
                    runPayrollBeforeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Filing Status') {
                    filingStatusClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Business Miles') {
                    businessMilesClass = ' jq_req1';
                }
                if (fieldItem.Name == 'Office Square Footage') {
                    officeSqFtClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Foreign State') {
                    foreignStateClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Years In Business') {
                    yearsInBusinessClass = ' jq_req1';
                }
            
            }
        
            //standardPriceBookID = pbItem.Id;
        } 
        
        // create master product list
        
        
        if (LeadTypeNew.contains('BTP')) {
            isBTPPrecheck = true;       
        }
        if (LeadTypeNew.contains('BTP')) {
            isBTPPrecheck = true;       
        }
        if (LeadTypeNew.contains('Sprout')) {
        //    showBundles = true;       
        }
        
        // get pricebook id
        String standardPriceBookID = '01sj0000000J4tSAAS';
        
        List<Pricebook2> pbList = [SELECT Id, Name, IsActive, IsStandard FROM Pricebook2 WHERE IsActive = true AND Environment__c includes (:environment)];
        
        for(Pricebook2 pbItem : pbList){
            standardPriceBookID = pbItem.Id;
        } 
        
        // no need to do the following if we are locking the calculator
        if (isLocked == false) {
        
            List<Product2> productList = [SELECT Id, Calculator_Location__c, Name, Bundles__c, AnnualMonthlyOption__c, RevenueInstallmentPeriod, Disable_QTY_on_Calc__c, Sort_Order__c, Setup_Fee__c, No_Split_Allowed__c FROM Product2 WHERE Environment__c includes (:environment) AND (Calculator_Location__c = 'Business Return' OR Calculator_Location__c = 'Personal Return' OR Calculator_Location__c = 'Payroll' OR Calculator_Location__c = 'Bookkeeping' OR Calculator_Location__c = 'Advisory' OR Calculator_Location__c = 'LLC State Filing' OR Calculator_Location__c = 'Corp State Filing' OR Calculator_Location__c = 'Back Bookkeeping' OR Calculator_Location__c = 'Foreign State' OR Calculator_Location__c = 'Back Quarterly Payroll' OR Calculator_Location__c = 'Back Business Return' OR Calculator_Location__c = 'Back Personal Return' OR Calculator_Location__c = 'Non-Profit Bookkeeping')];
            
            List<PricebookEntry> pbACList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id, Dynamic__c FROM PricebookEntry WHERE Pricebook2Id = :standardPriceBookID];
                
            for(PricebookEntry pbACItem : pbACList){
            
                for(Product2 pItem : productList){
                
                    if (pbACItem.Product2Id == pItem.Id && pbACItem.Dynamic__c == false) {

                        priceOverrideWrapper orPrice = new priceOverrideWrapper();
                    
                        orPrice.productId = pItem.Id;
                        orPrice.amount = pbACItem.UnitPrice;

                        orPrice.productPostion = pItem.Calculator_Location__c;

                        overrideList.add(orPrice);

                    }
                    
                }
            
            }
            
            // new offer data
            bundleItems = new List<SelectOption>();
            bundleItems.add(new SelectOption('None','None'));
            
            // initially default to no bundle
            bundle = 'None';
            
            List<Calculator_Offer__c> offerList = [SELECT Id, Name, Active__c, Environment__c, Default__c FROM Calculator_Offer__c WHERE Active__c = true AND Environment__c = :environment ORDER BY Sort__c];
        
            for(Calculator_Offer__c offerItem : offerList){
            
                // exclude offers based upon rules
                if (excludeOfferList.contains(offerItem.Id)) {
                
                } else {
                
                    // add offer details to data structure
                    offerMasterWrapperClass mcOffer = new offerMasterWrapperClass();
                    
                    mcOffer.id = offerItem.Id;
                    mcOffer.name = offerItem.Name;
                    mcOffer.doIt = false;
                    mcOffer.defaultSel = offerItem.Default__c;
                    
                    // set default if set on offer
                    if (offerItem.Default__c) {
                    
                        bundle = offerItem.Id;
                    
                    }
                    
                    offerMasterList.add(mcOffer);
                    
                    // query products for offer
                    List<Calculator_Offer_Product__c> offerProductQuery = [SELECT Id, Amount__c, Calculator_Offer__c, Name, Delay_Days__c, Master_Product__c, Product__c, Upsell_Product__c, Use_Pricebook__c FROM Calculator_Offer_Product__c WHERE Active__c = true AND Calculator_Offer__c = :offerItem.Id];
                    for(Calculator_Offer_Product__c offerProductItem : offerProductQuery){
                        
                        offerProductWrapperClass mcProduct = new offerProductWrapperClass();
                        
                        mcProduct.id = offerProductItem.id;
                        mcProduct.offerId = offerItem.Id;
                        mcProduct.productName = offerProductItem.Name;
                        mcProduct.productId = offerProductItem.Product__c;
                        mcProduct.amount = offerProductItem.Amount__c;
                        mcProduct.delayDays = offerProductItem.Delay_Days__c;
                        mcProduct.master = offerProductItem.Master_Product__c;
                        mcProduct.upsell = offerProductItem.Upsell_Product__c;
                        mcProduct.calcId = offerProductItem.Product__c+'check';
                        mcProduct.usePricebook = offerProductItem.Use_Pricebook__c;
                        
                        if (offerProductItem.Master_Product__c) {
                            masterProductIDList.add(offerProductItem.Product__c);
                        }
    
                        for(Product2 pItem : productList){
                
                            if (pItem.Id == offerProductItem.Product__c) {
                                
                                if (pItem.Calculator_Location__c == 'Business Return') {
    
                                    mcProduct.calcId = 'bcheck';
                                }
                                
                                if (pItem.Calculator_Location__c == 'Personal Return') {
                                
                                    mcProduct.calcId = 'pcheck';
                                    
                                }
                                
                                if (pItem.Calculator_Location__c == 'Payroll') {
                                
                                    mcProduct.calcId = 'paycheck';
                                }
                                
                                if (pItem.Calculator_Location__c == 'Advisory') {
        
                                    mcProduct.calcId = 'acheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Bookkeeping') {
        
                                    mcProduct.calcId = 'bkcheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'LLC State Filing') {
                                
                                    mcProduct.calcId = 'sfcheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Corp State Filing') {
        
                                    mcProduct.calcId = 'sfccheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Back Bookkeeping') {
        
                                    mcProduct.calcId = 'bbkcheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Foreign State') {
        
                                    mcProduct.calcId = 'fscheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Back Quarterly Payroll') {
        
                                    mcProduct.calcId = 'bpycheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Back Business Return') {
        
                                    mcProduct.calcId = 'bbcheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Back Personal Return') {
        
                                    mcProduct.calcId = 'bpcheck';
        
                                }
                                
                                if (pItem.Calculator_Location__c == 'Non-Profit Bookkeeping') {
        
                                    mcProduct.calcId = 'npbcheck';
        
                                }
                                
                            }
                            
                        }
    
                        offerProductList.add(mcProduct);
                        
                    }
                    
                    bundleItems.add(new SelectOption(offerItem.Id,offerItem.Name));
                    
                    showBundles = true;
                
                }
                
            } 
        
            // bundle values - will become dynamic 
            

            //bundleItems.add(new SelectOption('Sprout Opportunity','Sprout Opportunity'));
            //bundleItems.add(new SelectOption('Sprout Growth','Sprout Growth'));
            //bundleItems.add(new SelectOption('Sprout Advantage','Sprout Advantage'));
            
            
            
            
            // financing options
            billingItems = new List<SelectOption>();
            billingItems.add(new SelectOption('yrl', 'No Financing'));
            billingItems.add(new SelectOption('2pay', '2 Pay'));
            billingItems.add(new SelectOption('3pay', '3 Pay'));
            billingItems.add(new SelectOption('4pay', '4 Pay'));
            billingItems.add(new SelectOption('6pay', '6 Pay'));
            billingItems.add(new SelectOption('mon', 'Apply for Monthly Installments'));
            
            // billing frequency options
            timeItems = new List<SelectOption>();
            timeItems.add(new SelectOption('Yearly', 'Yearly'));
            timeItems.add(new SelectOption('Monthly', 'Monthly'));
            
            // dropdown values first
            entityType = new List<SelectOption>();
            foreignOwners = new List<SelectOption>();
            industryType = new List<SelectOption>();
            livingAbroad = new List<SelectOption>();
            numberOfContractors = new List<SelectOption>();
            numberOfEmployees = new List<SelectOption>();
            
            List<String> entType = new List<String>();
            List<String> forOwn = new List<String>();
            List<String> indType = new List<String>();
            List<String> livAbroad = new List<String>();
            List<String> numCont = new List<String>();
            List<String> numEmp = new List<String>();
            List<String> stateList = new List<String>();
            List<String> numTrans = new List<String>();
            List<String> yearsBusiness = new List<String>();
            
            List<String> numberOfK1sMatch = new List<String>();
            List<String> numberOfOwnersMatch = new List<String>();
            List<String> numberOfRentalPropertiesMatch = new List<String>();
            List<String> personalIncomeMatch = new List<String>();
            List<String> projectedFirstYearProfitMatch = new List<String>();
            List<String> projectedFirstYearRevenueMatch = new List<String>();
            List<String> totalInvestorFundingMatch = new List<String>();
            List<String> totalStartupCostMatch = new List<String>();
            List<String> websiteSellingGoodsMatch = new List<String>();
            List<String> workedWithAccountantInPastMatch = new List<String>();
            List<String> runPayrollBeforeMatch = new List<String>();
            List<String> filingStatusMatch = new List<String>();
            List<String> businessMilesMatch = new List<String>();
            List<String> foreignStateMatch = new List<String>();
            List<String> officeSqFtMatch = new List<String>();
            List<String> yearsInBusinessMatch = new List<String>();
            
            numberOfK1s = new List<SelectOption>();
            numberOfOwners = new List<SelectOption>();
            numberOfTransactions = new List<SelectOption>();
            numberOfRentalProperties = new List<SelectOption>();
            personalIncome = new List<SelectOption>();
            projectedFirstYearProfit = new List<SelectOption>();
            projectedFirstYearRevenue = new List<SelectOption>();
            stateOfIncorporation = new List<SelectOption>();
            totalInvestorFunding = new List<SelectOption>();
            totalStartupCost = new List<SelectOption>();
            websiteSellingGoods = new List<SelectOption>();
            workedWithAccountantInPast = new List<SelectOption>();
            billingStateItems = new List<SelectOption>();
            stateOfResidenceItems = new List<SelectOption>();
            billingCountryItems = new List<SelectOption>();
            runPayrollBefore = new List<SelectOption>();
            filingStatus = new List<SelectOption>();
            businessMiles = new List<SelectOption>();
            officeSqFt = new List<SelectOption>();
            foreignState = new List<SelectOption>();
            yearsInBusiness = new List<SelectOption>();
            
            // placeholder variables
            Decimal formatInput = 0;
            String formatOutput = '';
            String shortState = '';
            
            adjustList = new List<priceWrapper>();
            
            stateOfIncorporation.add(new SelectOption('','--'));
            industryType.add(new SelectOption('','--'));
            totalStartupCost.add(new SelectOption('','--'));
            projectedFirstYearRevenue.add(new SelectOption('','--'));
            filingStatus.add(new SelectOption('','--'));
            businessMiles.add(new SelectOption('','--'));
            officeSqFt.add(new SelectOption('','--'));
            foreignState.add(new SelectOption('','--'));
            yearsInBusiness.add(new SelectOption('','--'));
            
            // get dropdown values from custom object
            List<Calculator_Dropdown__c> dropList = [SELECT Id, Dropdown_Value__c, Form_Field__c, Price_Adjustment__c, Product__c, Setup_fee__c FROM Calculator_Dropdown__c ORDER BY Sort__c];
            
            // sort by field 
            for(Calculator_Dropdown__c dropItem : dropList){
            
                priceWrapper wrapPrice = new priceWrapper();
                
                
                wrapPrice.value = dropItem.Dropdown_Value__c;
                wrapPrice.product = dropItem.Product__c;
                wrapPrice.amount = dropItem.Price_Adjustment__c;
                wrapPrice.setupFee = dropItem.Setup_fee__c;
                
                // if product is listed as an override then set amount to 0
                for(priceOverrideWrapper powItem : overrideList){
                    
                    if (powItem.productPostion == dropItem.Product__c) {
                        wrapPrice.amount = 0;
                    }
                    
                }
            
                if (dropItem.Form_Field__c == 'Entity Type' && !entType.contains(dropItem.Dropdown_Value__c)) {
                    entType.add(dropItem.Dropdown_Value__c);
                    entityType.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'EntityType';
                } else if(dropItem.Form_Field__c == 'Entity Type') {
                    wrapPrice.field = 'EntityType';
                }
                
                if (dropItem.Form_Field__c == 'Foreign Owners' && !forOwn.contains(dropItem.Dropdown_Value__c)) {
                    forOwn.add(dropItem.Dropdown_Value__c);
                    foreignOwners.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'ForeignOwners';
                } else if(dropItem.Form_Field__c == 'Foreign Owners') {
                    wrapPrice.field = 'ForeignOwners';
                }
                
                if (dropItem.Form_Field__c == 'Industry Type' && !indType.contains(dropItem.Dropdown_Value__c)) {
                    indType.add(dropItem.Dropdown_Value__c);
                    industryType.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'IndustryType';
                } else if(dropItem.Form_Field__c == 'Industry Type') {
                    wrapPrice.field = 'IndustryType';
                }
                
                if (dropItem.Form_Field__c == 'Living Abroad' && !livAbroad.contains(dropItem.Dropdown_Value__c)) {
                    livAbroad.add(dropItem.Dropdown_Value__c);
                    livingAbroad.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'LivingAbroad';
                } else if(dropItem.Form_Field__c == 'Living Abroad') {
                    wrapPrice.field = 'LivingAbroad';
                }
                
                if (dropItem.Form_Field__c == 'Number of Contractors' && !numCont.contains(dropItem.Dropdown_Value__c)) {
                    numCont.add(dropItem.Dropdown_Value__c);
                    numberOfContractors.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfContractors';
                } else if(dropItem.Form_Field__c == 'Number of Contractors') {
                    wrapPrice.field = 'NumberOfContractors';
                }
                
                if (dropItem.Form_Field__c == 'Number of Employees' && !numEmp.contains(dropItem.Dropdown_Value__c)) {
                    numEmp.add(dropItem.Dropdown_Value__c);
                    numberOfEmployees.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfEmployees';
                } else if(dropItem.Form_Field__c == 'Number of Employees') {
                    wrapPrice.field = 'NumberOfEmployees';
                }
                
                if (dropItem.Form_Field__c == 'Number of K1s' && !numberOfK1sMatch.contains(dropItem.Dropdown_Value__c)) {
                    numberOfK1sMatch.add(dropItem.Dropdown_Value__c);
                    numberOfK1s.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfK1s';
                } else if(dropItem.Form_Field__c == 'Number of K1s') {
                    wrapPrice.field = 'NumberOfK1s';
                }
                
                if (dropItem.Form_Field__c == 'Number of Owners' && !numberOfOwnersMatch.contains(dropItem.Dropdown_Value__c)) {
                    numberOfOwnersMatch.add(dropItem.Dropdown_Value__c);
                    numberOfOwners.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfOwners';
                } else if(dropItem.Form_Field__c == 'Number of Owners') {
                    wrapPrice.field = 'NumberOfOwners';
                }
                
                if (dropItem.Form_Field__c == 'Number of Transactions' && !numTrans.contains(dropItem.Dropdown_Value__c)) {
                    numTrans.add(dropItem.Dropdown_Value__c);
                    numberOfTransactions.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfTransactions';
                } else if(dropItem.Form_Field__c == 'Number of Transactions') {
                    wrapPrice.field = 'NumberOfTransactions';
                }
                
                if (dropItem.Form_Field__c == 'Number of Rental Properties' && !numberOfRentalPropertiesMatch.contains(dropItem.Dropdown_Value__c)) {
                    numberOfRentalPropertiesMatch.add(dropItem.Dropdown_Value__c);
                    numberOfRentalProperties.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfRentalProperties';
                } else if(dropItem.Form_Field__c == 'Number of Rental Properties') {
                    wrapPrice.field = 'NumberOfRentalProperties';
                }
                
                if (dropItem.Form_Field__c == 'Personal Income' && !personalIncomeMatch.contains(dropItem.Dropdown_Value__c)) {
                
                    personalIncomeMatch.add(dropItem.Dropdown_Value__c);
                
                    formatInput = Decimal.valueof(dropItem.Dropdown_Value__c);
                    formatOutput = '$' + String.valueOf(formatInput.format());
                
                    personalIncome.add(new SelectOption(dropItem.Dropdown_Value__c,formatOutput));
                    wrapPrice.field = 'PersonalIncome';
                    
                } else if(dropItem.Form_Field__c == 'Personal Income') {
                    wrapPrice.field = 'PersonalIncome';
                }
                
                if (dropItem.Form_Field__c == 'Projected 1st Year Profit' && !projectedFirstYearProfitMatch.contains(dropItem.Dropdown_Value__c)) {
                
                    projectedFirstYearProfitMatch.add(dropItem.Dropdown_Value__c);
                
                    formatInput = Decimal.valueof(dropItem.Dropdown_Value__c);
                    formatOutput = '$' + String.valueOf(formatInput.format());
                
                    projectedFirstYearProfit.add(new SelectOption(dropItem.Dropdown_Value__c,formatOutput));
                    wrapPrice.field = 'ProjectedFirstYearProfit';
                } else if(dropItem.Form_Field__c == 'Projected 1st Year Profit') {
                    wrapPrice.field = 'ProjectedFirstYearProfit';
                }
                
                if (dropItem.Form_Field__c == 'Projected 1st Year Revenue' && !projectedFirstYearRevenueMatch.contains(dropItem.Dropdown_Value__c)) {
                
                    projectedFirstYearRevenueMatch.add(dropItem.Dropdown_Value__c);
                    
                    formatInput = Decimal.valueof(dropItem.Dropdown_Value__c);
                    formatOutput = '$' + String.valueOf(formatInput.format());
                
                    projectedFirstYearRevenue.add(new SelectOption(dropItem.Dropdown_Value__c,formatOutput));
                    wrapPrice.field = 'ProjectedFirstYearRevenue';
                } else if(dropItem.Form_Field__c == 'Projected 1st Year Revenue') {
                    wrapPrice.field = 'ProjectedFirstYearRevenue';
                }
                
                
                if (dropItem.Form_Field__c == 'State of Incorporation' && !stateList.contains(dropItem.Dropdown_Value__c)) {
                
                    stateList.add(dropItem.Dropdown_Value__c);
                
                    // using this one to also populate billingstate input items
                    shortState = changeStateToAbbrev(dropItem.Dropdown_Value__c);
                    billingStateItems.add(new SelectOption(shortState,dropItem.Dropdown_Value__c));
                    stateOfResidenceItems.add(new SelectOption(shortState,dropItem.Dropdown_Value__c));
                
                    stateOfIncorporation.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'StateOfIncorporation';
                } else if(dropItem.Form_Field__c == 'State of Incorporation') {
                    wrapPrice.field = 'StateOfIncorporation';
                }
                
                if (dropItem.Form_Field__c == 'Total Investor Funding' && !totalInvestorFundingMatch.contains(dropItem.Dropdown_Value__c)) {
                
                    totalInvestorFundingMatch.add(dropItem.Dropdown_Value__c);
                
                    formatInput = Decimal.valueof(dropItem.Dropdown_Value__c);
                    formatOutput = '$' + String.valueOf(formatInput.format());
                
                    totalInvestorFunding.add(new SelectOption(dropItem.Dropdown_Value__c,formatOutput));
                    wrapPrice.field = 'TotalInvestorFunding';
                } else if(dropItem.Form_Field__c == 'Total Investor Funding') {
                    wrapPrice.field = 'TotalInvestorFunding';
                }
                
                if (dropItem.Form_Field__c == 'Total Startup Cost' && !totalStartupCostMatch.contains(dropItem.Dropdown_Value__c)) {
                
                    totalStartupCostMatch.add(dropItem.Dropdown_Value__c);
                
                    formatInput = Decimal.valueof(dropItem.Dropdown_Value__c);
                    formatOutput = '$' + String.valueOf(formatInput.format());
                
                    totalStartupCost.add(new SelectOption(dropItem.Dropdown_Value__c,formatOutput));
                    wrapPrice.field = 'TotalStartupCost';
                    
                } else if(dropItem.Form_Field__c == 'Total Startup Cost') {
                    wrapPrice.field = 'TotalStartupCost';
                }
                
                if (dropItem.Form_Field__c == 'Website Selling Goods' && !websiteSellingGoodsMatch.contains(dropItem.Dropdown_Value__c)) {
                    websiteSellingGoodsMatch.add(dropItem.Dropdown_Value__c);
                    websiteSellingGoods.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'WebsiteSellingGoods';
                } else if(dropItem.Form_Field__c == 'Website Selling Goods') {
                    wrapPrice.field = 'WebsiteSellingGoods';
                }
                
                if (dropItem.Form_Field__c == 'Worked With Accountant in Past' && !workedWithAccountantInPastMatch.contains(dropItem.Dropdown_Value__c)) {
                    workedWithAccountantInPastMatch.add(dropItem.Dropdown_Value__c);
                    workedWithAccountantInPast.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'WorkedWithAccountantInPast';
                } else if(dropItem.Form_Field__c == 'Worked With Accountant in Past') {
                    wrapPrice.field = 'WorkedWithAccountantInPast';
                }
                
                if (dropItem.Form_Field__c == 'Run Payroll Before' && !runPayrollBeforeMatch.contains(dropItem.Dropdown_Value__c)) {
                    runPayrollBeforeMatch.add(dropItem.Dropdown_Value__c);
                    runPayrollBefore.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'RunPayrollBefore';
                } else if(dropItem.Form_Field__c == 'Run Payroll Before') {
                    wrapPrice.field = 'RunPayrollBefore';
                }
                
                if (dropItem.Form_Field__c == 'Filing Status' && !filingStatusMatch.contains(dropItem.Dropdown_Value__c)) {
                    filingStatusMatch.add(dropItem.Dropdown_Value__c);
                    filingStatus.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'FilingStatus';
                } else if(dropItem.Form_Field__c == 'Filing Status') {
                    wrapPrice.field = 'FilingStatus';
                }
                
                if (dropItem.Form_Field__c == 'Business Miles' && !businessMilesMatch.contains(dropItem.Dropdown_Value__c)) {
                    businessMilesMatch.add(dropItem.Dropdown_Value__c);
                    businessMiles.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'BusinessMiles';
                } else if(dropItem.Form_Field__c == 'Business Miles') {
                    wrapPrice.field = 'BusinessMiles';
                }
                
                if (dropItem.Form_Field__c == 'Foreign State' && !foreignStateMatch.contains(dropItem.Dropdown_Value__c)) {
                    foreignStateMatch.add(dropItem.Dropdown_Value__c);
                    foreignState.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'ForeignState';
                } else if(dropItem.Form_Field__c == 'Foreign State') {
                    wrapPrice.field = 'ForeignState';
                }
                
                if (dropItem.Form_Field__c == 'Office Square Footage' && !officeSqFtMatch.contains(dropItem.Dropdown_Value__c)) {
                    officeSqFtMatch.add(dropItem.Dropdown_Value__c);
                    officeSqFt.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'OfficeSqFt';
                } else if(dropItem.Form_Field__c == 'Office Square Footage') {
                    wrapPrice.field = 'OfficeSqFt';
                }
                
                if (dropItem.Form_Field__c == 'Years In Business' && !yearsInBusinessMatch.contains(dropItem.Dropdown_Value__c)) {
                    yearsInBusinessMatch.add(dropItem.Dropdown_Value__c);
                    yearsInBusiness.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'YearsInBusiness';
                } else if(dropItem.Form_Field__c == 'Years In Business') {
                    wrapPrice.field = 'YearsInBusiness';
                }
                
                adjustList.add(wrapPrice);
                
            }
            
            // add dc and default
            //billingStateItems.add(new SelectOption('DC','District of Columbia'));
            billingStateItems.add(new SelectOption('',''));
            stateOfResidenceItems.add(new SelectOption('',''));
            
            // populate country list
            billingCountryItems.add(new SelectOption('',''));
            billingCountryItems.add(new SelectOption('Afghanistan','Afghanistan'));
            billingCountryItems.add(new SelectOption('Albania','Albania'));
            billingCountryItems.add(new SelectOption('Algeria','Algeria'));
            billingCountryItems.add(new SelectOption('Andorra','Andorra'));
            billingCountryItems.add(new SelectOption('Angola','Angola'));
            billingCountryItems.add(new SelectOption('Anguilla','Anguilla'));
            billingCountryItems.add(new SelectOption('Antigua','Antigua'));
            billingCountryItems.add(new SelectOption('Argentina','Argentina'));
            billingCountryItems.add(new SelectOption('Armenia','Armenia'));
            billingCountryItems.add(new SelectOption('Aruba','Aruba'));
            billingCountryItems.add(new SelectOption('Ascension Island','Ascension Island'));
            billingCountryItems.add(new SelectOption('Australia','Australia'));
            billingCountryItems.add(new SelectOption('Austria','Austria'));
            billingCountryItems.add(new SelectOption('Azerbaijan','Azerbaijan'));
            billingCountryItems.add(new SelectOption('Bahamas','Bahamas'));
            billingCountryItems.add(new SelectOption('Bahrain','Bahrain'));
            billingCountryItems.add(new SelectOption('Bangladesh','Bangladesh'));
            billingCountryItems.add(new SelectOption('Barbados','Barbados'));
            billingCountryItems.add(new SelectOption('Barbuda','Barbuda'));
            billingCountryItems.add(new SelectOption('Belarus','Belarus'));
            billingCountryItems.add(new SelectOption('Belgium','Belgium'));
            billingCountryItems.add(new SelectOption('Belize','Belize'));
            billingCountryItems.add(new SelectOption('Benin','Benin'));
            billingCountryItems.add(new SelectOption('Bermuda','Bermuda'));
            billingCountryItems.add(new SelectOption('Bhutan','Bhutan'));
            billingCountryItems.add(new SelectOption('Bolivia','Bolivia'));
            billingCountryItems.add(new SelectOption('Bosnia and Herzegovina','Bosnia and Herzegovina'));
            billingCountryItems.add(new SelectOption('Botswana','Botswana'));
            billingCountryItems.add(new SelectOption('Brazil','Brazil'));
            billingCountryItems.add(new SelectOption('Brunei','Brunei'));
            billingCountryItems.add(new SelectOption('Bulgaria','Bulgaria'));
            billingCountryItems.add(new SelectOption('Burkina Faso','Burkina Faso'));
            billingCountryItems.add(new SelectOption('Burundi','Burundi'));
            billingCountryItems.add(new SelectOption('Cambodia','Cambodia'));
            billingCountryItems.add(new SelectOption('Cameroon','Cameroon'));
            billingCountryItems.add(new SelectOption('Canada','Canada'));
            billingCountryItems.add(new SelectOption('Canasa','Canasa'));
            billingCountryItems.add(new SelectOption('Cape Verde Islands','Cape Verde Islands'));
            billingCountryItems.add(new SelectOption('Cayman Islands','Cayman Islands'));
            billingCountryItems.add(new SelectOption('Central African Republic','Central African Republic'));
            billingCountryItems.add(new SelectOption('Chad','Chad'));
            billingCountryItems.add(new SelectOption('Chile','Chile'));
            billingCountryItems.add(new SelectOption('China','China'));
            billingCountryItems.add(new SelectOption('Christmas Island','Christmas Island'));
            billingCountryItems.add(new SelectOption('Cocos-Keeling Islands','Cocos-Keeling Islands'));
            billingCountryItems.add(new SelectOption('Colombia','Colombia'));
            billingCountryItems.add(new SelectOption('Comoros','Comoros'));
            billingCountryItems.add(new SelectOption('Congo','Congo'));
            billingCountryItems.add(new SelectOption('Cook Islands','Cook Islands'));
            billingCountryItems.add(new SelectOption('Costa Rica','Costa Rica'));
            billingCountryItems.add(new SelectOption('Croatia','Croatia'));
            billingCountryItems.add(new SelectOption('Cuba','Cuba'));
            billingCountryItems.add(new SelectOption('Cyprus','Cyprus'));
            billingCountryItems.add(new SelectOption('Czech Republic','Czech Republic'));
            billingCountryItems.add(new SelectOption('Denmark','Denmark'));
            billingCountryItems.add(new SelectOption('Diego Garcia','Diego Garcia'));
            billingCountryItems.add(new SelectOption('Djibouti','Djibouti'));
            billingCountryItems.add(new SelectOption('Dominica','Dominica'));
            billingCountryItems.add(new SelectOption('Dominican Republic','Dominican Republic'));
            billingCountryItems.add(new SelectOption('Ecuador','Ecuador'));
            billingCountryItems.add(new SelectOption('Egypt','Egypt'));
            billingCountryItems.add(new SelectOption('El Salvador','El Salvador'));
            billingCountryItems.add(new SelectOption('England','England'));
            billingCountryItems.add(new SelectOption('Equatorial Guinea','Equatorial Guinea'));
            billingCountryItems.add(new SelectOption('Eritrea','Eritrea'));
            billingCountryItems.add(new SelectOption('Estonia','Estonia'));
            billingCountryItems.add(new SelectOption('Ethiopia','Ethiopia'));
            billingCountryItems.add(new SelectOption('Faeroe Islands','Faeroe Islands'));
            billingCountryItems.add(new SelectOption('Falkland Islands','Falkland Islands'));
            billingCountryItems.add(new SelectOption('Fiji Islands','Fiji Islands'));
            billingCountryItems.add(new SelectOption('Finland','Finland'));
            billingCountryItems.add(new SelectOption('France','France'));
            billingCountryItems.add(new SelectOption('French Antilles','French Antilles'));
            billingCountryItems.add(new SelectOption('French Guiana','French Guiana'));
            billingCountryItems.add(new SelectOption('French Polynesia','French Polynesia'));
            billingCountryItems.add(new SelectOption('Gabon','Gabon'));
            billingCountryItems.add(new SelectOption('Gambia','Gambia'));
            billingCountryItems.add(new SelectOption('Georgia','Georgia'));
            billingCountryItems.add(new SelectOption('Germany','Germany'));
            billingCountryItems.add(new SelectOption('Ghana','Ghana'));
            billingCountryItems.add(new SelectOption('Gibraltar','Gibraltar'));
            billingCountryItems.add(new SelectOption('Ginea-Bissau','Ginea-Bissau'));
            billingCountryItems.add(new SelectOption('Greece','Greece'));
            billingCountryItems.add(new SelectOption('Greenland','Greenland'));
            billingCountryItems.add(new SelectOption('Grenada','Grenada'));
            billingCountryItems.add(new SelectOption('Guadeloupe','Guadeloupe'));
            billingCountryItems.add(new SelectOption('Guam','Guam'));
            billingCountryItems.add(new SelectOption('Guantanamo Bay','Guantanamo Bay'));
            billingCountryItems.add(new SelectOption('Guatemala','Guatemala'));
            billingCountryItems.add(new SelectOption('Guinea','Guinea'));
            billingCountryItems.add(new SelectOption('Guyana','Guyana'));
            billingCountryItems.add(new SelectOption('Haiti','Haiti'));
            billingCountryItems.add(new SelectOption('Hamilton','Hamilton'));
            billingCountryItems.add(new SelectOption('Honduras','Honduras'));
            billingCountryItems.add(new SelectOption('Hong Kong','Hong Kong'));
            billingCountryItems.add(new SelectOption('Hungary','Hungary'));
            billingCountryItems.add(new SelectOption('Iceland','Iceland'));
            billingCountryItems.add(new SelectOption('India','India'));
            billingCountryItems.add(new SelectOption('Indonesia ','Indonesia'));
            billingCountryItems.add(new SelectOption('Iran','Iran'));
            billingCountryItems.add(new SelectOption('Iraq','Iraq'));
            billingCountryItems.add(new SelectOption('Ireland','Ireland'));
            billingCountryItems.add(new SelectOption('Israel','Israel'));
            billingCountryItems.add(new SelectOption('Italy','Italy'));
            billingCountryItems.add(new SelectOption('Ivory Coast','Ivory Coast'));
            billingCountryItems.add(new SelectOption('Jamaica','Jamaica'));
            billingCountryItems.add(new SelectOption('Japan','Japan'));
            billingCountryItems.add(new SelectOption('Jordan','Jordan'));
            billingCountryItems.add(new SelectOption('Kazakhstan','Kazakhstan'));
            billingCountryItems.add(new SelectOption('Kenya','Kenya'));
            billingCountryItems.add(new SelectOption('Kiribati Republic','Kiribati Republic'));
            billingCountryItems.add(new SelectOption('Korea North','Korea North'));
            billingCountryItems.add(new SelectOption('Korea South','Korea South'));
            billingCountryItems.add(new SelectOption('Kuwait','Kuwait'));
            billingCountryItems.add(new SelectOption('Kyrgyzstan','Kyrgyzstan'));
            billingCountryItems.add(new SelectOption('Laos','Laos'));
            billingCountryItems.add(new SelectOption('Latvia','Latvia'));
            billingCountryItems.add(new SelectOption('Lebanon','Lebanon'));
            billingCountryItems.add(new SelectOption('Lesotho','Lesotho'));
            billingCountryItems.add(new SelectOption('Liberia','Liberia'));
            billingCountryItems.add(new SelectOption('Libya','Libya'));
            billingCountryItems.add(new SelectOption('Liechtenstein','Liechtenstein'));
            billingCountryItems.add(new SelectOption('Lithuania','Lithuania'));
            billingCountryItems.add(new SelectOption('Luxembourg','Luxembourg'));
            billingCountryItems.add(new SelectOption('Macao','Macao'));
            billingCountryItems.add(new SelectOption('Macedonia','Macedonia'));
            billingCountryItems.add(new SelectOption('Madagascar','Madagascar'));
            billingCountryItems.add(new SelectOption('Malawi','Malawi'));
            billingCountryItems.add(new SelectOption('Malaysia','Malaysia'));
            billingCountryItems.add(new SelectOption('Maldives','Maldives'));
            billingCountryItems.add(new SelectOption('Mali','Mali'));
            billingCountryItems.add(new SelectOption('Malta','Malta'));
            billingCountryItems.add(new SelectOption('Marshall Islands','Marshall Islands'));
            billingCountryItems.add(new SelectOption('Martinique','Martinique'));
            billingCountryItems.add(new SelectOption('Mauritania','Mauritania'));
            billingCountryItems.add(new SelectOption('Mauritius','Mauritius'));
            billingCountryItems.add(new SelectOption('Mayotte Island','Mayotte Island'));
            billingCountryItems.add(new SelectOption('Mexico','Mexico'));
            billingCountryItems.add(new SelectOption('Micronesia','Micronesia'));
            billingCountryItems.add(new SelectOption('Moldova','Moldova'));
            billingCountryItems.add(new SelectOption('Monaco','Monaco'));
            billingCountryItems.add(new SelectOption('Mongolia','Mongolia'));
            billingCountryItems.add(new SelectOption('Montserrat','Montserrat'));
            billingCountryItems.add(new SelectOption('Morocco','Morocco'));
            billingCountryItems.add(new SelectOption('Mozambique','Mozambique'));
            billingCountryItems.add(new SelectOption('Myanmar','Myanmar'));
            billingCountryItems.add(new SelectOption('Namibia','Namibia'));
            billingCountryItems.add(new SelectOption('Nauru','Nauru'));
            billingCountryItems.add(new SelectOption('Nepal','Nepal'));
            billingCountryItems.add(new SelectOption('Netherlands','Netherlands'));
            billingCountryItems.add(new SelectOption('Nevis','Nevis'));
            billingCountryItems.add(new SelectOption('New Caledonia','New Caledonia'));
            billingCountryItems.add(new SelectOption('New Zealand','New Zealand'));
            billingCountryItems.add(new SelectOption('Nicaragua','Nicaragua'));
            billingCountryItems.add(new SelectOption('Niger','Niger'));
            billingCountryItems.add(new SelectOption('Nigeria','Nigeria'));
            billingCountryItems.add(new SelectOption('Niue','Niue'));
            billingCountryItems.add(new SelectOption('Norfolk Island','Norfolk Island'));
            billingCountryItems.add(new SelectOption('Norway','Norway'));
            billingCountryItems.add(new SelectOption('Oman','Oman'));
            billingCountryItems.add(new SelectOption('Pakistan','Pakistan'));
            billingCountryItems.add(new SelectOption('Palau ','Palau'));
            billingCountryItems.add(new SelectOption('Panama','Panama'));
            billingCountryItems.add(new SelectOption('Papua New Guinea','Papua New Guinea'));
            billingCountryItems.add(new SelectOption('Paraguay','Paraguay'));
            billingCountryItems.add(new SelectOption('Peru','Peru'));
            billingCountryItems.add(new SelectOption('Philippines','Philippines'));
            billingCountryItems.add(new SelectOption('Poland','Poland'));
            billingCountryItems.add(new SelectOption('Portugal','Portugal'));
            billingCountryItems.add(new SelectOption('Principe','Principe'));
            billingCountryItems.add(new SelectOption('Puerto Rico','Puerto Rico'));
            billingCountryItems.add(new SelectOption('Qatar','Qatar'));
            billingCountryItems.add(new SelectOption('Reunion Island','Reunion Island'));
            billingCountryItems.add(new SelectOption('Romania','Romania'));
            billingCountryItems.add(new SelectOption('Rota Island','Rota Island'));
            billingCountryItems.add(new SelectOption('Russia','Russia'));
            billingCountryItems.add(new SelectOption('Rwanda','Rwanda'));
            billingCountryItems.add(new SelectOption('Saint Lucia','Saint Lucia'));
            billingCountryItems.add(new SelectOption('Saipan Islands','Saipan Islands'));
            billingCountryItems.add(new SelectOption('San Marino','San Marino'));
            billingCountryItems.add(new SelectOption('Sao Tome','Sao Tome'));
            billingCountryItems.add(new SelectOption('Saudi Arabia','Saudi Arabia'));
            billingCountryItems.add(new SelectOption('Senegal Republic','Senegal Republic'));
            billingCountryItems.add(new SelectOption('Serbia (Republic of)','Serbia (Republic of)'));
            billingCountryItems.add(new SelectOption('Seychelles','Seychelles'));
            billingCountryItems.add(new SelectOption('Sierra Leone','Sierra Leone'));
            billingCountryItems.add(new SelectOption('Singapore','Singapore'));
            billingCountryItems.add(new SelectOption('Slovak Republic','Slovak Republic'));
            billingCountryItems.add(new SelectOption('Slovenia','Slovenia'));
            billingCountryItems.add(new SelectOption('Solomon Islands','Solomon Islands'));
            billingCountryItems.add(new SelectOption('Somalia','Somalia'));
            billingCountryItems.add(new SelectOption('South Africa','South Africa'));
            billingCountryItems.add(new SelectOption('Spain','Spain'));
            billingCountryItems.add(new SelectOption('Sri Lanka','Sri Lanka'));
            billingCountryItems.add(new SelectOption('Sudan','Sudan'));
            billingCountryItems.add(new SelectOption('Suriname','Suriname'));
            billingCountryItems.add(new SelectOption('Swaziland','Swaziland'));
            billingCountryItems.add(new SelectOption('Sweden','Sweden'));
            billingCountryItems.add(new SelectOption('Switzerland','Switzerland'));
            billingCountryItems.add(new SelectOption('Syria','Syria'));
            billingCountryItems.add(new SelectOption('Taiwan','Taiwan'));
            billingCountryItems.add(new SelectOption('Tajikistan','Tajikistan'));
            billingCountryItems.add(new SelectOption('Tanzania','Tanzania'));
            billingCountryItems.add(new SelectOption('Thailand','Thailand'));
            billingCountryItems.add(new SelectOption('Togo','Togo'));
            billingCountryItems.add(new SelectOption('Tokelau','Tokelau'));
            billingCountryItems.add(new SelectOption('Tonga','Tonga'));
            billingCountryItems.add(new SelectOption('Trinidad and Tabago','Trinidad and Tabago'));
            billingCountryItems.add(new SelectOption('Tunisia','Tunisia'));
            billingCountryItems.add(new SelectOption('Turkey','Turkey'));
            billingCountryItems.add(new SelectOption('Uganda','Uganda'));
            billingCountryItems.add(new SelectOption('Ukraine','Ukraine'));
            billingCountryItems.add(new SelectOption('United Arab Emirates','United Arab Emirates'));
            billingCountryItems.add(new SelectOption('United Kingdom','United Kingdom'));
            billingCountryItems.add(new SelectOption('United States','United States'));
            billingCountryItems.add(new SelectOption('Uruguay','Uruguay'));
            billingCountryItems.add(new SelectOption('Uzbekistan','Uzbekistan'));
            billingCountryItems.add(new SelectOption('Vanuatu','Vanuatu'));
            billingCountryItems.add(new SelectOption('Vatican city','Vatican city'));
            billingCountryItems.add(new SelectOption('Venezuela','Venezuela'));
            billingCountryItems.add(new SelectOption('Vietnam','Vietnam'));
            billingCountryItems.add(new SelectOption('Virgin Islands','Virgin Islands'));
            billingCountryItems.add(new SelectOption('Western Somoa','Western Somoa'));
            billingCountryItems.add(new SelectOption('Yemen','Yemen'));
            billingCountryItems.add(new SelectOption('Yugoslavia','Yugoslavia'));
            billingCountryItems.add(new SelectOption('Zaire','Zaire'));
            billingCountryItems.add(new SelectOption('Zambia','Zambia'));
            billingCountryItems.add(new SelectOption('Zimbabwe','Zimbabwe'));
            
            // sort seperately by product
            
            // prepare data for view - sort
            //entityType.sort();
            //foreignOwners.sort();
            //industryType.sort();
            //livingAbroad.sort();
            //numberOfContractors.sort();
            //numberOfEmployees.sort();
            //numberOfK1s.sort();
            //numberOfOwners.sort();
            //numberOfRentalProperties.sort();
            //personalIncome.sort();
            //projectedFirstYearProfit.sort();
            //projectedFirstYearRevenue.sort();
            stateOfIncorporation.sort();
            foreignState.sort();
            billingStateItems.sort();
            stateOfResidenceItems.sort();
            billingCountryItems.sort();
            //totalInvestorFunding.sort();
            //totalStartupCost.sort();
            //websiteSellingGoods.sort();
            //workedWithAccountantInPast.sort();
            
            // set defaults
            websiteSellingGoodsInput = 'No';
            workedWithAccountantInPastInput = 'No';
            numberOfOwnersInput = '1';
            numberOfEmployeesInput = '1';
            livingAbroadInput = 'No';
            billingTime = 'yrl';
            runPayrollBeforeInput = 'No';
            
            // get defaults from account
            List <Account> accList = [SELECT Industry, Expected_1st_year_revenue__c, Website_Selling_Goods__c, Foreign_Income__c, Entity_Tax_Classification__c, State_of_Formation__c, Total_Startup_Costs__c, How_much_funding__c, Worked_With_CPA_Accountant__c, NumberOfEmployees, Number_of_owners__c, Trans_Per_Month__c, Personal_Income__c, Number_of_Contractors__c, Rental_Properties__c, Name, BillingState, BillingStreet, BillingCity, BillingPostalCode, BillingCountry, Personal_Return_Filing_Status__c, Current_Year_Profit_Projection__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c, Foreign_State__c, Years_in_Business__c, State_of_Residence__c FROM Account WHERE Id = :accountID];
            for (Account accItem : accList){
                
                // industry
                if (accItem.Industry != '' && accItem.Industry != null) {
                    SelectOption industryTest = new SelectOption(accItem.Industry,accItem.Industry);
                    if (industryType.contains(industryTest)) {
                        industryTypeInput = accItem.Industry;
                    }
                }
                
                // expected 1st year rev
                if (accItem.Expected_1st_year_revenue__c != '' && accItem.Expected_1st_year_revenue__c != null) {
                    
                    // use try catch in case non decimal value
                    try{

                        formatInput = Decimal.valueof(accItem.Expected_1st_year_revenue__c);
                        formatOutput = '$' + String.valueOf(formatInput.format());
                    
                        SelectOption efyrTest = new SelectOption(accItem.Expected_1st_year_revenue__c,formatOutput);
                        if (projectedFirstYearRevenue.contains(efyrTest)) {
                            projectedFirstYearRevenueInput = accItem.Expected_1st_year_revenue__c;
                        }

                    } catch(TypeException ex){

                    }

                }
                
                // first year profit
                if (accItem.Current_Year_Profit_Projection__c != '' && accItem.Current_Year_Profit_Projection__c != null) {
                    
                    // use try catch in case non decimal value
                    try{

                        formatInput = Decimal.valueof(accItem.Current_Year_Profit_Projection__c);
                        formatOutput = '$' + String.valueOf(formatInput.format());
                    
                        SelectOption efyrpTest = new SelectOption(accItem.Current_Year_Profit_Projection__c,formatOutput);
                        if (projectedFirstYearProfit.contains(efyrpTest)) {
                            projectedFirstYearProfitInput = accItem.Current_Year_Profit_Projection__c;
                        }

                    } catch(TypeException ex){

                    }

                }
                
                // entity tax classification
                if (accItem.Entity_Tax_Classification__c != '' && accItem.Entity_Tax_Classification__c != null) {
                    SelectOption etcTest = new SelectOption(accItem.Entity_Tax_Classification__c,accItem.Entity_Tax_Classification__c);
                    if (entityType.contains(etcTest)) {
                        entityTypeInput = accItem.Entity_Tax_Classification__c;
                    }
                }
                
                // state of formation
                if (accItem.State_of_Formation__c != '' && accItem.State_of_Formation__c != null) {
                    SelectOption sofTest = new SelectOption(accItem.State_of_Formation__c,accItem.State_of_Formation__c);
                    if (stateOfIncorporation.contains(sofTest)) {
                        stateOfIncorporationInput = accItem.State_of_Formation__c;
                    }
                }
                
                // total startup costs
                if (accItem.Total_Startup_Costs__c != '' && accItem.Total_Startup_Costs__c != null) {
                
                    // use try catch in case non decimal value
                    try{

                        formatInput = Decimal.valueof(accItem.Total_Startup_Costs__c);
                        formatOutput = '$' + String.valueOf(formatInput.format());
                    
                        SelectOption tscTest = new SelectOption(accItem.Total_Startup_Costs__c,formatOutput);
                        if (totalStartupCost.contains(tscTest)) {
                            totalStartupCostInput = accItem.Total_Startup_Costs__c;
                        }

                    } catch(TypeException ex){

                    }

                }
                
                // transactions per month
                if (accItem.Trans_Per_Month__c != '' && accItem.Trans_Per_Month__c != null) {
                    SelectOption tpmTest = new SelectOption(accItem.Trans_Per_Month__c,accItem.Trans_Per_Month__c);
                    if (numberOfTransactions.contains(tpmTest)) {
                        numberOfTransactionsInput = accItem.Trans_Per_Month__c;
                    }
                }
                
                // how much funding
                if (accItem.How_much_funding__c != '' && accItem.How_much_funding__c != null) {
                
                    // use try catch in case non decimal value
                    try{

                        formatInput = Decimal.valueof(accItem.How_much_funding__c);
                        formatOutput = '$' + String.valueOf(formatInput.format());
                    
                        SelectOption hmfTest = new SelectOption(accItem.How_much_funding__c,formatOutput);
                        if (totalInvestorFunding.contains(hmfTest)) {
                            totalInvestorFundingInput = accItem.How_much_funding__c;
                        }

                    } catch(TypeException ex){

                    }             
                    
                }
                
                // number of owners
                if (accItem.Number_of_owners__c != '' && accItem.Number_of_owners__c != null) {
                    SelectOption nooTest = new SelectOption(accItem.Number_of_owners__c,accItem.Number_of_owners__c);
                    if (numberOfOwners.contains(nooTest)) {
                        numberOfOwnersInput = accItem.Number_of_owners__c;
                    }
                }
               
                // personal income
                if (accItem.Personal_Income__c != '' && accItem.Personal_Income__c != null) {
                
                    // use try catch in case non decimal value
                    try{

                        formatInput = Decimal.valueof(accItem.Personal_Income__c);
                        formatOutput = '$' + String.valueOf(formatInput.format());
                    
                        SelectOption piTest = new SelectOption(accItem.Personal_Income__c,formatOutput);
                        if (personalIncome.contains(piTest)) {
                            personalIncomeInput = accItem.Personal_Income__c;
                        }

                    } catch(TypeException ex){

                    }

                }
                
                // NumberOfEmployees
                if (accItem.NumberOfEmployees != null) {
                    SelectOption noeTest = new SelectOption(String.valueOf(accItem.NumberOfEmployees),String.valueOf(accItem.NumberOfEmployees));
                    if (numberOfEmployees.contains(noeTest)) {
                        numberOfEmployeesInput = String.valueOf(accItem.NumberOfEmployees);
                    }
                }
                
                // Number_of_Contractors__c
                if (accItem.Number_of_Contractors__c != null) {
                    SelectOption nocTest = new SelectOption(String.valueOf(accItem.Number_of_Contractors__c),String.valueOf(accItem.Number_of_Contractors__c));
                    if (numberOfContractors.contains(nocTest)) {
                        numberOfContractorsInput = String.valueOf(accItem.Number_of_Contractors__c);
                    }
                }
                
                // Rental_Properties__c
                if (accItem.Rental_Properties__c != null) {
                    SelectOption nrpTest = new SelectOption(String.valueOf(accItem.Rental_Properties__c),String.valueOf(accItem.Rental_Properties__c));
                    if (numberOfRentalProperties.contains(nrpTest)) {
                        numberOfRentalPropertiesInput = String.valueOf(accItem.Rental_Properties__c);
                    }
                }
                
                // filing status
                if (accItem.Personal_Return_Filing_Status__c != null) {
                    SelectOption fsTest = new SelectOption(String.valueOf(accItem.Personal_Return_Filing_Status__c),String.valueOf(accItem.Personal_Return_Filing_Status__c));
                    if (filingStatus.contains(fsTest)) {
                        filingStatusInput = String.valueOf(accItem.Personal_Return_Filing_Status__c);
                    }
                }
                
                // business miles
                if (accItem.Estimated_Business_Mileage__c != null) {
                    SelectOption ebmTest = new SelectOption(String.valueOf(accItem.Estimated_Business_Mileage__c),String.valueOf(accItem.Estimated_Business_Mileage__c));
                    if (businessMiles.contains(ebmTest)) {
                        businessMilesInput = String.valueOf(accItem.Estimated_Business_Mileage__c);
                    }
                }
                
                // office sq foot
                if (accItem.Home_Office_Square_Feet__c != null) {
                    SelectOption hosfTest = new SelectOption(String.valueOf(accItem.Home_Office_Square_Feet__c),String.valueOf(accItem.Home_Office_Square_Feet__c));
                    if (officeSqFt.contains(hosfTest)) {
                        officeSqFtInput = String.valueOf(accItem.Home_Office_Square_Feet__c);
                    }
                }
         
                // foreign state
                if (accItem.Foreign_State__c != null) {
                    SelectOption fstTest = new SelectOption(String.valueOf(accItem.Foreign_State__c),String.valueOf(accItem.Foreign_State__c));
                    if (foreignState.contains(fstTest)) {
                        foreignStateInput = String.valueOf(accItem.Foreign_State__c);
                    }
                }
                
                // Years_in_Business__c
                if (accItem.Years_in_Business__c != null) {
                    SelectOption yibTest = new SelectOption(String.valueOf(accItem.Years_in_Business__c),String.valueOf(accItem.Years_in_Business__c));
                    if (yearsInBusiness.contains(yibTest)) {
                        yearsInBusinessInput = String.valueOf(accItem.Years_in_Business__c);
                    }
                }
                
                // Worked_With_CPA_Accountant__c
                if (accItem.Worked_With_CPA_Accountant__c == true) {
                    workedWithAccountantInPastInput = 'Yes';
                }
                
                // Website_Selling_Goods__c
                if (accItem.Website_Selling_Goods__c == true) {
                    websiteSellingGoodsInput = 'Yes';
                }
                
                // Foreign_Income__c
                if (accItem.Foreign_Income__c == true) {
                    livingAbroadInput = 'Yes';
                }
                
                accountNameInput = accItem.Name;
                billingStateInput = accItem.BillingState;
                stateOfResidenceInput = accItem.BillingState;
                
                billingCountryInput = accItem.BillingCountry;
                
                if (String.isBlank(billingCountryInput)) {
                    billingCountryInput = 'United States';
                }
                if (billingCountryInput == '') {
                    billingCountryInput = 'United States';
                }
                if (billingCountryInput == 'US') {
                    billingCountryInput = 'United States';
                }
                if (billingCountryInput == 'USA') {
                    billingCountryInput = 'United States';
                }
                if (billingCountryInput == 'United States of America') {
                    billingCountryInput = 'United States';
                }
                
                billingStreetInput = accItem.BillingStreet;
                billingCityInput = accItem.BillingCity;
                billingZipInput = accItem.BillingPostalCode;
    
            }
            
            if (quoteID != '') {
            
                // if we are editing a quote, pull default values from custom fields
                List<Quote> quoteList = [SELECT Id, Calc_Entity_Type__c, Calc_Foreign_Owners__c, Calc_Industry_Type__c, Calc_Living_Abroad__c, Calc_Number_of_Contractors__c, Calc_Number_of_Employees__c, Calc_Number_of_K1s__c, Calc_Number_of_Owners__c, Calc_Number_of_Rental_Properties__c, Calc_Number_of_Transactions__c, Calc_Personal_Income__c, Calc_Projected_1st_Year_Profit__c, Calc_Projected_1st_Year_Revenue__c, Calc_State_of_Incorporation__c, Calc_Total_Investor_Funding__c, Calc_Total_Startup_Cost__c, Calc_Website_Selling_Goods__c, Calc_Worked_with_Accountant__c, Calc_Run_Payroll_Before__c, OpportunityId, AccountId, billingSchedule__c, Bundle__c, Calc_Filing_Status__c, Calc_Business_Miles__c, Calc_Office_Square_Footage__c, Calc_Foreign_State__c, Calc_Years_in_Business__c, Calc_State_of_Residence__c FROM Quote WHERE Id = :quoteID];
                
                for(Quote quoteItem : quoteList){
                
                    opportunityID = quoteItem.OpportunityId;
                    accountID = quoteItem.AccountId;
                    entityTypeInput = quoteItem.Calc_Entity_Type__c;
                    foreignOwnersInput = quoteItem.Calc_Foreign_Owners__c;
                    industryTypeInput = quoteItem.Calc_Industry_Type__c;
                    livingAbroadInput = quoteItem.Calc_Living_Abroad__c;
                    numberOfContractorsInput = quoteItem.Calc_Number_of_Contractors__c;
                    numberOfEmployeesInput = quoteItem.Calc_Number_of_Employees__c;
                    numberOfK1sInput = quoteItem.Calc_Number_of_K1s__c;
                    numberOfOwnersInput = quoteItem.Calc_Number_of_Owners__c;
                    numberOfTransactionsInput = quoteItem.Calc_Number_of_Transactions__c;
                    numberOfRentalPropertiesInput = quoteItem.Calc_Number_of_Rental_Properties__c;
                    personalIncomeInput = quoteItem.Calc_Personal_Income__c;
                    projectedFirstYearProfitInput = quoteItem.Calc_Projected_1st_Year_Profit__c;
                    projectedFirstYearRevenueInput = quoteItem.Calc_Projected_1st_Year_Revenue__c;
                    stateOfIncorporationInput = quoteItem.Calc_State_of_Incorporation__c;
                    totalInvestorFundingInput = quoteItem.Calc_Total_Investor_Funding__c;
                    totalStartupCostInput = quoteItem.Calc_Total_Startup_Cost__c;
                    websiteSellingGoodsInput = quoteItem.Calc_Website_Selling_Goods__c;
                    workedWithAccountantInPastInput = quoteItem.Calc_Worked_with_Accountant__c;
                    runPayrollBeforeInput = quoteItem.Calc_Run_Payroll_Before__c;
                    filingStatusInput = quoteItem.Calc_Filing_Status__c;
                    businessMilesInput = quoteItem.Calc_Business_Miles__c;
                    officeSqFtInput = quoteItem.Calc_Office_Square_Footage__c;
                    foreignStateInput = quoteItem.Calc_Foreign_State__c;
                    yearsInBusinessInput = quoteItem.Calc_Years_in_Business__c;
                    stateOfResidenceInput = quoteItem.Calc_State_of_Residence__c;
                    
                    // get billing schedule
                    
                    bundle = quoteItem.Bundle__c;
                    
                
                    if (quoteItem.billingSchedule__c == 'mon') {
                        billingTime = 'mon';
                    }
                
                    if (quoteItem.billingSchedule__c == 'qtr') {
                        billingTime = 'qtr';
                    }
                    
                }
                
                // get quantity and checked data
            
            }
            
            
            
            bundleProductList = new List<bundleWrapperClass>();
            
            acList = new List<myWrapperClass>();
            
            acListProducts = new List<Product2>();
            
            // get a la carte product list
            acListP = [SELECT Id, Name, Bundles__c, Disable_QTY_on_Calc__c, RevenueInstallmentPeriod, Billing_Frequency__c, AnnualMonthlyOption__c, Description, HTML_Description__c, Sort_Order__c, Setup_Fee__c, No_Split_Allowed__c FROM Product2 WHERE Calculator_Location__c = 'A La Carte' AND Environment__c includes (:environment) ORDER BY Name];
            
            for(Product2 acItem : acListP){
            
                // exclude products based upon rules
                if (excludeProductList.contains(acItem.Id)) {
                
                } else {
                
                    acListProducts.add(acItem);
                
                }
            
            }
            
            //List<PricebookEntry> pbACList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id FROM PricebookEntry WHERE Pricebook2Id = :standardPriceBookID];
                
            for(Product2 acItem : acListProducts){
                
                for(PricebookEntry pbACItem : pbACList){
                    
                    if (pbACItem.Product2Id == acItem.Id) {
                        
                        // check to see if billing schedule is monthly, and if so multiply amount x 12 to set annual $
            
                        myWrapperClass wrapRec = new myWrapperClass();
                        
                        wrapRec.id = acItem.Id;
                        wrapRec.name = acItem.Name;
                        wrapRec.price = pbACItem.UnitPrice;
                        wrapRec.doIt = false;
                        wrapRec.pbeid = pbACItem.Id;
                        wrapRec.quantity = 1;
                        wrapRec.disableQTY = acItem.Disable_QTY_on_Calc__c;
                        wrapRec.billingTime = acItem.RevenueInstallmentPeriod;
                        wrapRec.billingTimeDef = acItem.RevenueInstallmentPeriod;
                        wrapRec.billingFreq = acItem.Billing_Frequency__c;
                        wrapRec.annualMonthlyOption = acItem.AnnualMonthlyOption__c;
                        wrapRec.setupFee = acItem.Setup_Fee__c;
                        wrapRec.noSplit = acItem.No_Split_Allowed__c;
                        
                        // check for price override
                        for(priceOverrideWrapper powItem : overrideList){
                    
                            if (powItem.productPostion == 'A La Carte' && powItem.productId == acItem.Id) {
                            
                                wrapRec.price = powItem.amount;
                                
                            }
                            
                        }
                        
                        // check for price adjustment
                        for(priceAdjustmentWrapper padjItem : adjustPriceList){
                        
                            if (padjItem.productPostion == 'A La Carte' && padjItem.productId == acItem.Id) {
                            
                                // first increment price based on amount which defaults to zero so no negative effect when not used
                                wrapRec.price = wrapRec.price + padjItem.amount;
                                
                                // then increment price based on percent which defaults to 1 so not negative effect when not used
                                wrapRec.price = wrapRec.price * padjItem.percent;
                                
                            }
                            
                        }
                        
                        // sort
                        if (acItem.Sort_Order__c == NULL) {
                            wrapRec.quoteSort = 4;
                        } else {
                            wrapRec.quoteSort = acItem.Sort_Order__c;
                        }
                        
                        wrapRec.htmlDescription = acItem.HTML_Description__c;
                        wrapRec.productDescription = acItem.Description;
                        
                        // do we have a default rule for this product?
                        if (DefaultProductID != '') {
                            if (acItem.Id == DefaultProductID) {
                                wrapRec.doIt = true;
                            }
                        }
                        
                        if (masterProductIDList.contains(acItem.Id)) {
                            wrapRec.masterOffer = true;
                        } else {
                            if (acItem.Id == '01tf1000004sVDeAAM') {
                                wrapRec.masterOffer = true;
                            } else {
                                wrapRec.masterOffer = false;
                            }
                        }
                        
                        // is this product disabled?
                        if (disableProductList.contains(acItem.Id)) {
                            
                            wrapRec.disableProduct = true;
                            
                            wrapRec.disableMessage = productMessages.get(acItem.Id);
                            
                            wrapRec.doIt = false;
                            
                        } else {
                        
                            wrapRec.disableProduct = false;
                            
                        }
                        
                        
                        // check for selection 
                        
                        //List<OpportunityLineItem> oliList = [SELECT Id, OpportunityId, Product2Id, Quantity, UnitPrice FROM OpportunityLineItem WHERE Product2Id = :acItem.Id AND OpportunityId = :opportunityID];
                        
                        //for(OpportunityLineItem oliItem : oliList){
                            
                        //    wrapRec.quantity = integer.valueOf(oliItem.Quantity);
                        //    wrapRec.doIt = true;
                            
                        //}
                        
                        acList.add(wrapRec);
                        
                        bundleWrapperClass bundleRec = new bundleWrapperClass();
                        
                        bundleRec.id = acItem.Id;
                        bundleRec.calcid = acItem.Id + 'check';
                        bundleRec.bundlelist = acItem.Bundles__c;
                        
                        bundleProductList.add(bundleRec);
                        
                        //acList.add('<div class="form-group"><label style="margin-right:5px;">'+acItem.Name+': $' + String.valueOf(pbACItem.UnitPrice.format())+'</label><input type="checkbox" name="alc'+acItem.Id+' /></div>');
                        
                    }
                    
                }

            }
            
            bizTaxPrepID = '';
            personalTaxPrepID = '';
            payrollID = '';
            taxAdvisoryID = '';
            bookkeepingID = '';
            stateFilingID = '';
            stateFilingCorpID = '';
            backBookkeepingID = '';
            foreignStateID = '';
            backPayrollID = '';
            backBusinessID = '';
            backPersonalID = '';
            nonProfitBookkeepingID = '';
            
            bizTaxPrepNoSplit = false;
            personalTaxPrepNoSplit = false;
            payrollNoSplit = false;
            taxAdvisoryNoSplit = false;
            bookkeepingNoSplit = false;
            stateFilingNoSplit = false;
            stateFilingCorpNoSplit = false;
            backBookkeepingNoSplit = false;
            foreignStateNoSplit = false;
            backPayrollNoSplit = false;
            backBusinessNoSplit = false;
            backPersonalNoSplit = false;
            nonProfitBookkeepingNoSplit = false;
            
            // check for existing products and mark them as selected
            for(Product2 pItem : productList){
            
                if (pItem.Calculator_Location__c == 'Business Return') {
                
                    bizTaxPrepID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBusinessReturn = pItem.AnnualMonthlyOption__c;
                    
                    businessTime = pItem.RevenueInstallmentPeriod;
                    businessTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        businessSort = 4;
                    } else {
                        businessSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBusinessReturn = true;
                        
                    } 
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBusinessReturn = true;
                        
                        disableBusinessReturnMessage = productMessages.get(pItem.Id);
                        
                    } 
                    
                    disableQTYBusinessReturn = pItem.Disable_QTY_on_Calc__c;
                    
                    bizTaxPrepNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Personal Return') {
                
                    personalTaxPrepID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'pcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionPersonalReturn = pItem.AnnualMonthlyOption__c;
                    
                    personalTime = pItem.RevenueInstallmentPeriod;
                    personalTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        personalSort = 4;
                    } else {
                        personalSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludePersonalReturn = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disablePersonalReturn = true;
                        
                        disablePersonalReturnMessage = productMessages.get(pItem.Id);
                        
                    } 
                    
                    disableQTYPersonalReturn = pItem.Disable_QTY_on_Calc__c;
                    
                    personalTaxPrepNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Payroll') {
                
                    payrollID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'paycheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionPayroll = pItem.AnnualMonthlyOption__c;
                    
                    payrollTime = pItem.RevenueInstallmentPeriod;
                    payrollTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        payrollSort = 4;
                    } else {
                        payrollSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludePayroll = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disablePayroll = true;
                        
                        disablePayrollMessage = productMessages.get(pItem.Id);
                        
                    } 
                    
                    disableQTYPayroll = pItem.Disable_QTY_on_Calc__c;
                    
                    payrollNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Advisory') {
                
                    taxAdvisoryID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'acheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionAdvisory = pItem.AnnualMonthlyOption__c;
                    
                    taxAdvisoryTime = pItem.RevenueInstallmentPeriod;
                    taxAdvisoryTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        taxAdvisorySort = 4;
                    } else {
                        taxAdvisorySort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeAdvisory = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableAdvisory = true;
                        
                        disableAdvisoryMessage = productMessages.get(pItem.Id);
                        
                    } 
                    
                    disableQTYAdvisory = pItem.Disable_QTY_on_Calc__c;
                    
                    taxAdvisoryNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Bookkeeping') {
                
                    bookkeepingID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bkcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBookkeeping = pItem.AnnualMonthlyOption__c;
                    
                    bookkeepingTime = pItem.RevenueInstallmentPeriod;
                    bookkeepingTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        bookkeepingSort = 4;
                    } else {
                        bookkeepingSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBookkeeping = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBookkeeping = true;
                        
                        disableBookkeepingMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYBookkeeping = pItem.Disable_QTY_on_Calc__c;
                    
                    bookkeepingNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'LLC State Filing') {
                
                    stateFilingID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'sfcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionStateFiling = pItem.AnnualMonthlyOption__c;
                    
                    stateFilingTime = pItem.RevenueInstallmentPeriod;
                    stateFilingTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        stateFilingSort = 4;
                    } else {
                        stateFilingSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeStateFiling = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableStateFiling = true;
                        
                        disableStateFilingMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYStateFiling = pItem.Disable_QTY_on_Calc__c;
                    
                    stateFilingSetupFee = pItem.Setup_Fee__c;
                    
                    stateFilingNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Corp State Filing') {
                
                    stateFilingCorpID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'sfccheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionStateFilingCorp = pItem.AnnualMonthlyOption__c;
                    
                    stateFilingCorpTime = pItem.RevenueInstallmentPeriod;
                    stateFilingCorpTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        stateFilingCorpSort = 4;
                    } else {
                        stateFilingCorpSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeStateFilingCorp = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableStateFilingCorp = true;
                        
                        disableStateFilingCorpMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYStateFilingCorp = pItem.Disable_QTY_on_Calc__c;
                    
                    stateFilingCorpSetupFee = pItem.Setup_Fee__c;
                    
                    stateFilingCorpNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Back Bookkeeping') {
                
                    backBookkeepingID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bbkcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBackBookkeeping = pItem.AnnualMonthlyOption__c;
                    
                    backBookkeepingTime = pItem.RevenueInstallmentPeriod;
                    backBookkeepingTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        backBookkeepingSort = 4;
                    } else {
                        backBookkeepingSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBackBookkeeping = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBackBookkeeping = true;
                        
                        disableBackBookkeepingMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYBackBookkeeping = pItem.Disable_QTY_on_Calc__c;
                    
                    backBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Foreign State') {
                
                    foreignStateID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'fscheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionForeignState = pItem.AnnualMonthlyOption__c;
                    
                    foreignStateTime = pItem.RevenueInstallmentPeriod;
                    foreignStateTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        foreignStateSort = 4;
                    } else {
                        foreignStateSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeForeignState = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableForeignState = true;
                        
                        disableForeignStateMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYForeignState = pItem.Disable_QTY_on_Calc__c;
                    
                    foreignStateNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Back Quarterly Payroll') {
                
                    backPayrollID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bpycheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBackPayroll = pItem.AnnualMonthlyOption__c;
                    
                    backPayrollTime = pItem.RevenueInstallmentPeriod;
                    backPayrollTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        backPayrollSort = 4;
                    } else {
                        backPayrollSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBackPayroll = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBackPayroll = true;
                        
                        disableBackPayrollMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYBackPayroll = pItem.Disable_QTY_on_Calc__c;
                    
                    backPayrollNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Back Business Return') {
                
                    backBusinessID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bbcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBackBusiness = pItem.AnnualMonthlyOption__c;
                    
                    backBusinessTime = pItem.RevenueInstallmentPeriod;
                    backBusinessTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        backBusinessSort = 4;
                    } else {
                        backBusinessSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBackBusiness = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBackBusiness = true;
                        
                        disableBackBusinessMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYBackBusiness = pItem.Disable_QTY_on_Calc__c;
                    
                    backBusinessNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Back Personal Return') {
                
                    backPersonalID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'bpcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionBackPersonal = pItem.AnnualMonthlyOption__c;
                    
                    backPersonalTime = pItem.RevenueInstallmentPeriod;
                    backPersonalTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        backPersonalSort = 4;
                    } else {
                        backPersonalSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeBackPersonal = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableBackPersonal = true;
                        
                        disableBackPersonalMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYBackPersonal = pItem.Disable_QTY_on_Calc__c;
                    
                    backPersonalNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
                if (pItem.Calculator_Location__c == 'Non-Profit Bookkeeping') {
                
                    nonProfitBookkeepingID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'npbcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionNonProfitBookkeeping = pItem.AnnualMonthlyOption__c;
                    
                    nonProfitBookkeepingTime = pItem.RevenueInstallmentPeriod;
                    nonProfitBookkeepingTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        nonProfitBookkeepingSort = 4;
                    } else {
                        nonProfitBookkeepingSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeNonProfitBookkeeping = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableNonProfitBookkeeping = true;
                        
                        disableNonProfitBookkeepingMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYNonProfitBookkeeping = pItem.Disable_QTY_on_Calc__c;
                    
                    nonProfitBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                    
                }
                
            }
            
            //totalAdjustment = 0;
            
            Boolean prevSel = false;
            
            List<OpportunityLineItem> existOLI = [SELECT Id, Product2Id, Quantity FROM OpportunityLineItem WHERE OpportunityId = :opportunityID];
            
            for(OpportunityLineItem eItem : existOLI){
    
                if (bizTaxPrepID != '' && eItem.Product2Id == bizTaxPrepID) {
                    doBusinessReturn = true;
                    businessQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (personalTaxPrepID != '' && eItem.Product2Id == personalTaxPrepID) {
                    doPersonalReturn = true;
                    personalQuantity = integer.valueOf(eItem.Quantity);
                    //totalAdjustment = totalAdjustment + personalAdjustment;
                    
                    prevSel = true;
                }
                
                if (payrollID != '' && eItem.Product2Id == payrollID) {
                    doPayroll = true;
                    payrollQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (taxAdvisoryID != '' && eItem.Product2Id == taxAdvisoryID) {
                    doAdvisory = true;
                    taxAdvisoryQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (bookkeepingID != '' && eItem.Product2Id == bookkeepingID) {
                    doBookkeeping = true;
                    bookkeepingQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (stateFilingID != '' && eItem.Product2Id == stateFilingID) {
                    doStateFiling = true;
                    stateFilingQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (stateFilingCorpID != '' && eItem.Product2Id == stateFilingCorpID) {
                    doStateFilingCorp = true;
                    stateFilingCorpQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (backBookkeepingID != '' && eItem.Product2Id == backBookkeepingID) {
                    doBackBookkeeping = true;
                    backBookkeepingQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (foreignStateID != '' && eItem.Product2Id == foreignStateID) {
                    doForeignState = true;
                    foreignStateQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (backPayrollID != '' && eItem.Product2Id == backPayrollID) {
                    doBackPayroll = true;
                    backPayrollQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (backBusinessID != '' && eItem.Product2Id == backBusinessID) {
                    doBackBusiness = true;
                    backBusinessQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (backPersonalID != '' && eItem.Product2Id == backPersonalID) {
                    doBackPersonal = true;
                    backPersonalQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                if (nonProfitBookkeepingID != '' && eItem.Product2Id == nonProfitBookkeepingID) {
                    doNonProfitBookkeeping = true;
                    nonProfitBookkeepingQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                
                for(myWrapperClass acItem : acList){
                
                    if (eItem.Product2Id == acItem.id) {
                        acItem.doIt = true;
                        acItem.quantity = integer.valueOf(eItem.Quantity);
                        
                        prevSel = true;
                    }
                
                }
                
            }
            
            // if we aren't prepopulating from a previous attempt, then set default selections
            if (prevSel == false) {
            
                if (isBTPPrecheck) {
                
                    doPersonalReturn = true;
                    doAdvisory = true;
                    
                    for(myWrapperClass acItem : acList){
                        
                        // 1800accountant access
                        if ('01tf1000003JjrwAAC' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        if ('01tf1000003JjrgAAC' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        if ('01tf1000003JjrfAAC' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        if ('01tf1000003JjrhAAC' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        if ('01tj0000000LLamAAG' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                    
                    }
                
                } else {
                
                    if (entityTypeInput == 'Non-Profit') {
                        doBusinessReturn = false;
                    } else {
                        doBusinessReturn = true;
                    }
                    
                    if (entityTypeInput == 'S Corporation') {
                        doPayroll = true;
                    }
                    
                    doPersonalReturn = true;
                    doAdvisory = true;
                    
                    for(myWrapperClass acItem : acList){
                        
                        // 1800accountant access
                        if ('01tf1000003JjrwAAC' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        // loan agreement
                        if ('01tj0000000LLamAAG' == acItem.id) {
                            acItem.doIt = true;
                            acItem.quantity = 1;
                        }
                        
                        if (entityTypeInput == 'Non-Profit') {
                            // non profit
                            if ('01tf1000003JjruAAC' == acItem.id) {
                                acItem.doIt = true;
                                acItem.quantity = 1;
                            }
                        }
                        
                        if (websiteSellingGoodsInput == 'Yes') {
                            if ('01tf1000003JjrrAAC' == acItem.id) {
                                acItem.doIt = true;
                                acItem.quantity = 1;
                            }
                        }
                    
                    }
                }

            }
            
            if (excludeBusinessReturn == true || bizTaxPrepID == '') {
            
                doBusinessReturn = false;
                excludeBusinessReturn = true;
                
            }
            
            if (excludePersonalReturn == true || personalTaxPrepID == '') {
            
                doPersonalReturn = false;
                excludePersonalReturn = true;
                
            }
            
            if (excludePayroll == true || payrollID == '') {
            
                doPayroll = false;
                excludePayroll = true;
                
            }
            
            if (excludeAdvisory == true || taxAdvisoryID == '') {
            
                doAdvisory = false;
                excludeAdvisory = true;
                
            }
            
            if (excludeBookkeeping == true || bookkeepingID == '') {
            
                doBookkeeping = false;
                excludeBookkeeping = true;
                
            }
            
            if (excludeStateFiling == true || stateFilingID == '') {
            
                doStateFiling = false;
                excludeStateFiling = true;
                
            }
            
            if (excludeStateFilingCorp == true || stateFilingCorpID == '') {
            
                doStateFilingCorp = false;
                excludeStateFilingCorp = true;
                
            }
            
            if (excludeBackBookkeeping == true || backBookkeepingID == '') {
            
                doBackBookkeeping = false;
                excludeBackBookkeeping = true;
                
            }
            
            if (excludeForeignState == true || foreignStateID == '') {
            
                doForeignState = false;
                excludeForeignState = true;
                
            }
            
            if (excludeBackPayroll == true || backPayrollID == '') {
            
                doBackPayroll = false;
                excludeBackPayroll = true;
                
            }
            
            if (excludeBackBusiness == true || backBusinessID == '') {
            
                doBackBusiness = false;
                excludeBackBusiness = true;
                
            }
            
            if (excludeBackPersonal == true || backPersonalID == '') {
            
                doBackPersonal = false;
                excludeBackPersonal = true;
                
            }
            
            if (excludeNonProfitBookkeeping == true || nonProfitBookkeepingID == '') {
            
                doNonProfitBookkeeping = false;
                excludeNonProfitBookkeeping = true;
                
            }
            
            if (disableBusinessReturn == true) {
            
                doBusinessReturn = false;
                
            }
            
            if (disablePersonalReturn == true) {
            
                doPersonalReturn = false;
                
            }
            
            if (disablePayroll == true) {
            
                doPayroll = false;
                
            }
            
            if (disableAdvisory == true) {
            
                doAdvisory = false;
                
            }
            
            if (disableBookkeeping == true) {
            
                doBookkeeping = false;
                
            }
            
            if (disableStateFiling == true) {
            
                doStateFiling = false;
                
            }
            
            if (disableStateFilingCorp == true) {
            
                doStateFilingCorp = false;
                
            }
            
            if (disableBackBookkeeping == true) {
            
                doBackBookkeeping = false;
                
            }
            
            if (disableForeignState == true) {
            
                doForeignState = false;
                
            }
            
            if (disableBackPayroll == true) {
            
                doBackPayroll = false;
                
            }
            
            if (disableBackBusiness == true) {
            
                doBackBusiness = false;
                
            }
            
            if (disableBackPersonal == true) {
            
                doBackPersonal = false;
                
            }
            
            if (disableNonProfitBookkeeping == true) {
            
                doNonProfitBookkeeping = false;
                
            }
            
            for(myWrapperClass acItem : acList){
                
                if (acItem.disableProduct) {
                
                    acItem.doIt = false;
                    
                }
            
            }
    
        }
    
    }
    
    public PageReference doForm(){
    
        // we need to see if this user can edit an opp owned by another user
        String UserSalesSkill = '';
        
        List<User> myUserList = [Select Sell_Client_Books__c, Skills_Sales__c, UserRoleId From User Where Id = :UserInfo.getUserId()];
        for (User uItem : myUserList){
            
            UserSalesSkill = uItem.Skills_Sales__c;
            
        }
        
        if (UserSalesSkill == null) {
            UserSalesSkill = '';
        }

        // check to see if we need to lock the pricing calculator
        List<Opportunity> existO = [SELECT Id, StageName, OwnerId FROM Opportunity WHERE Id = :opportunityID];
        
        for(Opportunity eoItem : existO){
        
            if (eoItem.StageName == 'Closed Won') {
                
                // lock the calculator
                return Page.Pricing_Calc_Locked;
                
            }
            
            if (eoItem.OwnerId != UserInfo.getUserId()) {
            
                if (UserSalesSkill.contains('Calculator Owner Override') == false && UserSalesSkill.contains('Calculator Override') == false) {
                            
                    return Page.Pricing_Calc_Owner_Lock;
                
                }

            }
            
        }
        
        // does a quote exist with no quote passed
        if (quoteID != '') {
        
        } else {
            
            List<Quote> quoteList = [SELECT Id, Calc_Entity_Type__c FROM Quote WHERE OpportunityId = :opportunityID];
            for (Quote qItem : quoteList){
            
                // lock the calculator
                return Page.Pricing_Calc_Invalid;
            
            }
        
        }
        
        // do the standard flow
        return Page.Pricing_Calc_Form;
        
    }
    
    public PageReference showLocked(){
    
        return Page.Pricing_Calc_Locked;
    
    }
    
    public PageReference showApproved(){
        
        
        return Page.Pricing_Calc_Approved;
        
    }
    
    public PageReference doPay(){
    
        Boolean prevTokenFound = false;
    
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        String theURL = uset.Chargeover_URL__c;
    
        redirURL = theURL;
        
        redirURL = redirURL + '/r/salesforce/wait/quote.custom_1/';

        if (cOQuoteID != '') {
            
            if (prevTokenFound == true) {
            
                redirURL = redirURL + ',';
                
            }
            
            List<ChargeOver_Quote__c> coQList = [SELECT Id, ChargeOver_View_URL__c, ChargeOver_URL_Token__c FROM ChargeOver_Quote__c WHERE Id = :cOQuoteID];
            for(ChargeOver_Quote__c coQItem : coQList){
 
                redirURL = redirURL + coQItem.ChargeOver_URL_Token__c;
                prevTokenFound = true;
                
            }
            
            
        }
        
        if (cOQuoteIDOneTime != '') {
            
            if (prevTokenFound == true) {
            
                redirURL = redirURL + ',';
                
            }
            
            List<ChargeOver_Quote__c> coQList = [SELECT Id, ChargeOver_View_URL__c, ChargeOver_URL_Token__c FROM ChargeOver_Quote__c WHERE Id = :cOQuoteIDOneTime];
            for(ChargeOver_Quote__c coQItem : coQList){
 
                redirURL = redirURL + coQItem.ChargeOver_URL_Token__c;
                prevTokenFound = true;
                
            }
            
            
        }
        
        if (cOQuoteIDMonth != '') {
            
            if (prevTokenFound == true) {
            
                redirURL = redirURL + ',';
                
            }
            
            List<ChargeOver_Quote__c> coQList = [SELECT Id, ChargeOver_View_URL__c, ChargeOver_URL_Token__c FROM ChargeOver_Quote__c WHERE Id = :cOQuoteIDMonth];
            for(ChargeOver_Quote__c coQItem : coQList){
 
                redirURL = redirURL + coQItem.ChargeOver_URL_Token__c;
                prevTokenFound = true;
                
            }
            
            
        }
        
        String updURL = redirURL + '?utm_source=client';
        
        redirURL = redirURL + '?utm_source=Sales&utm_term=Sales&utm_medium=Pricing+Calculator';
        
        sleep(2000);
        
        // update quote with URL
        update new Quote(
            Id = quoteID,
            Payment_URL__c = updURL
        );
        
        update new Opportunity(
            Id = opportunityID,
            StageName = 'Quote Generated'
        );

        // redirect to URL
        return Page.Pricing_Calc_Display_Redir;
        
    }
    
    public PageReference doPayEmail(){
               
        update new Opportunity(
            Id = opportunityID,
            StageName = 'Quote Sent'
        );
            
        String contactID = '';
        
        // get contact email address
        List<Account> accountList = [SELECT Id, Primary_Contact_ID__c FROM Account WHERE Id = :accountID];
        for(Account accountItem : accountList){
            contactID = accountItem.Primary_Contact_ID__c;
        }
        
        String contactEmail = '';
        List<Contact> contactList = [SELECT Id, Email FROM Contact WHERE Id = :contactID];
        for(Contact contactItem : contactList) {
            contactEmail = contactItem.Email;
        }

        // redirect to URL
        return Page.Pricing_Calc_Final;
        
    }
    
    public PageReference doSubmit(){
        
        // get calculated price for each applicable product , should already be loaded in variables below
        // businessAdjustment
        // personalAdjustment
        // taxAdvisoryPrice
        // payrollAdjustment
        
        // initialize package name
        String packageName = '';
        
        if (bundle != '' && bundle != 'None') {
 
            List<Calculator_Offer__c> offerListPN = [SELECT Id, Name, Active__c, Environment__c, Default__c FROM Calculator_Offer__c WHERE Active__c = true AND Id = :bundle ORDER BY Sort__c];
        
            for(Calculator_Offer__c offerItem : offerListPN){
            
                if (offerItem.Id == bundle) {
                
                    packageName = offerItem.Name;
                
                }
            
            }
            
        }
        
        // initialize all price placeholder variables
        businessAdjustment = 0.00;
        personalAdjustment = 0.00;
        payrollAdjustment = 0.00;
        taxAdvisoryPrice = 0.00;
        bookkeepingAdjustment = 0.00;
        stateFilingAdjustment = 0.00;
        stateFilingCorpAdjustment = 0.00;
        backBookkeepingAdjustment = 0.00;
        foreignStateAdjustment = 0.00;
        backPayrollAdjustment = 0.00;
        backBusinessAdjustment = 0.00;
        backPersonalAdjustment = 0.00;
        nonProfitBookkeepingAdjustment = 0.00;
        
        // check overrides
        for(priceOverrideWrapper powItem : overrideList){
            
            if (powItem.productPostion == 'Business Return') {
                businessAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Personal Return') {
                personalAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Advisory') {
                taxAdvisoryPrice = powItem.amount;
            }
            
            if (powItem.productPostion == 'Payroll') {
                payrollAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Bookkeeping') {
                bookkeepingAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'LLC State Filing') {
                stateFilingAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Corp State Filing') {
                stateFilingCorpAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Back Bookkeeping') {
                backBookkeepingAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Foreign State') {
                foreignStateAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Back Quarterly Payroll') {
                backPayrollAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Back Business Return') {
                backBusinessAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Back Personal Return') {
                backPersonalAdjustment = powItem.amount;
            }
            
            if (powItem.productPostion == 'Non-Profit Bookkeeping') {
                nonProfitBookkeepingAdjustment = powItem.amount;
            }
            
        }
        
        businessFee = 0.00;
        personalFee = 0.00;
        payrollFee = 0.00;
        taxAdvisoryFee = 0.00;
        bookkeepingFee = 0.00;
        stateFilingFee = 0.00;
        stateFilingCorpFee = 0.00;
        backBookkeepingFee = 0.00;
        foreignStateFee = 0.00;
        backPayrollFee = 0.00;
        backBusinessFee = 0.00;
        backPersonalFee = 0.00;
        nonProfitBookkeepingFee = 0.00;
        
        Decimal financeAmount = 0.00;
        Decimal subAmount = 0.00;
        Decimal totalFAmount = 0.00;
        Decimal subTotalAmount = 0.00;
        Decimal vipAmount = 0.00;
        
        Decimal tmpACPrice = 0.00;
        Decimal tmpACPrice2 = 0.00;
        
        Boolean itemSoldInOffer = false;
        Datetime holdDate;
        String holdDateString = '';
        
        String contactID = '';
        
        
        // initialize variables for chargeover quote identifiers
        cOQuoteID = '';
        cOQuoteIDMonth = '';
        cOQuoteIDOneTime = '';
        
        String tempValue = '';
        
        if (businessAdjustment > 0) {
        
        } else {
        
            businessAdjustment = getDynamicAmount('Business Return', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (personalAdjustment > 0) {
        
        } else {
        
            personalAdjustment = getDynamicAmount('Personal Return', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (payrollAdjustment > 0) {
        
        } else {
        
            payrollAdjustment = getDynamicAmount('Payroll', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (bookkeepingAdjustment > 0) {
        
        } else {
        
            bookkeepingAdjustment = getDynamicAmount('Bookkeeping', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (stateFilingAdjustment > 0) {
        
        } else {
        
            stateFilingAdjustment = getDynamicAmount('LLC State Filing', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (stateFilingCorpAdjustment > 0) {
        
        } else {
        
            stateFilingCorpAdjustment = getDynamicAmount('Corp State Filing', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (backBookkeepingAdjustment > 0) {
        
        } else {
        
            backBookkeepingAdjustment = getDynamicAmount('Back Bookkeeping', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (foreignStateAdjustment > 0) {
        
        } else {
        
            foreignStateAdjustment = getDynamicAmount('Foreign State', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (backPayrollAdjustment > 0) {
        
        } else {
        
            backPayrollAdjustment = getDynamicAmount('Back Quarterly Payroll', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (backBusinessAdjustment > 0) {
        
        } else {
        
            backBusinessAdjustment = getDynamicAmount('Back Business Return', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (backPersonalAdjustment > 0) {
        
        } else {
        
            backPersonalAdjustment = getDynamicAmount('Back Personal Return', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }
        
        if (nonProfitBookkeepingAdjustment > 0) {
        
        } else {
        
            nonProfitBookkeepingAdjustment = getDynamicAmount('Non-Profit Bookkeeping', entityTypeInput, foreignOwnersInput, industryTypeInput, livingAbroadInput, numberOfContractorsInput, numberOfEmployeesInput, numberOfK1sInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalInvestorFundingInput, totalStartupCostInput, websiteSellingGoodsInput, workedWithAccountantInPastInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput, yearsInBusinessInput);

        }

        // todo - mark checkboxes where product was added if we are editing a quote
            
        
        // now tax advisory calculation
        if (taxAdvisoryPrice > 0) {
        
        } else {
            taxAdvisoryPrice = ((businessAdjustment + personalAdjustment) / (869 + 390)) * 1199;   
        }  
        
        // make adjustments to dynamic products here
        for(priceAdjustmentWrapper padjItem : adjustPriceList){
        
            switch on padjItem.productPostion {
                when 'Business Return' {
                
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    businessAdjustment = businessAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    businessAdjustment = businessAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    businessAdjustment = businessAdjustment.setScale(2);
                    
                }
                when 'Personal Return' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    personalAdjustment = personalAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    personalAdjustment = personalAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    personalAdjustment = personalAdjustment.setScale(2);
                    
                }
                when 'Payroll' {
                
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    payrollAdjustment = payrollAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    payrollAdjustment = payrollAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    payrollAdjustment = payrollAdjustment.setScale(2);
                    
                }
                when 'Advisory' {
                
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    taxAdvisoryPrice = taxAdvisoryPrice + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    taxAdvisoryPrice = taxAdvisoryPrice * padjItem.percent;
                    
                    // precision on this field gets set later
                    
                }
                when 'Bookkeeping' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    bookkeepingAdjustment = bookkeepingAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    bookkeepingAdjustment = bookkeepingAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    bookkeepingAdjustment = bookkeepingAdjustment.setScale(2);
                    
                }
                when 'LLC State Filing' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    stateFilingAdjustment = stateFilingAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    stateFilingAdjustment = stateFilingAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    stateFilingAdjustment = stateFilingAdjustment.setScale(2);
                    
                }
                when 'Corp State Filing' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    stateFilingCorpAdjustment = stateFilingCorpAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    stateFilingCorpAdjustment = stateFilingCorpAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    stateFilingCorpAdjustment = stateFilingCorpAdjustment.setScale(2);
                    
                }
                when 'Back Bookkeeping' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    backBookkeepingAdjustment = backBookkeepingAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    backBookkeepingAdjustment = backBookkeepingAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    backBookkeepingAdjustment = backBookkeepingAdjustment.setScale(2);
                    
                }
                when 'Foreign State' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    foreignStateAdjustment = foreignStateAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    foreignStateAdjustment = foreignStateAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    foreignStateAdjustment = foreignStateAdjustment.setScale(2);
                    
                }
                when 'Back Quarterly Payroll' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    backPayrollAdjustment = backPayrollAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    backPayrollAdjustment = backPayrollAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    backPayrollAdjustment = backPayrollAdjustment.setScale(2);
                    
                }
                when 'Back Business Return' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    backBusinessAdjustment = backBusinessAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    backBusinessAdjustment = backBusinessAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    backBusinessAdjustment = backBusinessAdjustment.setScale(2);
                    
                }
                when 'Back Personal Return' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    backPersonalAdjustment = backPersonalAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    backPersonalAdjustment = backPersonalAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    backPersonalAdjustment = backPersonalAdjustment.setScale(2);
                    
                }
                when 'Non-Profit Bookkeeping' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    nonProfitBookkeepingAdjustment = nonProfitBookkeepingAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    nonProfitBookkeepingAdjustment = nonProfitBookkeepingAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    nonProfitBookkeepingAdjustment = nonProfitBookkeepingAdjustment.setScale(2);
                    
                }
            }
            
        }
        
        taxAdvisoryPrice = taxAdvisoryPrice.setScale(2);
        
        totalBPPPAd = businessAdjustment + personalAdjustment + taxAdvisoryPrice;
        
        // get standard pricebook id
        String standardPriceBookID = '01sj0000000J4tSAAS';
        
        List<Pricebook2> pbList = [SELECT Id, Name, IsActive, IsStandard FROM Pricebook2 WHERE IsActive = true AND Environment__c includes (:environment)];
        
        for(Pricebook2 pbItem : pbList){
            standardPriceBookID = pbItem.Id;
        }
        
        bizTaxPrepID = '';
        personalTaxPrepID = '';
        payrollID = '';
        taxAdvisoryID = '';
        bookkeepingID = '';
        stateFilingID = '';
        stateFilingCorpID = '';
        backBookkeepingID = '';
        foreignStateID = '';
        backPayrollID = '';
        backBusinessID = '';
        backPersonalID = '';
        nonProfitBookkeepingID = '';
        
        Boolean bizTaxPrepOT = false;
        Boolean personalTaxPrepOT = false;
        Boolean payrollOT = false;
        Boolean taxAdvisoryOT = false;
        Boolean bookkeepingOT = false;
        Boolean stateFilingOT = false;
        Boolean stateFilingCorpOT = false;
        Boolean backBookkeepingOT = false;
        Boolean foreignStateOT = false;
        Boolean backPayrollOT = false;
        Boolean backBusinessOT = false;
        Boolean backPersonalOT = false;
        Boolean nonProfitBookkeepingOT = false;
        
        bizTaxPrepNoSplit = false;
        personalTaxPrepNoSplit = false;
        payrollNoSplit = false;
        taxAdvisoryNoSplit = false;
        bookkeepingNoSplit = false;
        stateFilingNoSplit = false;
        stateFilingCorpNoSplit = false;
        backBookkeepingNoSplit = false;
        foreignStateNoSplit = false;
        backPayrollNoSplit = false;
        backBusinessNoSplit = false;
        backPersonalNoSplit = false;
        nonProfitBookkeepingNoSplit = false;
        
        String bizTaxPrepDesc = '';
        String bizTaxPrepHTMLDesc = '';
        String personalTaxPrepDesc = '';
        String personalTaxPrepHTMLDesc = '';
        String payrollDesc = '';
        String payrollHTMLDesc = '';
        String taxAdvisoryDesc = '';
        String taxAdvisoryHTMLDesc = '';
        String bookkeepingDesc = '';
        String bookkeepingHTMLDesc = '';
        String stateFilingDesc = '';
        String stateFilingHTMLDesc = '';
        String stateFilingCorpDesc = '';
        String stateFilingCorpHTMLDesc = '';
        String backBookkeepingDesc = '';
        String backBookkeepingHTMLDesc = '';
        String foreignStateDesc = '';
        String foreignStateHTMLDesc = '';
        
        String backPayrollDesc = '';
        String backPayrollHTMLDesc = '';
        String backBusinessDesc = '';
        String backBusinessHTMLDesc = '';
        String backPersonalDesc = '';
        String backPersonalHTMLDesc = '';
        String nonProfitBookkeepingDesc = '';
        String nonProfitBookkeepingHTMLDesc = '';
        
        // check for existing products and mark them as selected
        List<Product2> productList = [SELECT Id, Calculator_Location__c, Name, AnnualMonthlyOption__c, Billing_Frequency__c, HTML_Description__c, Description, No_Split_Allowed__c FROM Product2 WHERE Calculator_Location__c = 'Business Return' OR Calculator_Location__c = 'Personal Return' OR Calculator_Location__c = 'Payroll' OR Calculator_Location__c = 'Bookkeeping' OR Calculator_Location__c = 'Advisory' OR Calculator_Location__c = 'LLC State Filing' OR Calculator_Location__c = 'Corp State Filing' OR Calculator_Location__c = 'Back Bookkeeping' OR Calculator_Location__c = 'Foreign State' OR Calculator_Location__c = 'Back Quarterly Payroll' OR Calculator_Location__c = 'Back Business Return' OR Calculator_Location__c = 'Back Personal Return' OR Calculator_Location__c = 'Non-Profit Bookkeeping'];
        
        for(Product2 pItem : productList){
        
            if (pItem.Calculator_Location__c == 'Business Return') {
            
                bizTaxPrepID = pItem.Id;
                bizTaxPrepDesc = pItem.Description;
                bizTaxPrepHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    bizTaxPrepOT = true;
                    
                } 
                
                bizTaxPrepNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Personal Return') {
            
                personalTaxPrepID = pItem.Id;
                personalTaxPrepDesc = pItem.Description;
                personalTaxPrepHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    personalTaxPrepOT = true;
                    
                } 
                
                personalTaxPrepNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Payroll') {
            
                payrollID = pItem.Id;
                payrollDesc = pItem.Description;
                payrollHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                payrollDesc = payrollDesc + ' For ' + numberOfEmployeesInput + ' employees.'; 
                payrollHTMLDesc = payrollHTMLDesc + ' For ' + numberOfEmployeesInput + ' employees.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    payrollOT = true;
                    
                }
                
                payrollNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Advisory') {
            
                taxAdvisoryID = pItem.Id;
                taxAdvisoryDesc = pItem.Description;
                taxAdvisoryHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    taxAdvisoryOT = true;
                    
                }
                
                taxAdvisoryNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Bookkeeping') {
            
                bookkeepingID = pItem.Id;
                bookkeepingDesc = pItem.Description;
                bookkeepingHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                bookkeepingDesc = bookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions.'; 
                bookkeepingHTMLDesc = bookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    bookkeepingOT = true;
                    
                }
                
                bookkeepingNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'LLC State Filing') {
            
                stateFilingID = pItem.Id;
                stateFilingDesc = pItem.Description;
                stateFilingHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    stateFilingOT = true;
                    
                }
                
                stateFilingNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Corp State Filing') {
            
                stateFilingCorpID = pItem.Id;
                stateFilingCorpDesc = pItem.Description;
                stateFilingCorpHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    stateFilingCorpOT = true;
                    
                }
                
                stateFilingCorpNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Back Bookkeeping') {
            
                backBookkeepingID = pItem.Id;
                backBookkeepingDesc = pItem.Description;
                backBookkeepingHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                backBookkeepingDesc = backBookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions.'; 
                backBookkeepingHTMLDesc = backBookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    backBookkeepingOT = true;
                    
                }
                
                backBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Foreign State') {
            
                foreignStateID = pItem.Id;
                foreignStateDesc = pItem.Description;
                foreignStateHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    foreignStateOT = true;
                    
                }
                
                foreignStateNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Back Quarterly Payroll') {
            
                backPayrollID = pItem.Id;
                backPayrollDesc = pItem.Description;
                backPayrollHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                backPayrollDesc = backPayrollDesc + ' For ' + numberOfEmployeesInput + ' employees.'; 
                backPayrollHTMLDesc = backPayrollHTMLDesc + ' For ' + numberOfEmployeesInput + ' employees.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    backPayrollOT = true;
                    
                }
                
                backPayrollNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Back Business Return') {
            
                backBusinessID = pItem.Id;
                backBusinessDesc = pItem.Description;
                backBusinessHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    backBusinessOT = true;
                    
                }
                
                backBusinessNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Back Personal Return') {
            
                backPersonalID = pItem.Id;
                backPersonalDesc = pItem.Description;
                backPersonalHTMLDesc = pItem.HTML_Description__c;
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    backPersonalOT = true;
                    
                }
                
                backPersonalNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Non-Profit Bookkeeping') {
            
                nonProfitBookkeepingID = pItem.Id;
                nonProfitBookkeepingDesc = pItem.Description;
                nonProfitBookkeepingHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                nonProfitBookkeepingDesc = nonProfitBookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions.'; 
                nonProfitBookkeepingHTMLDesc = nonProfitBookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    nonProfitBookkeepingOT = true;
                    
                }
                
                nonProfitBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
        }
        
        // pull product id from Product2 object, Calculator_Location__c field
        // dynamically get product id's and pricebook id

        String priceBookBusinessID = '';
        String priceBookPersonalID = '';
        String priceBookPayrollID = '';
        String priceBookAdvisoryID = '';
        String priceBookBookkeepingID = '';
        String priceBookStateFilingID = '';
        String priceBookStateFilingCorpID = '';
        String priceBookBackBookkeepingID = '';
        String priceBookForeignStateID = '';
        String priceBookBackPayrollID = '';
        String priceBookBackBusinessID = '';
        String priceBookBackPersonalID = '';
        String priceBookNonProfitBookkeepingID = '';
        
        String bizTaxPrepPBEID = '';
        String personalTaxPrepPBEID = '';
        String payrollPBEID = '';
        String taxAdvisoryPBEID = '';
        String bookkeepingPBEID = '';
        String stateFilingPBEID = '';
        String stateFilingCorpPBEID = '';
        String backBookkeepingPBEID = '';
        String foreignStatePBEID = '';
        String backPayrollPBEID = '';
        String backBusinessPBEID = '';
        String backPersonalPBEID = '';
        String nonProfitBookkeepingPBEID = '';
        
        // check for price book entry, add if necessary
        List<PricebookEntry> pbAllList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id FROM PricebookEntry WHERE (Product2Id = :bizTaxPrepID OR Product2Id = :personalTaxPrepID OR Product2Id = :payrollID OR Product2Id = :taxAdvisoryID OR Product2Id = :bookkeepingID OR Product2Id = :stateFilingID OR Product2Id = :stateFilingCorpID OR Product2Id = :backBookkeepingID OR Product2Id = :foreignStateID OR Product2Id = :backPayrollID OR Product2Id = :backBusinessID OR Product2Id = :backPersonalID OR Product2Id = :nonProfitBookkeepingID) AND Pricebook2Id = :standardPriceBookID];
        
        for(PricebookEntry pbAllItem : pbAllList){
        
            if (pbAllItem.Product2Id == bizTaxPrepID) {
                bizTaxPrepPBEID = pbAllItem.Id;
                priceBookBusinessID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == personalTaxPrepID) {
                personalTaxPrepPBEID = pbAllItem.Id;
                priceBookPersonalID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == payrollID) {
                payrollPBEID = pbAllItem.Id;
                priceBookPayrollID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == taxAdvisoryID) {
                taxAdvisoryPBEID = pbAllItem.Id;
                priceBookAdvisoryID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == bookkeepingID) {
                bookkeepingPBEID = pbAllItem.Id;
                priceBookBookkeepingID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == stateFilingID) {
                stateFilingPBEID = pbAllItem.Id;
                priceBookStateFilingID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == stateFilingCorpID) {
                stateFilingCorpPBEID = pbAllItem.Id;
                priceBookStateFilingCorpID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == backBookkeepingID) {
                backBookkeepingPBEID = pbAllItem.Id;
                priceBookBackBookkeepingID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == foreignStateID) {
                foreignStatePBEID = pbAllItem.Id;
                priceBookForeignStateID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == backPayrollID) {
                backPayrollPBEID = pbAllItem.Id;
                priceBookBackPayrollID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == backBusinessID) {
                backBusinessPBEID = pbAllItem.Id;
                priceBookBackBusinessID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == backPersonalID) {
                backPersonalPBEID = pbAllItem.Id;
                priceBookBackPersonalID = pbAllItem.Pricebook2Id;
            } else if (pbAllItem.Product2Id == nonProfitBookkeepingID) {
                nonProfitBookkeepingPBEID = pbAllItem.Id;
                priceBookNonProfitBookkeepingID = pbAllItem.Pricebook2Id;
            }

        }
        
        // set pricebook id on opportunity
        
        if (BundleOverride == 'yes') {
            update new Opportunity(
                Id = opportunityID,
                Pricebook2Id = standardPriceBookID,
                Customized_Bundle__c = true,
                Name_of_Offer_Package__c = packageName
            );
        } else {
            update new Opportunity(
                Id = opportunityID,
                Pricebook2Id = standardPriceBookID,
                Customized_Bundle__c = false,
                Name_of_Offer_Package__c = packageName
            );
        }
        
        

        // add related data structures to quote
        ChargeOver_Quote__c theCOQuote;
        ChargeOver_Quote__c theCOQuoteMonth;
        ChargeOver_Quote__c theCOQuoteOneTime;
        
        Boolean madeYear = false;
        Boolean madeMonth = false;
        Boolean madeOneTime = false;
        
        String quoteNum = '';
        String brand = '1-800Accountant';
        
        if (sCorpSavings == '$0.00' || sCorpSavings == '0.00') {
            sCorpSavings = '';
        }
        if (homeOfficeSavings == '$0.00' || homeOfficeSavings == '0.00') {
            homeOfficeSavings = '';
        }
        if (busMileSavings == '$0.00' || busMileSavings == '0.00') {
            busMileSavings = '';
        }
        if (qbiSavings == '$0.00' || qbiSavings == '0.00') {
            qbiSavings = '';
        }
        if (startupExpSavings == '$0.00' || startupExpSavings == '0.00') {
            startupExpSavings = '';
        }
        
        
        if (potentialSavings == '$0.00' || potentialSavings == '0.00') {
            potentialSavings = '';
        }
        
        // Quote: AccountId, ContactId, OpportunityId, Pricebook2Id, Status
        
        // are we editing an existing quote?
        if (quoteID != '') {
        
            
            
            // edit quote record
            update new Quote(
                Id = quoteID,
                Pricebook2Id = standardPriceBookID,
                Calc_Entity_Type__c = entityTypeInput,
                Calc_Foreign_Owners__c = foreignOwnersInput,
                Calc_Industry_Type__c = industryTypeInput,
                Calc_Living_Abroad__c = livingAbroadInput,
                Calc_Number_of_Contractors__c = numberOfContractorsInput,
                Calc_Number_of_Employees__c = numberOfEmployeesInput,
                Calc_Number_of_K1s__c = numberOfK1sInput,
                Calc_Number_of_Owners__c = numberOfOwnersInput,
                Calc_Number_of_Transactions__c = numberOfTransactionsInput,
                Calc_Number_of_Rental_Properties__c = numberOfRentalPropertiesInput,
                Calc_Personal_Income__c = personalIncomeInput,
                Calc_Projected_1st_Year_Profit__c = projectedFirstYearProfitInput,
                Calc_Projected_1st_Year_Revenue__c = projectedFirstYearRevenueInput,
                Calc_State_of_Incorporation__c = stateOfIncorporationInput,
                Calc_Total_Investor_Funding__c = totalInvestorFundingInput,
                Calc_Total_Startup_Cost__c = totalStartupCostInput,
                Calc_Website_Selling_Goods__c = websiteSellingGoodsInput,
                Calc_Worked_with_Accountant__c = workedWithAccountantInPastInput,
                Calc_Run_Payroll_Before__c = runPayrollBeforeInput,
                Calc_Filing_Status__c = filingStatusInput,
                Calc_Business_Miles__c = businessMilesInput,
                Calc_Office_Square_Footage__c = officeSqFtInput,
                Calc_Years_in_Business__c = yearsInBusinessInput,
                Calc_Foreign_State__c = foreignStateInput,
                Calc_State_of_Residence__c = stateOfResidenceInput,
                billingSchedule__c = billingTime,
                Bundle__c = bundle,
                Calc_Savings_Amount__c = potentialSavings
            );
            
            // delete quote line items
            List<QuoteLineItem> oldQLI = [SELECT Id FROM QuoteLineItem WHERE QuoteId = :quoteID];
            delete oldQLI;
            
            // delete opportunity line items
            List<OpportunityLineItem> oldOLI = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId = :opportunityID];
            delete oldOLI;
            
            // delete chargeover quotes
            List<ChargeOver_Quote__c> oldCOQ = [SELECT Id FROM ChargeOver_Quote__c WHERE Quote__c = :quoteID];
            for(ChargeOver_Quote__c cOQItem : oldCOQ){
                
                // delete chargeover quote line items
                List<ChargeOver_Quote_Line_Item__c> oldCOQLI = [SELECT Id FROM ChargeOver_Quote_Line_Item__c WHERE ChargeOver_Quote__c = :cOQItem.Id];
                delete oldCOQLI;
                
            }
            
            delete oldCOQ;
            
            //sleep(3000);
            
            // get quote number from quote
            List <Quote> currentQuote = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteID];
            for(Quote cqItem : currentQuote){
                quoteNum = cqItem.QuoteNumber;
            }
                    
        } else {
        
            // create new quote, todo, check for existing quote first
            Quote theQuote;
            
            //ChargeOver_Quote__c theCOQuote;

            theQuote = new Quote(
                Name = accountNameInput+' Quote',
                OpportunityId = opportunityID,
                Pricebook2Id = standardPriceBookID,
                Calc_Entity_Type__c = entityTypeInput,
                Calc_Foreign_Owners__c = foreignOwnersInput,
                Calc_Industry_Type__c = industryTypeInput,
                Calc_Living_Abroad__c = livingAbroadInput,
                Calc_Number_of_Contractors__c = numberOfContractorsInput,
                Calc_Number_of_Employees__c = numberOfEmployeesInput,
                Calc_Number_of_K1s__c = numberOfK1sInput,
                Calc_Number_of_Owners__c = numberOfOwnersInput,
                Calc_Number_of_Transactions__c = numberOfTransactionsInput,
                Calc_Number_of_Rental_Properties__c = numberOfRentalPropertiesInput,
                Calc_Personal_Income__c = personalIncomeInput,
                Calc_Projected_1st_Year_Profit__c = projectedFirstYearProfitInput,
                Calc_Projected_1st_Year_Revenue__c = projectedFirstYearRevenueInput,
                Calc_State_of_Incorporation__c = stateOfIncorporationInput,
                Calc_Total_Investor_Funding__c = totalInvestorFundingInput,
                Calc_Total_Startup_Cost__c = totalStartupCostInput,
                Calc_Website_Selling_Goods__c = websiteSellingGoodsInput,
                Calc_Worked_with_Accountant__c = workedWithAccountantInPastInput,
                Calc_Run_Payroll_Before__c = runPayrollBeforeInput,
                Calc_Filing_Status__c = filingStatusInput,
                Calc_Business_Miles__c = businessMilesInput,
                Calc_Office_Square_Footage__c = officeSqFtInput,
                Calc_Foreign_State__c = foreignStateInput,
                Calc_Years_in_Business__c = yearsInBusinessInput,
                Calc_State_of_Residence__c = stateOfResidenceInput,
                billingSchedule__c = billingTime,
                Bundle__c = bundle,
                Calc_Savings_Amount__c = potentialSavings
            );
        
            insert theQuote;
                
            quoteID = theQuote.Id;
            //quoteNum = theQuote.QuoteNumber;
            
            List <Quote> currentQuote = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteID];
            for(Quote cqItem : currentQuote){
                quoteNum = cqItem.QuoteNumber;
            }
        }
        
        // update account fields from calculator form
        if (accountID != '') {
        
            List<Account> listToUpdate = new List<Account>();
            Boolean doAccountUpdateList = false;
            
            // save account fields
            List<Account> accList = [
                SELECT Industry, Expected_1st_year_revenue__c, Website_Selling_Goods__c, Foreign_Income__c, Entity_Tax_Classification__c, State_of_Formation__c, 
                Total_Startup_Costs__c, How_much_funding__c, Worked_With_CPA_Accountant__c, NumberOfEmployees, Number_of_owners__c, Primary_Contact_ID__c, 
                Trans_Per_Month__c, Personal_Income__c, Number_of_Contractors__c, Rental_Properties__c, Personal_Return_Filing_Status__c, Current_Year_Profit_Projection__c, 
                Potential_Business_Mile_Savings__c, Potential_Home_Office_Savings__c, Potential_QBI_Savings__c, Potential_SCorp_Savings__c, Potential_Startup_Savings__c, 
                Potential_Total_Savings__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c, Foreign_State__c, Years_in_Business__c, State_of_Residence__c 
                FROM Account 
                WHERE Id = :accountID
            ];
            for (Account accItem : accList){
            
                // save contact id
                contactID = accItem.Primary_Contact_ID__c;
                
                accItem.Potential_Business_Mile_Savings__c = busMileSavings;
                accItem.Potential_Home_Office_Savings__c = homeOfficeSavings;
                accItem.Potential_QBI_Savings__c = qbiSavings;
                accItem.Potential_SCorp_Savings__c = sCorpSavings;
                accItem.Potential_Startup_Savings__c = startupExpSavings;
                accItem.Potential_Total_Savings__c = potentialSavings;
                accItem.Estimated_Business_Mileage__c = businessMilesInput;
                accItem.Home_Office_Square_Feet__c = officeSqFtInput;
                accItem.Foreign_State__c = foreignStateInput;
                accItem.Years_in_Business__c = yearsInBusinessInput;
                accItem.State_of_Residence__c = stateOfResidenceInput;
                doAccountUpdateList = true;
                 
                if (accountNameInput != '') {
                
                    accItem.Name = accountNameInput;
                    doAccountUpdateList = true;
                    
                }
                
                if (billingStateInput != '') {
                
                    accItem.BillingState = billingStateInput;
                    doAccountUpdateList = true;
                    
                }
                
                if (billingCountryInput != '') {
                
                    accItem.BillingCountry = billingCountryInput;
                    doAccountUpdateList = true;
                    
                }
                
                if (billingStreetInput != '') {
                
                    accItem.BillingStreet = billingStreetInput;
                    doAccountUpdateList = true;
                    
                }
                
                if (billingCityInput != '') {
                
                    accItem.BillingCity = billingCityInput;
                    doAccountUpdateList = true;
                    
                }
                if (billingZipInput != '') {
                
                    accItem.BillingPostalCode = billingZipInput;
                    doAccountUpdateList = true;
                    
                }
            
                // industry
                if (accItem.Industry != '' && accItem.Industry != null) {
                
                    // should not overwrite existing value
                    
                } else {
                
                    accItem.Industry = industryTypeInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Expected_1st_year_revenue__c
                if (accItem.Expected_1st_year_revenue__c != '' && accItem.Expected_1st_year_revenue__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Expected_1st_year_revenue__c
                    accItem.Expected_1st_year_revenue__c = projectedFirstYearRevenueInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Entity_Tax_Classification__c
                if (accItem.Entity_Tax_Classification__c != '' && accItem.Entity_Tax_Classification__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Entity_Tax_Classification__c
                    accItem.Entity_Tax_Classification__c = entityTypeInput;
                    doAccountUpdateList = true;
                    
                }
                
                // State_of_Formation__c
                if (accItem.State_of_Formation__c != '' && accItem.State_of_Formation__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update State_of_Formation__c
                    accItem.State_of_Formation__c = stateOfIncorporationInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Total_Startup_Costs__c
                if (accItem.Total_Startup_Costs__c != '' && accItem.Total_Startup_Costs__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Total_Startup_Costs__c
                    accItem.Total_Startup_Costs__c = totalStartupCostInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Trans_Per_Month__c
                if (accItem.Trans_Per_Month__c != '' && accItem.Trans_Per_Month__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Trans_Per_Month__c
                    accItem.Trans_Per_Month__c = numberOfTransactionsInput;
                    doAccountUpdateList = true;
                    
                }
                
                // How_much_funding__c
                if (accItem.How_much_funding__c != '' && accItem.How_much_funding__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update How_much_funding__c
                    accItem.How_much_funding__c = totalInvestorFundingInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Number_of_owners__c
                if (accItem.Number_of_owners__c != '' && accItem.Number_of_owners__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Number_of_owners__c
                    accItem.Number_of_owners__c = numberOfOwnersInput;
                    doAccountUpdateList = true;
                    
                }
                
                // Personal_Income__c
                if (accItem.Personal_Income__c != '' && accItem.Personal_Income__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Personal_Income__c
                    accItem.Personal_Income__c = personalIncomeInput;
                    doAccountUpdateList = true;
                    
                }
                
                // current year profit
                if (accItem.Current_Year_Profit_Projection__c != '' && accItem.Current_Year_Profit_Projection__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Current_Year_Profit_Projection__c
                    accItem.Current_Year_Profit_Projection__c = projectedFirstYearProfitInput;
                    doAccountUpdateList = true;
                    
                }
                
                
                // NumberOfEmployees
                if (accItem.NumberOfEmployees != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    if (numberOfEmployeesInput.contains('+') == false) {
                    
                        // update NumberOfEmployees
                        accItem.NumberOfEmployees = Integer.valueOf(numberOfEmployeesInput);
                        doAccountUpdateList = true;

                    }

                }
                
                // Number_of_Contractors__c
                if (accItem.Number_of_Contractors__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    if (numberOfContractorsInput.contains('+') == false) {
                    
                        // update Number_of_Contractors__c
                        accItem.Number_of_Contractors__c = Integer.valueOf(numberOfContractorsInput);
                        doAccountUpdateList = true;

                    }

                }
                
                // Rental_Properties__c
                if (accItem.Rental_Properties__c != null) {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    if (numberOfRentalPropertiesInput.contains('+') == false) {
                    
                        // update Rental_Properties__c
                        accItem.Rental_Properties__c = Integer.valueOf(numberOfRentalPropertiesInput);
                        doAccountUpdateList = true;

                    }

                }
                
                // filing status
                if (accItem.Personal_Return_Filing_Status__c != null && accItem.Personal_Return_Filing_Status__c != '') {
                    
                    // should not overwrite existing value
                    
                } else {
                
                    // update Personal_Return_Filing_Status__c
                    accItem.Personal_Return_Filing_Status__c = filingStatusInput;
                    doAccountUpdateList = true;

                }
                
                if (workedWithAccountantInPastInput == 'Yes') {
                
                    accItem.Worked_With_CPA_Accountant__c = true;
                    doAccountUpdateList = true;

                }
                
                if (websiteSellingGoodsInput == 'Yes') {
                
                    accItem.Website_Selling_Goods__c = true;
                    doAccountUpdateList = true;

                }
                
                if (livingAbroadInput == 'Yes') {
                
                    accItem.Foreign_Income__c = true;
                    doAccountUpdateList = true;

                }
                
                if (doAccountUpdateList) {
                    listToUpdate.add(accItem);
                }
            
            }
            
            if (doAccountUpdateList) {
                update listToUpdate;
            }
            
        }
        
        Boolean doSomeSchedule = false;
        
        Boolean doADP = false;
        Boolean doADB = false;
        Boolean doLA = false;
        Boolean doTYR = false;
        Boolean doNP = false;
        Boolean doCB = false;
        Boolean doEF = false;
        Boolean doBackBook = false;
        Boolean doPTA = false;
        Boolean doBookAdv = false;
        
        Boolean doAnyOther = false;
               
        for(myWrapperClass acItem : acList){
        
            if (acItem.doIt) {
                doAnyOther = true;
                if (acItem.id == '01tf1000003JjrfAAC') {
                    doADP = true;
                }
                if (acItem.id == '01tf1000003JjrgAAC') {
                    doADB = true;
                }
                if (acItem.id == '01tj0000000LLamAAG') {
                    doLA = true;
                }
                if (acItem.id == '01tf1000003JjrhAAC') {
                    doTYR = true;
                }
                if (acItem.id == '01tf1000003JjruAAC') {
                    doNP = true;
                }
                if (acItem.id == '01tf1000004VPb5AAG') {
                    doCB = true;
                }
                if (acItem.id == '01tf1000004hsUWAAY') {
                    doEF = true;
                }
                if (acItem.id == '01tf1000004hhoGAAQ') {
                    doBackBook = true;
                    doSomeSchedule = true;
                }
                if (acItem.id == '01tf1000003Jjs1AAC') {
                    doBackBook = true;
                    doSomeSchedule = true;
                }
                if (acItem.id == '01tf1000004sVDeAAM') {
                    doPTA = true;
                    doSomeSchedule = true;
                }
                if (acItem.id == '01tf1000003Jjs1AAC') {
                    doBookAdv = true;
                }
               
                if (acItem.Id != '01tf1000004VPb5AAG' && acItem.Id != '01tf1000004hsUWAAY' && acItem.Id != '01t3Z000004bH2fQAE' && acItem.Id != '01t3Z0000057HZGQA2' && acItem.Id != '01tf1000003rJGkAAM' && acItem.Id != '01tf1000003JjrkAAC' && acItem.Id != '01tf1000004q0lgAAA' && acItem.Id != '01tf1000004q0lbAAA' && acItem.Id != '01tj0000000LLamAAG' && acItem.Id != '01tf1000003JjrhAAC' && acItem.Id != '01tf1000003JjrgAAC' && acItem.Id != '01tf1000003JjrfAAC' && acItem.Id != '01tj0000003mdhMAAQ' && acItem.Id != '01tj0000000uEdUAAU') {
                    doSomeSchedule = true;
                }
            }
        
        }
        
        if (billingTime == 'mon') {
            brand = 'Subscription Management Services';
        }
        
        if (LeadTypeNew.contains('Sprout') && doEF == true) {
            brand = 'EzBizFile';
            doSomeSchedule = false;     
        }
        
       
        if (LeadTypeNew.contains('EIN') && LeadSource == 'EIN Tax Filing') {
            brand = 'EIN-Tax-Filing';
        }
        
        // have they selected ClientBooks?
        if (doCB == true) {
            brand = 'ClientBooks';
        }
        
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        String sURL = uset.Scheduler_URL__c;
        
        String apptType = 'Discovery';
        
        if (doAdvisory || doBusinessReturn || doPersonalReturn) {
        
            doAnyOther = true;
            
        }
        
        if (doAdvisory) {
        
            doAnyOther = true;
            apptType = 'Discovery';
            
        } else {
        
            apptType = 'ALaCart';
            
            if (doBookAdv) {
            
                apptType = 'BKAdvOnboard';
            
            }
            
            if (doBookkeeping) {
            
                apptType = 'BKOnboard';
                
            } else if (doPayroll) {
            
                apptType = 'PayOnboard';
                
            }
            
            // check to see if back bookkeeping was selected
            if (doBackBook) {
            
                apptType = 'BKOnboard';
            
            }
            
            if (doPTA) {
            
                apptType = 'Discovery';
                
            }
            
        }
        
        if (brand == 'EzBizFile') {
        
            apptType = 'EForm';
            
        }
        
        String schedulerURL = sURL+'?TID='+apptType+'&WID='+contactID+'&EmailCampaignID='+emailCampaignIDInput;
        String schedulerVIPURL = '';
        
        if (apptType == 'Discovery') {
        
            schedulerVIPURL = sURL+'?TID=DiscoveryVIP&WID='+contactID+'&EmailCampaignID='+emailCampaignIDInput;
            
        }
        
        if (doAdvisory || doBusinessReturn || doPersonalReturn || doPayroll || doBookkeeping || brand == 'EzBizFile') {
            doSomeSchedule = true;
        }
 
        if (doSomeSchedule == false) {
            schedulerURL = '';
            schedulerVIPURL = '';
        }
        
        // update brand on opportunity
        update new Opportunity(
            Id = opportunityID,
            Brand__c = brand,
            Email_Campaign_ID__c = emailCampaignIDInput
        );
        
        Boolean updatedEventWithEC = false;
        
        if (emailCampaignIDInput != '') {
            
            // check for existing event related to opportunity and assign email campaign id if it exists
            // save account fields
            List<Event> eventList = [
                SELECT Id, WhoId, WhatId, Type_of_Appointment__c, ActivityDate   
                FROM Event 
                WHERE WhoId = :contactID AND (Type_of_Appointment__c = 'Tax Savings Analysis' OR Type_of_Appointment__c = 'BNA') AND ActivityDate = LAST_N_DAYS:365
                ORDER BY ActivityDate DESC
            ];
            
            for (Event eventItem : eventList){
                
                if (updatedEventWithEC == false) {
                    
                    // do the update
                    update new Event(
                        Id = eventItem.Id,
                        Email_Campaign_ID__c = emailCampaignIDInput
                    );
                    
                    updatedEventWithEC = true;
                    
                }
                
            }
            
        }
        
        // shorten account name if necessary
        String shortNameInput = accountNameInput;
        Integer maxSize = 70;
        if(shortNameInput.length() > maxSize ){
            shortNameInput = shortNameInput.substring(0, maxSize);
        }
        
        // initialize data structure for monthly billing chargeover quote
        theCOQuoteMonth = new ChargeOver_Quote__c(
                Name = shortNameInput+' Quote',
                Payment_Cycle__c = 'mon',
                Account__c = accountID,
                Quote_ID__c = quoteID,
                Quote__c = quoteID,
                Quote_Number__c = quoteNum + '-m',
                Opportunity__c = opportunityID,
                Brand_Name__c = brand,
                Contact__c = contactID,
                Sales_Source__c = 'Sales',
                Billing_Street_Line_1__c = billingStreetInput,
                Billing_City__c = billingCityInput,
                Billing_State__c = billingStateInput,
                Billing_Postal_Code__c = billingZipInput,
                Billing_Country__c = billingCountryInput,
                Scheduler_URL__c = schedulerURL,
                Name_of_Offer_Package__c = packageName
            );
        
        // was the monthly billing setting selected
        if (billingTime == 'mon') {
            
            // we havent made the yearly quote
            madeYear = false;
            
            // actually insert the quote
            insert theCOQuoteMonth;
            
            // get the quote id
            cOQuoteIDMonth = theCOQuoteMonth.Id;
            
            // save indicator that we have created the monthly quote
            madeMonth = true;
            
            theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
            
        } else {
            
            // what billing schedule was selected?
            if (billingTime == '2pay') {
            
                theCOQuote = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'yrl',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-y',
                    Installment_Payment_Schedule__c = 4,
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
                theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
            } else if (billingTime == '3pay') {
            
                theCOQuote = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'yrl',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-y',
                    Installment_Payment_Schedule__c = 5,
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
                theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
            } else if (billingTime == '4pay') {
            
                theCOQuote = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'yrl',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-y',
                    Installment_Payment_Schedule__c = 6,
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
                theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
            } else if (billingTime == '6pay') {
            
                theCOQuote = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'yrl',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-y',
                    Installment_Payment_Schedule__c = 7,
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
                theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
            } else {
            
                theCOQuote = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'yrl',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-y',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
                theCOQuoteOneTime = new ChargeOver_Quote__c(
                    Name = shortNameInput+' Quote',
                    Payment_Cycle__c = 'one',
                    Account__c = accountID,
                    Quote_ID__c = quoteID,
                    Quote__c = quoteID,
                    Quote_Number__c = quoteNum + '-o',
                    Opportunity__c = opportunityID,
                    Brand_Name__c = brand,
                    Contact__c = contactID,
                    Sales_Source__c = 'Sales',
                    Billing_Street_Line_1__c = billingStreetInput,
                    Billing_City__c = billingCityInput,
                    Billing_State__c = billingStateInput,
                    Billing_Postal_Code__c = billingZipInput,
                    Billing_Country__c = billingCountryInput,
                    Scheduler_URL__c = schedulerURL,
                    Name_of_Offer_Package__c = packageName
                );
                
            }
            
        } 
        
        

        // QuoteLineItem: ListPrice, OpportunityLineItemId, PricebookEntryId, Product2Id, Quantity, QuoteId, UnitPrice
        
        
        // Opportunity
        
        // 1st add OpportunityLineItems
        
        String OLIPayInstall = '';
        
        if (doBusinessReturn) {
        
            // do i need to create a chargeover quote?
            if (businessTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && bizTaxPrepNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (bizTaxPrepOT == true && (billingTime == 'yrl' || bizTaxPrepNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(businessAdjustment, offerProductList, 'bcheck', bundle, 'Business Tax Return', opportunityID, bizTaxPrepPBEID, bizTaxPrepID, businessQuantity, businessTime, businessTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, bizTaxPrepDesc, bizTaxPrepHTMLDesc, accountID, businessSort, false, 0.00, '', bizTaxPrepOT, bizTaxPrepNoSplit, '', numberOfEmployeesInput);
            
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (businessAdjustment * businessQuantity);
            
        }
        
        if (doPersonalReturn) {
        
            // do i need to create a chargeover quote?
            if (personalTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && personalTaxPrepNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (personalTaxPrepOT == true && (billingTime == 'yrl' || personalTaxPrepNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(personalAdjustment, offerProductList, 'pcheck', bundle, 'Personal Tax Return', opportunityID, personalTaxPrepPBEID, personalTaxPrepID, personalQuantity, personalTime, personalTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, personalTaxPrepDesc, personalTaxPrepHTMLDesc, accountID, personalSort, false, 0.00, '', personalTaxPrepOT, personalTaxPrepNoSplit, '', numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (personalAdjustment * personalQuantity);

        }
        
        if (doPayroll) {
        
            // default delayed billing value goes here
            holdDateString = '';
            itemSoldInOffer = false;
                
            // check for bundle price
            for(offerProductWrapperClass opwItem : offerProductList){
                
                if (opwItem.calcId == 'paycheck' && bundle == opwItem.offerId && opwItem.usePricebook == false) {
                    
                    payrollAdjustment = opwItem.amount;
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {

                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                   
                   }
                    
                } else if (opwItem.calcId == 'paycheck' && bundle == opwItem.offerId) {
                
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {
                    
                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                    
                    }
                
                }
                
            }
        
            // payroll line item
            OpportunityLineItem oLIPay;
            
            QuoteLineItem qLIPay;
            
            ChargeOver_Quote_Line_Item__c coqLIPay;
            
            OpportunityLineItem oLIPayFee;
            
            QuoteLineItem qLIPayFee;
            
            ChargeOver_Quote_Line_Item__c coqLIPayFee;
        
            if (payrollTime == 'Monthly') {
            
                if (payrollTimeDef == 'Monthly') {
                
                    tmpACPrice = payrollAdjustment;
                
                } else {
                
                    tmpACPrice = payrollAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = payrollAdjustment * payrollQuantity;
                
                subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                
                subAmount = tmpACPrice * payrollQuantity;

                oLIPay = new OpportunityLineItem(
                    Description = 'Payroll',
                    OpportunityId = opportunityID,
                    PricebookEntryId = payrollPBEID,
                    Product2Id = payrollID,
                    Quantity = payrollQuantity,
                    UnitPrice = payrollAdjustment,
                    Payment_Cycle__c = 'mon',
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount,
                    Installment_Payment_Schedule__c = OLIPayInstall
                ); 
            
                insert oLIPay;

                qLIPay = new QuoteLineItem(
                    QuoteId = quoteID,
                    OpportunityLineItemId = oLIPay.Id,
                    PricebookEntryId = payrollPBEID,
                    Product2Id = payrollID,
                    Quantity = payrollQuantity,
                    UnitPrice = payrollAdjustment,
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount
                );
                
                insert qLIPay;

                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                    
                coqLIPay = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = cOQuoteIDMonth,
                        Product__c = payrollID,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = payrollQuantity,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = payrollDesc,
                        HTML_Description__c = payrollHTMLDesc,
                        Account__c = accountID,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = payrollSort,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                
                if (numberOfEmployeesInput.contains('+') == false) {
                    
                    coqLIPay.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInput);

                } 
                
                // setup fee?
                if (payrollFee > 0) {
                
                    //opportunity line item
                    oLIPayFee = new OpportunityLineItem(
                        Description = 'Payroll Setup Fee',
                        OpportunityId = opportunityID,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = 1,
                        UnitPrice = payrollFee,
                        Payment_Cycle__c = 'one',
                        First_Charge_Price__c = payrollFee,
                        First_Charge_Total__c = payrollFee,
                        Installment_Payment_Schedule__c = 'One-Time'
                    ); 
                    
                    insert oLIPayFee;
                    
                    // quote line item
                    qLIPayFee = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLIPayFee.Id,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = 1,
                        UnitPrice = payrollFee,
                        First_Charge_Price__c = payrollFee,
                        First_Charge_Total__c = payrollFee
                    );
                    
                    insert qLIPayFee;
                    
                    // chargeover quote line item
                    coqLIPayFee = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = cOQuoteIDMonth,
                        Product__c = payrollID,
                        Price_Per_Unit__c = payrollFee,
                        Quantity__c = 1,
                        Contract_Amount__c = payrollFee,
                        Product_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                        HTML_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you.  This one-time charge covers all the necessary filing fees with your state.',
                        Account__c = accountID,
                        Sales_Source__c = 'Sales',
                        of_times_this_should_recur__c = 1,
                        Sort_Order__c = payrollSort,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                    insert coqLIPayFee;
                    
                }
            
            } else {
                
                if (billingTime == 'mon') {
                
                    if (payrollTimeDef == 'Monthly') {
                        
                        tmpACPrice = payrollAdjustment;
                        subTotalAmount = payrollAdjustment * payrollQuantity;
                        totalFAmount = payrollAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (payrollAdjustment / 12) * 1.2;
                        subTotalAmount = (payrollAdjustment * 1.2) * payrollQuantity;
                        totalFAmount = payrollAdjustment * 1.2;
                    
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                    totalFAmount = totalFAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    OLIPayInstall = 'Monthly';
                    
                    subAmount = tmpACPrice * payrollQuantity;
                
                    oLIPay = new OpportunityLineItem(
                        Description = 'Payroll',
                        OpportunityId = opportunityID,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = payrollQuantity,
                        UnitPrice = totalFAmount,
                        Payment_Cycle__c = 'mon',
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLIPay;
                    
                    qLIPay = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLIPay.Id,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = payrollQuantity,
                        UnitPrice = totalFAmount,
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLIPay;
            
                    if (madeMonth == false) {
                        
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                        
                    coqLIPay = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = cOQuoteIDMonth,
                        Product__c = payrollID,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = payrollQuantity,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = payrollDesc,
                        HTML_Description__c = payrollHTMLDesc,
                        Account__c = accountID,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = payrollSort,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                    if (numberOfEmployeesInput.contains('+') == false) {
                    
                        // update NumberOfEmployees
                        coqLIPay.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInput);
    
                    }
                    
                    // setup fee?
                    if (payrollFee > 0) {
                    
                        //opportunity line item
                        oLIPayFee = new OpportunityLineItem(
                            Description = 'Payroll Setup Fee',
                            OpportunityId = opportunityID,
                            PricebookEntryId = payrollPBEID,
                            Product2Id = payrollID,
                            Quantity = 1,
                            UnitPrice = payrollFee,
                            Payment_Cycle__c = 'one',
                            First_Charge_Price__c = payrollFee,
                            First_Charge_Total__c = payrollFee,
                            Installment_Payment_Schedule__c = 'One-Time'
                        ); 
                        
                        insert oLIPayFee;
                        
                        // quote line item
                        qLIPayFee = new QuoteLineItem(
                            QuoteId = quoteID,
                            OpportunityLineItemId = oLIPayFee.Id,
                            PricebookEntryId = payrollPBEID,
                            Product2Id = payrollID,
                            Quantity = 1,
                            UnitPrice = payrollFee,
                            First_Charge_Price__c = payrollFee,
                            First_Charge_Total__c = payrollFee
                        );
                        
                        insert qLIPayFee;
                        
                        // chargeover quote line item
                        coqLIPayFee = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDMonth,
                            Product__c = payrollID,
                            Price_Per_Unit__c = payrollFee,
                            Quantity__c = 1,
                            Contract_Amount__c = payrollFee,
                            Product_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                            HTML_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            of_times_this_should_recur__c = 1,
                            Sort_Order__c = payrollSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        
                        insert coqLIPayFee;
                        
                    }
                
                } else {
                
                    if (payrollTimeDef == 'Monthly') {
                    
                        tmpACPrice = payrollAdjustment * 11;
                    
                    } else {
                    
                        tmpACPrice = payrollAdjustment;
                    
                    }
                    
                    if (billingTime == '2pay') {
            
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2) * payrollQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay') {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3) * payrollQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay') {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4) * payrollQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay') {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6) * payrollQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice * payrollQuantity;
                        
                        if (payrollOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    subTotalAmount = tmpACPrice * payrollQuantity;
                
                    oLIPay = new OpportunityLineItem(
                        Description = 'Payroll',
                        OpportunityId = opportunityID,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = payrollQuantity,
                        UnitPrice = tmpACPrice,
                        Payment_Cycle__c = 'yrl',
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLIPay;
                    
                    qLIPay = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLIPay.Id,
                        PricebookEntryId = payrollPBEID,
                        Product2Id = payrollID,
                        Quantity = payrollQuantity,
                        UnitPrice = tmpACPrice,
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLIPay;
                    
                    if (payrollOT == true && billingTime == 'yrl') {
                
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                        coqLIPay = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDOneTime,
                            Product__c = payrollID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = payrollQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = payrollDesc,
                            HTML_Description__c = payrollHTMLDesc,
                            Account__c = accountID,
                            of_times_this_should_recur__c = 1,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = payrollSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        
                        if (numberOfEmployeesInput.contains('+') == false) {
                    
                            // update NumberOfEmployees
                            coqLIPay.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInput);
        
                        }
                        
                        // setup fee
                        if (payrollFee > 0) {
                    
                            //opportunity line item
                            oLIPayFee = new OpportunityLineItem(
                                Description = 'Payroll Setup Fee',
                                OpportunityId = opportunityID,
                                PricebookEntryId = payrollPBEID,
                                Product2Id = payrollID,
                                Quantity = 1,
                                UnitPrice = payrollFee,
                                Payment_Cycle__c = 'one',
                                First_Charge_Price__c = payrollFee,
                                First_Charge_Total__c = payrollFee,
                                Installment_Payment_Schedule__c = 'One-Time'
                            ); 
                            
                            insert oLIPayFee;
                            
                            // quote line item
                            qLIPayFee = new QuoteLineItem(
                                QuoteId = quoteID,
                                OpportunityLineItemId = oLIPayFee.Id,
                                PricebookEntryId = payrollPBEID,
                                Product2Id = payrollID,
                                Quantity = 1,
                                UnitPrice = payrollFee,
                                First_Charge_Price__c = payrollFee,
                                First_Charge_Total__c = payrollFee
                            );
                            
                            insert qLIPayFee;
                            
                            // chargeover quote line item
                            coqLIPayFee = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = cOQuoteIDOneTime,
                                Product__c = payrollID,
                                Price_Per_Unit__c = payrollFee,
                                Quantity__c = 1,
                                Contract_Amount__c = payrollFee,
                                Product_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                                HTML_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                                Account__c = accountID,
                                Sales_Source__c = 'Sales',
                                of_times_this_should_recur__c = 1,
                                Sort_Order__c = payrollSort,
                                Sold_in_Offer__c = itemSoldInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );
                            
                            insert coqLIPayFee;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                        coqLIPay = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteID,
                            Product__c = payrollID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = payrollQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = payrollDesc,
                            HTML_Description__c = payrollHTMLDesc,
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = payrollSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        
                        if (numberOfEmployeesInput.contains('+') == false) {
                    
                            // update NumberOfEmployees
                            coqLIPay.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInput);
        
                        }
                        
                        // setup fee
                        if (payrollFee > 0) {
                    
                            //opportunity line item
                            oLIPayFee = new OpportunityLineItem(
                                Description = 'Payroll Setup Fee',
                                OpportunityId = opportunityID,
                                PricebookEntryId = payrollPBEID,
                                Product2Id = payrollID,
                                Quantity = 1,
                                UnitPrice = payrollFee,
                                Payment_Cycle__c = 'one',
                                First_Charge_Price__c = payrollFee,
                                First_Charge_Total__c = payrollFee,
                                Installment_Payment_Schedule__c = 'One-Time'
                            ); 
                            
                            insert oLIPayFee;
                            
                            // quote line item
                            qLIPayFee = new QuoteLineItem(
                                QuoteId = quoteID,
                                OpportunityLineItemId = oLIPayFee.Id,
                                PricebookEntryId = payrollPBEID,
                                Product2Id = payrollID,
                                Quantity = 1,
                                UnitPrice = payrollFee,
                                First_Charge_Price__c = payrollFee,
                                First_Charge_Total__c = payrollFee
                            );
                            
                            insert qLIPayFee;
                            
                            // chargeover quote line item
                            coqLIPayFee = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = cOQuoteID,
                                Product__c = payrollID,
                                Price_Per_Unit__c = payrollFee,
                                Quantity__c = 1,
                                Contract_Amount__c = payrollFee,
                                Product_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                                HTML_Description__c = 'Never registered with your state to handle payroll? Don\'t worry, we take care of all the paperwork for you. This one-time charge covers all the necessary filing fees with your state.',
                                Account__c = accountID,
                                Sales_Source__c = 'Sales',
                                of_times_this_should_recur__c = 1,
                                Sort_Order__c = payrollSort,
                                Sold_in_Offer__c = itemSoldInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );
                            
                            insert coqLIPayFee;
                            
                        }

                    }
                    
                    

                }
                
            }
            
            insert coqLIPay;
            
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + subTotalAmount;

        }
        
        if (doAdvisory) {
        
            // do i need to create a chargeover quote?
            if (taxAdvisoryTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && taxAdvisoryNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (taxAdvisoryOT == true && (billingTime == 'yrl' || taxAdvisoryNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(taxAdvisoryPrice, offerProductList, 'acheck', bundle, 'Advisory', opportunityID, taxAdvisoryPBEID, taxAdvisoryID, taxAdvisoryQuantity, taxAdvisoryTime, taxAdvisoryTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, taxAdvisoryDesc, taxAdvisoryHTMLDesc, accountID, taxAdvisorySort, false, 0.00, '', taxAdvisoryOT, payrollNoSplit, '', numberOfEmployeesInput);
 
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (taxAdvisoryPrice * taxAdvisoryQuantity); 
 
        }
        
        if (doBookkeeping) {
        
            // do i need to create a chargeover quote?
            if (bookkeepingTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && bookkeepingNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (bookkeepingOT == true && (billingTime == 'yrl' || bookkeepingNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(bookkeepingAdjustment, offerProductList, 'bkcheck', bundle, 'Bookkeeping', opportunityID, bookkeepingPBEID, bookkeepingID, bookkeepingQuantity, bookkeepingTime, bookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, bookkeepingDesc, bookkeepingHTMLDesc, accountID, bookkeepingSort, false, 0.00, '', bookkeepingOT, bookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (bookkeepingAdjustment * bookkeepingQuantity); 

        }
        
        if (doStateFiling) {
        
            // default delayed billing value goes here
            holdDateString = '';
            itemSoldInOffer = false;
                
            // check for bundle price
            for(offerProductWrapperClass opwItem : offerProductList){
                
                if (opwItem.calcId == 'sfcheck' && bundle == opwItem.offerId && opwItem.usePricebook == false) {
                    
                    stateFilingAdjustment = opwItem.amount;
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {

                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                   
                   }
                    
                } else if (opwItem.calcId == 'sfcheck' && bundle == opwItem.offerId) {
                
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {
                    
                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                    
                    }
                
                }
                
            }
        
            // state filing line item
            OpportunityLineItem oLISF;
            
            QuoteLineItem qLISF;

            ChargeOver_Quote_Line_Item__c coqLISF;
            
            if (stateFilingTime == 'Monthly') {
            
                if (stateFilingTimeDef == 'Monthly') {
                
                    tmpACPrice = stateFilingAdjustment;
                
                } else {
                
                    tmpACPrice = stateFilingAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = stateFilingAdjustment * stateFilingQuantity;
                
                subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                
                subAmount = tmpACPrice * stateFilingQuantity;
                
                oLISF = new OpportunityLineItem(
                    Description = 'LLC State Filing',
                    OpportunityId = opportunityID,
                    PricebookEntryId = stateFilingPBEID,
                    Product2Id = stateFilingID,
                    Quantity = stateFilingQuantity,
                    UnitPrice = stateFilingAdjustment,
                    Payment_Cycle__c = 'mon',
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount,
                    Installment_Payment_Schedule__c = OLIPayInstall
                ); 
            
                insert oLISF;
    
                qLISF = new QuoteLineItem(
                    QuoteId = quoteID,
                    OpportunityLineItemId = oLISF.Id,
                    PricebookEntryId = stateFilingPBEID,
                    Product2Id = stateFilingID,
                    Quantity = stateFilingQuantity,
                    UnitPrice = stateFilingAdjustment,
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount
                );
                
                insert qLISF;
                
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
                coqLISF = new ChargeOver_Quote_Line_Item__c(
                    ChargeOver_Quote__c = cOQuoteIDMonth,
                    Product__c = stateFilingID,
                    Price_Per_Unit__c = tmpACPrice,
                    Quantity__c = stateFilingQuantity,
                    Contract_Amount__c = subTotalAmount,
                    Product_Description__c = stateFilingDesc,
                    HTML_Description__c = stateFilingHTMLDesc,
                    Account__c = accountID,
                    Sales_Source__c = 'Sales',
                    Sort_Order__c = stateFilingSort,
                    Sold_in_Offer__c = itemSoldInOffer,
                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                );
            
            } else {
                
                if (billingTime == 'mon' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                    if (stateFilingTimeDef == 'Monthly') {
                    
                        tmpACPrice = stateFilingAdjustment;
                        subTotalAmount = stateFilingAdjustment * stateFilingQuantity;
                        totalFAmount = stateFilingAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (stateFilingAdjustment / 12) * 1.2;
                        subTotalAmount = (stateFilingAdjustment * 1.2) * stateFilingQuantity;
                        totalFAmount = stateFilingAdjustment * 1.2;

                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                    totalFAmount = totalFAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    OLIPayInstall = 'Monthly';
                    
                    subAmount = tmpACPrice * stateFilingQuantity;
                    
                    oLISF = new OpportunityLineItem(
                        Description = 'LLC State Filing',
                        OpportunityId = opportunityID,
                        PricebookEntryId = stateFilingPBEID,
                        Product2Id = stateFilingID,
                        Quantity = stateFilingQuantity,
                        UnitPrice = totalFAmount,
                        Payment_Cycle__c = 'mon',
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLISF;
        
                    qLISF = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLISF.Id,
                        PricebookEntryId = stateFilingPBEID,
                        Product2Id = stateFilingID,
                        Quantity = stateFilingQuantity,
                        UnitPrice = totalFAmount,
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLISF;
                    
                    if (madeMonth == false) {
                        
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                    coqLISF = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = cOQuoteIDMonth,
                        Product__c = stateFilingID,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = stateFilingQuantity,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = stateFilingDesc,
                        HTML_Description__c = stateFilingHTMLDesc,
                        Account__c = accountID,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = stateFilingSort,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                } else {
                    
                    if (stateFilingTimeDef == 'Monthly') {
                        
                        tmpACPrice = stateFilingAdjustment * 11;
                        
                    } else {
                    
                        tmpACPrice = stateFilingAdjustment;
                    
                    }
                    
                    if (billingTime == '2pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
            
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2) * stateFilingQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3) * stateFilingQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4) * stateFilingQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6) * stateFilingQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice * stateFilingQuantity;
                        
                        if (stateFilingOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    subTotalAmount = tmpACPrice * stateFilingQuantity;
                    
                    oLISF = new OpportunityLineItem(
                        Description = 'LLC State Filing',
                        OpportunityId = opportunityID,
                        PricebookEntryId = stateFilingPBEID,
                        Product2Id = stateFilingID,
                        Quantity = stateFilingQuantity,
                        UnitPrice = tmpACPrice,
                        Payment_Cycle__c = 'yrl',
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLISF;
    
                    qLISF = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLISF.Id,
                        PricebookEntryId = stateFilingPBEID,
                        Product2Id = stateFilingID,
                        Quantity = stateFilingQuantity,
                        UnitPrice = tmpACPrice,
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLISF;
                    
                    if (stateFilingOT == true && (billingTime == 'yrl' || stateFilingSetupFee == 'One-Time' || stateFilingNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                        coqLISF = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDOneTime,
                            Product__c = stateFilingID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = stateFilingQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = stateFilingDesc,
                            HTML_Description__c = stateFilingHTMLDesc,
                            Account__c = accountID,
                            of_times_this_should_recur__c = 1,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = stateFilingSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                    
                        coqLISF = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteID,
                            Product__c = stateFilingID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = stateFilingQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = stateFilingDesc,
                            HTML_Description__c = stateFilingHTMLDesc,
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = stateFilingSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                    
                    }
                    
                }
                
            }

            insert coqLISF;
            
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + subTotalAmount;
            
        }
        
        if (doStateFilingCorp) {
        
            // default delayed billing value goes here
            holdDateString = '';
            itemSoldInOffer = false;
                
            // check for bundle price
            for(offerProductWrapperClass opwItem : offerProductList){
                
                if (opwItem.calcId == 'sfccheck' && bundle == opwItem.offerId && opwItem.usePricebook == false) {
                    
                    stateFilingCorpAdjustment = opwItem.amount;
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {

                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                   
                   }
                    
                } else if (opwItem.calcId == 'sfccheck' && bundle == opwItem.offerId) {
                
                    itemSoldInOffer = true;
                    
                    if (opwItem.delayDays > 0) {
                    
                        holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                        holdDateString = String.valueOf(holdDate);
                    
                    }
                
                }
                
            }
        
            // state filing line item
            OpportunityLineItem oLISFC;
            
            QuoteLineItem qLISFC;

            ChargeOver_Quote_Line_Item__c coqLISFC;
            
            if (stateFilingCorpTime == 'Monthly') {
            
                if (stateFilingCorpTimeDef == 'Monthly') {
                
                    tmpACPrice = stateFilingCorpAdjustment;
                
                } else {
                
                    tmpACPrice = stateFilingCorpAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = stateFilingCorpAdjustment * stateFilingCorpQuantity;
                
                subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                
                subAmount = tmpACPrice * stateFilingCorpQuantity;
                
                oLISFC = new OpportunityLineItem(
                    Description = 'Corp State Filing',
                    OpportunityId = opportunityID,
                    PricebookEntryId = stateFilingCorpPBEID,
                    Product2Id = stateFilingCorpID,
                    Quantity = stateFilingCorpQuantity,
                    UnitPrice = stateFilingCorpAdjustment,
                    Payment_Cycle__c = 'mon',
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount,
                    Installment_Payment_Schedule__c = OLIPayInstall
                ); 
            
                insert oLISFC;
    
                qLISFC = new QuoteLineItem(
                    QuoteId = quoteID,
                    OpportunityLineItemId = oLISFC.Id,
                    PricebookEntryId = stateFilingCorpPBEID,
                    Product2Id = stateFilingCorpID,
                    Quantity = stateFilingCorpQuantity,
                    UnitPrice = stateFilingCorpAdjustment,
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount
                );
                
                insert qLISFC;
                
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
                coqLISFC = new ChargeOver_Quote_Line_Item__c(
                    ChargeOver_Quote__c = cOQuoteIDMonth,
                    Product__c = stateFilingCorpID,
                    Price_Per_Unit__c = tmpACPrice,
                    Quantity__c = stateFilingCorpQuantity,
                    Contract_Amount__c = subTotalAmount,
                    Product_Description__c = stateFilingCorpDesc,
                    HTML_Description__c = stateFilingCorpHTMLDesc,
                    Account__c = accountID,
                    Sales_Source__c = 'Sales',
                    Sort_Order__c = stateFilingCorpSort,
                    Sold_in_Offer__c = itemSoldInOffer,
                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                );
            
            } else {
                
                if (billingTime == 'mon' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                    if (stateFilingCorpTimeDef == 'Monthly') {
                    
                        tmpACPrice = stateFilingCorpAdjustment;
                        subTotalAmount = stateFilingCorpAdjustment * stateFilingCorpQuantity;
                        totalFAmount = stateFilingCorpAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (stateFilingCorpAdjustment / 12) * 1.2;
                        subTotalAmount = (stateFilingCorpAdjustment * 1.2) * stateFilingCorpQuantity;
                        totalFAmount = stateFilingCorpAdjustment * 1.2;

                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                    totalFAmount = totalFAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    OLIPayInstall = 'Monthly';
                    
                    subAmount = tmpACPrice * stateFilingCorpQuantity;
                    
                    oLISFC = new OpportunityLineItem(
                        Description = 'Corp State Filing',
                        OpportunityId = opportunityID,
                        PricebookEntryId = stateFilingCorpPBEID,
                        Product2Id = stateFilingCorpID,
                        Quantity = stateFilingCorpQuantity,
                        UnitPrice = totalFAmount,
                        Payment_Cycle__c = 'mon',
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLISFC;
        
                    qLISFC = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLISFC.Id,
                        PricebookEntryId = stateFilingCorpPBEID,
                        Product2Id = stateFilingCorpID,
                        Quantity = stateFilingCorpQuantity,
                        UnitPrice = totalFAmount,
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLISFC;
                    
                    if (madeMonth == false) {
                        
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                    coqLISFC = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = cOQuoteIDMonth,
                        Product__c = stateFilingCorpID,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = stateFilingCorpQuantity,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = stateFilingCorpDesc,
                        HTML_Description__c = stateFilingCorpHTMLDesc,
                        Account__c = accountID,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = stateFilingCorpSort,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                } else {
                    
                    if (stateFilingCorpTimeDef == 'Monthly') {
                        
                        tmpACPrice = stateFilingCorpAdjustment * 11;
                        
                    } else {
                    
                        tmpACPrice = stateFilingCorpAdjustment;
                    
                    }
                    
                    if (billingTime == '2pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
            
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice * stateFilingCorpQuantity;
                        
                        if (stateFilingOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                    
                    subTotalAmount = tmpACPrice * stateFilingCorpQuantity;
                    
                    oLISFC = new OpportunityLineItem(
                        Description = 'Corp State Filing',
                        OpportunityId = opportunityID,
                        PricebookEntryId = stateFilingCorpPBEID,
                        Product2Id = stateFilingCorpID,
                        Quantity = stateFilingCorpQuantity,
                        UnitPrice = tmpACPrice,
                        Payment_Cycle__c = 'yrl',
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
                
                    insert oLISFC;
    
                    qLISFC = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLISFC.Id,
                        PricebookEntryId = stateFilingCorpPBEID,
                        Product2Id = stateFilingCorpID,
                        Quantity = stateFilingCorpQuantity,
                        UnitPrice = tmpACPrice,
                        First_Charge_Price__c = financeAmount,
                        First_Charge_Total__c = subAmount
                    );
                    
                    insert qLISFC;
                    
                    if (stateFilingCorpOT == true && (billingTime == 'yrl' || stateFilingCorpSetupFee == 'One-Time' || stateFilingCorpNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                        coqLISFC = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDOneTime,
                            Product__c = stateFilingCorpID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = stateFilingCorpQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = stateFilingCorpDesc,
                            HTML_Description__c = stateFilingCorpHTMLDesc,
                            Account__c = accountID,
                            of_times_this_should_recur__c = 1,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = stateFilingCorpSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                    
                        coqLISFC = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteID,
                            Product__c = stateFilingCorpID,
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = stateFilingCorpQuantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = stateFilingCorpDesc,
                            HTML_Description__c = stateFilingCorpHTMLDesc,
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = stateFilingCorpSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                    
                    }
                    
                }
                
            }

            insert coqLISFC;
            
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + subTotalAmount;
            
        }
        
        if (doBackBookkeeping) {
        
            // do i need to create a chargeover quote?
            if (backBookkeepingTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && backBookkeepingNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (backBookkeepingOT == true && (billingTime == 'yrl' || backBookkeepingNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(backBookkeepingAdjustment, offerProductList, 'bbkcheck', bundle, 'Back Bookkeeping', opportunityID, backBookkeepingPBEID, backBookkeepingID, backBookkeepingQuantity, backBookkeepingTime, backBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backBookkeepingDesc, backBookkeepingHTMLDesc, accountID, backBookkeepingSort, false, 0.00, '', backBookkeepingOT, backBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (backBookkeepingAdjustment * backBookkeepingQuantity);

        }
        
        if (doForeignState) {
        
            // do i need to create a chargeover quote?
            if (foreignStateTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && foreignStateNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (foreignStateOT == true && (billingTime == 'yrl' || foreignStateNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(foreignStateAdjustment, offerProductList, 'fscheck', bundle, 'Foreign State', opportunityID, foreignStatePBEID, foreignStateID, foreignStateQuantity, foreignStateTime, foreignStateTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, foreignStateDesc, foreignStateHTMLDesc, accountID, foreignStateSort, false, 0.00, '', foreignStateOT, foreignStateNoSplit, '', numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (foreignStateAdjustment * foreignStateQuantity);

        }
        
        if (doBackPayroll) {
        
            // do i need to create a chargeover quote?
            if (backPayrollTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && backPayrollNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (backPayrollOT == true && (billingTime == 'yrl' || backPayrollNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(backPayrollAdjustment, offerProductList, 'bpycheck', bundle, 'Back Quarterly Payroll', opportunityID, backPayrollPBEID, backPayrollID, backPayrollQuantity, backPayrollTime, backPayrollTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backPayrollDesc, backPayrollHTMLDesc, accountID, backPayrollSort, false, 0.00, '', backPayrollOT, backPayrollNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (backPayrollAdjustment * backPayrollQuantity);

        }
        
        if (doBackBusiness) {
        
            // do i need to create a chargeover quote?
            if (backBusinessTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && backBusinessNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (backBusinessOT == true && (billingTime == 'yrl' || backBusinessNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(backBusinessAdjustment, offerProductList, 'bbcheck', bundle, 'Back Business Return', opportunityID, backBusinessPBEID, backBusinessID, backBusinessQuantity, backBusinessTime, backBusinessTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backBusinessDesc, backBusinessHTMLDesc, accountID, backBusinessSort, false, 0.00, '', backBusinessOT, backBusinessNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (backBusinessAdjustment * backBusinessQuantity);

        }
        
        if (doBackPersonal) {
        
            // do i need to create a chargeover quote?
            if (backPersonalTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && backPersonalNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (backPersonalOT == true && (billingTime == 'yrl' || backPersonalNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(backPersonalAdjustment, offerProductList, 'bpcheck', bundle, 'Back Personal Return', opportunityID, backPersonalPBEID, backPersonalID, backPersonalQuantity, backPersonalTime, backPersonalTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backPersonalDesc, backPersonalHTMLDesc, accountID, backPersonalSort, false, 0.00, '', backPersonalOT, backPersonalNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (backPersonalAdjustment * backPersonalQuantity);

        }
        
        if (doNonProfitBookkeeping) {
        
            // do i need to create a chargeover quote?
            if (nonProfitBookkeepingTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && nonProfitBookkeepingNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (nonProfitBookkeepingOT == true && (billingTime == 'yrl' || nonProfitBookkeepingNoSplit == true)) {
                    
                        if (madeOneTime == false) {
                        
                            insert theCOQuoteOneTime;
                            
                            cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                            
                            madeOneTime = true;
                            
                        }
                        
                    } else {
                    
                        if (madeYear == false) {
                            // actually insert the yearly quote
                            insert theCOQuote;
                            
                            // get the quote id
                            cOQuoteID = theCOQuote.Id;
                            
                            // indicate that we have created the yearly quote
                            madeYear = true;
                        }
                        
                    } 
                    
                }
                
            }
            
            // call method to do the object creation
            makeLineItems(nonProfitBookkeepingAdjustment, offerProductList, 'npbcheck', bundle, 'Non-Profit Bookkeeping', opportunityID, nonProfitBookkeepingPBEID, nonProfitBookkeepingID, nonProfitBookkeepingQuantity, nonProfitBookkeepingTime, nonProfitBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, nonProfitBookkeepingDesc, nonProfitBookkeepingHTMLDesc, accountID, nonProfitBookkeepingSort, false, 0.00, '', nonProfitBookkeepingOT, nonProfitBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);

            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + (nonProfitBookkeepingAdjustment * nonProfitBookkeepingQuantity);

        }
        
        
        for(myWrapperClass acItem : acList){
        
            if (acItem.doIt) {
            
                tmpACPrice = acItem.price;
            
                // check to see if we need to zero out price for bundle
                if (acItem.id == '01tj0000000LLamAAG') {
                
                    if (doPersonalReturn && doAdvisory) {
                        tmpACPrice = 0;
                    } else {
                        tmpACPrice = acItem.price;
                    }
                    
                } else if (acItem.id == '01tf1000003JjrwAAC') {
                    
                    if (doBusinessReturn && doPersonalReturn && doAdvisory) {
                        tmpACPrice = 29.99;
                    } else if (doPersonalReturn && doAdvisory && doADP && doADB && doLA && doTYR) {
                        tmpACPrice = 29.99;
                    } else if (doPersonalReturn && doAdvisory && doNP) {
                        tmpACPrice = 29.99;
                    } else {
                        tmpACPrice = acItem.price;
                    }
                    
                } else if (acItem.id == '01tf1000004s3nYAAQ') {
                
                    // 1099 product, we need to do a one off discount, $20 per additional quantity
                    if (acItem.quantity == 1 || acItem.price == 0) {
                    
                        tmpACPrice = acItem.price;
                    
                    } else {

                        tmpACPrice = (acItem.price + ((acItem.quantity - 1) * 20)) / acItem.quantity;
                        tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    
                    }
                
                } else {
                    tmpACPrice = acItem.price;
                }
                
                // default delayed billing value goes here
                holdDateString = '';
                itemSoldInOffer = false;
                
                // check for bundle price
                for(offerProductWrapperClass opwItem : offerProductList){
                    
                    if (opwItem.productId == acItem.id && bundle == opwItem.offerId && opwItem.usePricebook == false) {
                        
                        tmpACPrice = opwItem.amount;
                        itemSoldInOffer = true;
                    
                        if (opwItem.delayDays > 0) {
    
                            holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                            holdDateString = String.valueOf(holdDate);
                       
                       }
                        
                    } else if (opwItem.productId == acItem.id && bundle == opwItem.offerId) {
                
                        itemSoldInOffer = true;
                        
                        if (opwItem.delayDays > 0) {
                        
                            holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                            holdDateString = String.valueOf(holdDate);
                        
                        }
                    
                    }
                    
                }
            
                // advisory line item
                OpportunityLineItem oLIA;
                
                QuoteLineItem qLIA;
                
                ChargeOver_Quote_Line_Item__c coqLIA;
            
                // is this a monthly billing item
                if (acItem.billingTime == 'Monthly') {

                    System.debug(LoggingLevel.FINER, 'acItem.billingTime Monthly :: -- ');
                    if (acItem.billingTimeDef == 'Monthly') {
                        
                        tmpACPrice2 = tmpACPrice;
                        
                    } else {
                    
                        tmpACPrice2 = tmpACPrice / 12;
                    
                    }
                    
                    tmpACPrice2 = tmpACPrice2.setScale(2, RoundingMode.HALF_UP);
                    
                    OLIPayInstall = 'Monthly';
                    
                    subTotalAmount = tmpACPrice * acItem.quantity;
                
                    subAmount = tmpACPrice2 * acItem.quantity;
                    
                    oLIA = new OpportunityLineItem(
                        Description = acItem.name,
                        OpportunityId = opportunityID,
                        PricebookEntryId = acItem.pbeid,
                        Product2Id = acItem.id,
                        Quantity = acItem.quantity,
                        UnitPrice = tmpACPrice,
                        Payment_Cycle__c = 'mon',
                        First_Charge_Price__c = tmpACPrice2,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = OLIPayInstall
                    ); 
            
                    insert oLIA;
    
                    qLIA = new QuoteLineItem(
                        QuoteId = quoteID,
                        OpportunityLineItemId = oLIA.Id,
                        PricebookEntryId = acItem.pbeid,
                        Product2Id = acItem.id,
                        Quantity = acItem.quantity,
                        UnitPrice = tmpACPrice,
                        First_Charge_Price__c = tmpACPrice2,
                        First_Charge_Total__c = subAmount
                    );
                
                    insert qLIA;
                    
                    if (madeMonth == false) {
                
                        insert theCOQuoteMonth;
                    
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                        madeMonth = true;
                        
                    }
                    
                    if (acItem.Id == '01tf1000004VPb5AAG') {
                        // for clientbooks we skip first 1 cycles
                        coqLIA = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDMonth,
                            Product__c = acItem.id,
                            Price_Per_Unit__c = tmpACPrice2,
                            Quantity__c = acItem.quantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = acItem.productDescription,
                            HTML_Description__c = acItem.htmlDescription,
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            of_Free_Trial_Cycles_Cycles_to_Skip__c = 1,
                            Sort_Order__c = acItem.quoteSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                   
                    } else {
                        coqLIA = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = cOQuoteIDMonth,
                            Product__c = acItem.id,
                            Price_Per_Unit__c = tmpACPrice2,
                            Quantity__c = acItem.quantity,
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = acItem.productDescription,
                            HTML_Description__c = acItem.htmlDescription,
                            Account__c = accountID,
                            Sales_Source__c = 'Sales',
                            Sort_Order__c = acItem.quoteSort,
                            Sold_in_Offer__c = itemSoldInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                    }
    
                    
                
                    insert coqLIA;

                } else {
                    
                    // if not, are we financing
                    if (billingTime == 'mon' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                    
                        if (acItem.billingTimeDef == 'Monthly') {
                    
                            tmpACPrice2 = tmpACPrice;
                            subTotalAmount = tmpACPrice * acItem.quantity;
                            totalFAmount = tmpACPrice;
                            
                        } else {
                        
                            tmpACPrice2 = (tmpACPrice / 12) * 1.2;
                            subTotalAmount = (tmpACPrice * 1.2) * acItem.quantity;
                            totalFAmount = tmpACPrice * 1.2;
    
                        }
                        
                        tmpACPrice2 = tmpACPrice2.setScale(2, RoundingMode.HALF_UP);
                        subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                        totalFAmount = totalFAmount.setScale(2, RoundingMode.HALF_UP);
                        
                        OLIPayInstall = 'Monthly';
                        
                        subAmount = tmpACPrice2 * acItem.quantity;
                        
                        oLIA = new OpportunityLineItem(
                            Description = acItem.name,
                            OpportunityId = opportunityID,
                            PricebookEntryId = acItem.pbeid,
                            Product2Id = acItem.id,
                            Quantity = acItem.quantity,
                            UnitPrice = totalFAmount,
                            Payment_Cycle__c = 'mon',
                            First_Charge_Price__c = tmpACPrice2,
                            First_Charge_Total__c = subAmount,
                            Installment_Payment_Schedule__c = OLIPayInstall
                        ); 
                
                        insert oLIA;
        
                        qLIA = new QuoteLineItem(
                            QuoteId = quoteID,
                            OpportunityLineItemId = oLIA.Id,
                            PricebookEntryId = acItem.pbeid,
                            Product2Id = acItem.id,
                            Quantity = acItem.quantity,
                            UnitPrice = totalFAmount,
                            First_Charge_Price__c = tmpACPrice2,
                            First_Charge_Total__c = subAmount
                        );
                    
                        insert qLIA;
                        
                        if (madeMonth == false) {
                
                            insert theCOQuoteMonth;
                        
                            cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                            madeMonth = true;
                            
                        }
        
                        if (acItem.Id == '01tf1000004VPb5AAG') {
                            // for clientbooks we skip first 2 cycles
                            coqLIA = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = cOQuoteIDMonth,
                                Product__c = acItem.id,
                                Price_Per_Unit__c = tmpACPrice2,
                                Quantity__c = acItem.quantity,
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = acItem.productDescription,
                                HTML_Description__c = acItem.htmlDescription,
                                Account__c = accountID,
                                Sales_Source__c = 'Sales',
                                of_Free_Trial_Cycles_Cycles_to_Skip__c = 1,
                                Sort_Order__c = acItem.quoteSort,
                                Sold_in_Offer__c = itemSoldInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );
                       
                        } else {
                            coqLIA = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = cOQuoteIDMonth,
                                Product__c = acItem.id,
                                Price_Per_Unit__c = tmpACPrice2,
                                Quantity__c = acItem.quantity,
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = acItem.productDescription,
                                HTML_Description__c = acItem.htmlDescription,
                                Account__c = accountID,
                                Sales_Source__c = 'Sales',
                                Sort_Order__c = acItem.quoteSort,
                                Sold_in_Offer__c = itemSoldInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );
                        }

                        insert coqLIA;
                    
                    } else {
                    
                        if (acItem.billingTimeDef == 'Monthly') {
                        
                            tmpACPrice2 = tmpACPrice * 11;
                            
                        } else {
                        
                            tmpACPrice2 = tmpACPrice;
                        
                        }
                    
                        if (billingTime == '2pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
            
                            financeAmount = (tmpACPrice2 / 2);
                            subAmount = (tmpACPrice2 / 2) * acItem.quantity;
                            
                            OLIPayInstall = '2-Pay';
                            
                        } else if (billingTime == '3pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                        
                            financeAmount = (tmpACPrice2 / 3);
                            subAmount = (tmpACPrice2 / 3) * acItem.quantity;
                            
                            OLIPayInstall = '3-Pay';
                            
                        } else if (billingTime == '4pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                        
                            financeAmount = (tmpACPrice2 / 4);
                            subAmount = (tmpACPrice2 / 4) * acItem.quantity;
                            
                            OLIPayInstall = '4-Pay';
                            
                        } else if (billingTime == '6pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                            
                            financeAmount = (tmpACPrice2 / 6);
                            subAmount = (tmpACPrice2 / 6) * acItem.quantity;
                            
                            OLIPayInstall = '6-Pay';
                            
                        } else {
                        
                            financeAmount = tmpACPrice2;
                            subAmount = tmpACPrice2 * acItem.quantity;
                            
                            if (acItem.billingFreq == 'One-Time') {
                                OLIPayInstall = 'One-Time';
                            } else {
                                OLIPayInstall = 'Yearly';
                            }
                            
                        }
                        
                        tmpACPrice2 = tmpACPrice2.setScale(2, RoundingMode.HALF_UP);
                        subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                        financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                        
                        subTotalAmount = tmpACPrice2 * acItem.quantity;
                    
                        oLIA = new OpportunityLineItem(
                            Description = acItem.name,
                            OpportunityId = opportunityID,
                            PricebookEntryId = acItem.pbeid,
                            Product2Id = acItem.id,
                            Quantity = acItem.quantity,
                            UnitPrice = tmpACPrice2,
                            Payment_Cycle__c = 'yrl',
                            First_Charge_Price__c = financeAmount,
                            First_Charge_Total__c = subAmount,
                            Installment_Payment_Schedule__c = OLIPayInstall
                        ); 
                
                        insert oLIA;

                        qLIA = new QuoteLineItem(
                            QuoteId = quoteID,
                            OpportunityLineItemId = oLIA.Id,
                            PricebookEntryId = acItem.pbeid,
                            Product2Id = acItem.id,
                            Quantity = acItem.quantity,
                            UnitPrice = tmpACPrice2,
                            First_Charge_Price__c = financeAmount,
                            First_Charge_Total__c = subAmount
                        );
                    
                        insert qLIA;
                        
                        // some logic here for one time charge
                        // we changed this to accomodate one time charges that may be part of split payments
                        //if (acItem.billingFreq == 'One-Time' && (billingTime == 'yrl' || acItem.setupFee == 'One-Time')) {
                        if (acItem.billingFreq == 'One-Time') {
                        
                            if (madeOneTime == false) {
                            
                                insert theCOQuoteOneTime;
                                
                                cOQuoteIDOneTime = theCOQuoteOneTime.Id;
                                
                                madeOneTime = true;
                                
                            }
                            
                            if (acItem.Id == '01tf1000004VPb5AAG') {
                                // for clientbooks we skip first 2 cycles
                                coqLIA = new ChargeOver_Quote_Line_Item__c(
                                    ChargeOver_Quote__c = cOQuoteIDOneTime,
                                    Product__c = acItem.id,
                                    Price_Per_Unit__c = tmpACPrice2,
                                    Quantity__c = acItem.quantity,
                                    Contract_Amount__c = subTotalAmount,
                                    Product_Description__c = acItem.productDescription,
                                    HTML_Description__c = acItem.htmlDescription,
                                    Account__c = accountID,
                                    of_times_this_should_recur__c = 1,
                                    Sales_Source__c = 'Sales',
                                    Sort_Order__c = acItem.quoteSort,
                                    Sold_in_Offer__c = itemSoldInOffer,
                                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                                );
                           
                            } else {
                                coqLIA = new ChargeOver_Quote_Line_Item__c(
                                    ChargeOver_Quote__c = cOQuoteIDOneTime,
                                    Product__c = acItem.id,
                                    Price_Per_Unit__c = tmpACPrice2,
                                    Quantity__c = acItem.quantity,
                                    Contract_Amount__c = subTotalAmount,
                                    Product_Description__c = acItem.productDescription,
                                    HTML_Description__c = acItem.htmlDescription,
                                    Account__c = accountID,
                                    of_times_this_should_recur__c = 1,
                                    Sales_Source__c = 'Sales',
                                    Sort_Order__c = acItem.quoteSort,
                                    Sold_in_Offer__c = itemSoldInOffer,
                                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                                );
                            }

                        } else {
                        
                            if (madeYear == false) {
                                // actually insert the yearly quote
                                insert theCOQuote;
                                
                                // get the quote id
                                cOQuoteID = theCOQuote.Id;
                                
                                // indicate that we have created the yearly quote
                                madeYear = true;
                            }
                            
                            if (acItem.Id == '01tf1000004VPb5AAG') {
                                // for clientbooks we skip first 2 cycles
                                coqLIA = new ChargeOver_Quote_Line_Item__c(
                                    ChargeOver_Quote__c = cOQuoteID,
                                    Product__c = acItem.id,
                                    Price_Per_Unit__c = tmpACPrice2,
                                    Quantity__c = acItem.quantity,
                                    Contract_Amount__c = subTotalAmount,
                                    Product_Description__c = acItem.productDescription,
                                    HTML_Description__c = acItem.htmlDescription,
                                    Account__c = accountID,
                                    Sales_Source__c = 'Sales',
                                    Sort_Order__c = acItem.quoteSort,
                                    Sold_in_Offer__c = itemSoldInOffer,
                                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                                );
                           
                            } else {
                                coqLIA = new ChargeOver_Quote_Line_Item__c(
                                    ChargeOver_Quote__c = cOQuoteID,
                                    Product__c = acItem.id,
                                    Price_Per_Unit__c = tmpACPrice2,
                                    Quantity__c = acItem.quantity,
                                    Contract_Amount__c = subTotalAmount,
                                    Product_Description__c = acItem.productDescription,
                                    HTML_Description__c = acItem.htmlDescription,
                                    Account__c = accountID,
                                    Sales_Source__c = 'Sales',
                                    Sort_Order__c = acItem.quoteSort,
                                    Sold_in_Offer__c = itemSoldInOffer,
                                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                                );
                            }
                            
                            
                            
                        }
                    
                        insert coqLIA;
                    
                    }
                    
                }
                
                // update vipAmount for scheduler url reasons
                vipAmount = vipAmount + subTotalAmount;

            }
        
        }
        
        // update chargeover quote to confirm done
        if (madeYear == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuote :: ' + theCOQuote);
            theCOQuote.Quote_Created__c = true;
            
            if (vipAmount > 4999 && schedulerVIPURL != '') {
                theCOQuote.Scheduler_URL__c = schedulerVIPURL;
            }
            
            update theCOQuote;
        }
        
        if (madeMonth == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuoteMonth :: ' + theCOQuoteMonth);
            theCOQuoteMonth.Quote_Created__c = true;
            
            if (vipAmount > 4999 && schedulerVIPURL != '') {
                theCOQuoteMonth.Scheduler_URL__c = schedulerVIPURL;
            }
            
            update theCOQuoteMonth;
        }
        
        if (madeOneTime == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuoteMonth :: ' + theCOQuoteMonth);
            theCOQuoteOneTime.Quote_Created__c = true;
            
            if (vipAmount > 4999 && schedulerVIPURL != '') {
                theCOQuoteOneTime.Scheduler_URL__c = schedulerVIPURL;
            }
            
            update theCOQuoteOneTime;
        }
        
        if (billingTime == 'mon') {
            return Page.Pricing_Calc_Approved;
        } else {
            return Page.Pricing_Calc_Display;
        }
        
    } 
    
    public void sleep(Long milliSeconds)
    {
        Long timeDiff = 0;
        DateTime firstTime = System.now(); 
        do
        {
            timeDiff = System.now().getTime() - firstTime.getTime();
        }
        while(timeDiff <= milliSeconds);
    }
    
    public PageReference doRedirect(){
        
        // redirect to quote
        return new PageReference('/'+opportunityID); 
        
    }
    
    @RemoteAction
    public static String getDiscountData(String formEntityType, String formForeignOwners, String formIndustryType, String formLivingAbroad, String formNumberOfContractors, String formNumberOfEmployees, String formNumberOfK1s, String formNumberOfOwners, String formNumberOfTransactions, String formNumberOfRentalProperties, String formPersonalIncome, String formProjectedFirstYearProfit, String formProjectedFirstYearRevenue, String formStateOfIncorporation, String formTotalInvestorFunding, String formTotalStartupCost, String formWebsiteSellingGoods, String formWorkedWithAccountantInPast, String formRunPayrollBefore, String formFilingStatus, String formOfficeSqFT, String formBusMiles){
        
        // initialize list to hold object that we will return from this method, properties are below
        // public String DiscountType {get;set;}
        // public Boolean DisplayDiscount {get;set;}
        // public Decimal Amount {get;set;}


        List<discountWrapper> discountList = new List<discountWrapper>();
        discountWrapper discountItem = new discountWrapper();
        
        discountItem.DiscountType = 'sCorpSavings';
        discountItem.DisplayDiscount = displaySCorporationSavings(Integer.valueOf(formProjectedFirstYearProfit), formEntityType, formIndustryType, Integer.valueOf(formForeignOwners));
        discountItem.Amount = (discountItem.DisplayDiscount == false) ? 0 : calculateSCorporationSavings(Integer.valueOf(formProjectedFirstYearProfit));
        discountList.add(discountItem);
        
        discountWrapper discountItem2 = new discountWrapper();
        
        discountItem2.DiscountType = 'homeOfficeSavings';
        Decimal officeSqFt = ('N/A' == formOfficeSqFT || '--' == formOfficeSqFT || null == formOfficeSqFT || '' == formOfficeSqFT) ? 0 : Decimal.valueOf(formOfficeSqFt);
        discountItem2.DisplayDiscount = (0 == officeSqFt || discountItem2.Amount <= 0) ? false : displaySavings(formEntityType, formIndustryType);
        discountItem2.Amount = (discountItem2.DisplayDiscount == false) ? 0 : calculateSavings('Home Office', formFilingStatus, Decimal.valueOf(formPersonalIncome), Decimal.valueOf(formProjectedFirstYearProfit), officeSqFt, 0, 0);
        discountList.add(discountItem2);
        
        discountWrapper discountItem3 = new discountWrapper();
        
        discountItem3.DiscountType = 'busMileSavings';
        Decimal businessMileage = ('N/A' == formBusMiles || '--' == formBusMiles || null == formBusMiles || '' == formBusMiles) ? 0 : Decimal.valueOf(formBusMiles);
        discountItem3.DisplayDiscount = (0 == businessMileage || discountItem3.Amount <= 0) ? false : displayBusinessMileageSavings(formEntityType, formIndustryType);
        discountItem3.Amount = (discountItem3.DisplayDiscount == false) ? 0 :calculateSavings('Business Mileage', formFilingStatus, Decimal.valueOf(formPersonalIncome), Decimal.valueOf(formProjectedFirstYearProfit), 0, businessMileage, 0);
        discountList.add(discountItem3);
        
        discountWrapper discountItem4 = new discountWrapper();
        
        discountItem4.DiscountType = 'qbiSavings';
        discountItem4.DisplayDiscount = (discountItem4.Amount <= 0) ? false : displaySavings(formEntityType, formIndustryType);
        discountItem4.Amount = (discountItem4.DisplayDiscount == false) ? 0 : calculateSavings('QBI', formFilingStatus, Decimal.valueOf(formPersonalIncome), Decimal.valueOf(formProjectedFirstYearProfit), 0, 0, 0);
        discountList.add(discountItem4);
        
        discountWrapper discountItem5 = new discountWrapper();
        
        discountItem5.DiscountType = 'startupExpSavings';
        discountItem5.DisplayDiscount = (discountItem5.Amount <= 0) ? false : displaySavings(formEntityType, formIndustryType);
        discountItem5.Amount = ('0' == formTotalStartupCost || '' == formTotalStartupCost || discountItem5.DisplayDiscount == false) ? 0 : calculateSavings('Startup Cost', formFilingStatus, Decimal.valueOf(formPersonalIncome), Decimal.valueOf(formProjectedFirstYearProfit), 0, 0, Decimal.valueOf(formTotalStartupCost));
    
        discountList.add(discountItem5);
        
        // return list
        return JSON.serialize(discountList);
    
    }

    public static Boolean displaySavings(String entityType, String industryType){
        Boolean display = true;
        if(disqualifiers.contains(entityType)
        || disqualifiers.contains(industryType)){
            display = false;
        }
        return display;
    }

    public static Boolean displayBusinessMileageSavings(String entityType, String industryType){
        Boolean display = true;
        List<String> businessMileageDisqualifiers = new List<String>();
        businessMileageDisqualifiers.addAll(disqualifiers);
        businessMileageDisqualifiers.add('Transportation');
        if(businessMileageDisqualifiers.contains(entityType)
        || businessMileageDisqualifiers.contains(industryType)){
            display = false;
        }
        return display;
    }

    public static Boolean displaySCorporationSavings(Integer formProjectedFirstYearProfit, String formEntityType, String formIndustryType, Integer formForeignOwners){
        Boolean display = true;
        if(0 == formProjectedFirstYearProfit){
            display = false;
        }
        List<String> SDisqualifiers = new List<String>();
        SDisqualifiers.addAll(disqualifiers);
        SDisqualifiers.add('S Corporation');
        if(SDisqualifiers.contains(formEntityType)
        || SDisqualifiers.contains(formIndustryType)){
            display = false;
        }

        if(formForeignOwners > 0){
            display = false;
        }
        return display;
    }


    public static Decimal calculateSCorporationSavings(Integer formProjectedFirstYearProfit){
        Decimal calculatedSCorporationSavings;
        switch on formProjectedFirstYearProfit{
            when 0 { 
                calculatedSCorporationSavings = 0.00;
            }
            when 5000 {
                calculatedSCorporationSavings = 459.00;
            }
            when 10000 {
                calculatedSCorporationSavings = 918.00;
            }
            when 25000 {
                calculatedSCorporationSavings = 2295.00;
            }
            when 50000 {
                calculatedSCorporationSavings = 4590.00;
            }
            when 75000 {
                calculatedSCorporationSavings = 6885.00;
            }
            when 100000 {
                calculatedSCorporationSavings = 9180.00;
            }
            when 150000 {
                calculatedSCorporationSavings = 12877.20;
            }
            when 250000 {
                calculatedSCorporationSavings = 17307.20;
            }
            when 500000 {
                calculatedSCorporationSavings = 24577.20;
            }
            when 1000000 {
                calculatedSCorporationSavings = 31407.20;
            }
        }
        return calculatedSCorporationSavings;
    }

    public static Decimal calculateSavings(String savingsType, String filingStatus, Decimal totalPersonalIncome, Decimal totalBusinessIncome, Decimal homeOfficeSqFt, Decimal businessMileage, Decimal totalStartupCosts){
        Decimal calculatedSavings = 0;
        Decimal businessIncome = ('Startup Cost' == savingsType) ? (totalBusinessIncome - (totalStartupCosts / 15)) : totalBusinessIncome;
        Decimal totalIncome = totalPersonalIncome + businessIncome;
        Decimal selfEmploymentTax = (businessIncome * .9235 * .153);
        Decimal deductibleOfSelfEmploymentTax = selfEmploymentTax / 2;
        Decimal agi = totalIncome - deductibleOfSelfEmploymentTax;
        Decimal standardDeduction = getDeduction(filingStatus, 'Standard Deduction');
        Decimal businessIncomeDeduction = getDeduction(filingStatus, 'Business Income Deduction');
        Decimal totalQBIDeduction = ('QBI' == savingsType) ? 0 : ((totalIncome > businessIncomeDeduction) ? 0 : (businessIncome * .2));
        //Putting this in a try catch so null errrors can be handled on the front end
        try{
            Decimal federalTaxableIncome = ((agi - standardDeduction - totalQBIDeduction) <= 0) ? 0 : (agi - standardDeduction - totalQBIDeduction);
            Decimal federalIncomeTax = calculateFederalIncomeTax(filingStatus, federalTaxableIncome);
            Decimal totalFederalTax = selfEmploymentTax + federalIncomeTax;
            //After
            Decimal adjustedBusinessIncome;
            if('Home Office' == savingsType){
                adjustedBusinessIncome = (totalBusinessIncome - (homeOfficeSqFt * 5) < 0) ? 0 : (totalBusinessIncome - (homeOfficeSqFt * 5));
            }
            if('Business Mileage' == savingsType){
                adjustedBusinessIncome = (totalBusinessIncome - (businessMileage * .56));
            }
            if(('Startup Cost' == savingsType)){
                adjustedBusinessIncome = totalBusinessIncome - ((totalStartupCosts > 50001) ? (totalStartupCosts / 15) : 5000 + ((totalStartupCosts - 5000) / 15));
            }
            if('QBI' == savingsType){
                adjustedBusinessIncome = totalBusinessIncome;
            }
            Decimal adjustedTotalIncome = totalPersonalIncome + adjustedBusinessIncome;
            Decimal adjustedSelfEmploymentTax = (adjustedBusinessIncome * .9235 * .153);
            Decimal adjustedDeductibleOfSelfEmploymentTax = adjustedSelfEmploymentTax / 2;
            Decimal adjustedAgi = adjustedTotalIncome - adjustedDeductibleOfSelfEmploymentTax;
            Decimal adjustedTotalQBIDeduction =  (adjustedTotalIncome > businessIncomeDeduction) ? 0 : (adjustedBusinessIncome * .2);
            Decimal adjustedFederalTaxableIncome = ((adjustedAgi - standardDeduction - adjustedTotalQBIDeduction) <= 0) ? 0 : (adjustedAgi - standardDeduction - adjustedTotalQBIDeduction);
            Decimal adjustedFederalIncomeTax = calculateFederalIncomeTax(filingStatus, adjustedFederalTaxableIncome);
            Decimal adjustedTotalFederalTax= adjustedSelfEmploymentTax + adjustedFederalIncomeTax;
    
            calculatedSavings = totalFederalTax - adjustedTotalFederalTax;
        } catch (Exception e){}
        
        return calculatedSavings.setScale(2);
        
    }

    public static Decimal getDeduction(String filingStatus, String deductionType){
        List<Tax_Deduction__mdt> getDeduction = [
            SELECT MasterLabel, Married_Filing_Jointly__c, Single__c, Head_of_Household__c, Married_Filing_Separate__c
            FROM Tax_Deduction__mdt
            WHERE MasterLabel = :deductionType
        ];

        if(null == getDeduction || getDeduction.size() > 1){
            throw new MisconfiguredMetadataException('Please check that Custom Metadata Type Found within the Parameters: { Filing Status: '+filingStatus+', Tax Deduction Type: '+deductionType+'} is configured correctly.');
        }

        Tax_Deduction__mdt taxDeduction = getDeduction[0];
        Decimal deduction;
        switch on filingStatus {
            when 'Single' {
                deduction = taxDeduction.Single__c;
            }
            when 'Head of Household' {
                deduction = taxDeduction.Head_of_Household__c;
            }
            when 'Married Filing Jointly' {
                deduction = taxDeduction.Married_Filing_Jointly__c;
            }
            when 'Married Filing Separate' {
                deduction = taxDeduction.Married_Filing_Separate__c;
            }
        }
        return deduction;
    }

    public static Decimal calculateFederalIncomeTax(String filingStatus, Decimal federalTaxableIncome){
        List<Tax_Bracket__mdt> getTaxBracket = [
            SELECT MasterLabel, Filing_Status__c, Tax_Bracket_Percentage__c, Minimum_Taxable_Income__c, Maximum_Taxable_Income__c
            FROM Tax_Bracket__mdt 
            WHERE Filing_Status__c = :filingStatus
            AND Minimum_Taxable_Income__c <= :federalTaxableIncome 
            AND Maximum_Taxable_Income__c >  :federalTaxableIncome
        ];
        if(getTaxBracket.size() == 0 || getTaxBracket.size() > 1){
            throw new MisconfiguredMetadataException('Please check that the Custom Metadata Type Found within the Parameters: { Filing Status: '+filingStatus+', Federal Taxable Income: '+math.round(federalTaxableIncome)+'} is configured correctly.');
        }

        Tax_Bracket__mdt taxBracket = getTaxBracket[0];
        Decimal floor = calculateFloor(taxBracket, filingStatus);
        Decimal calculatedFederalIncomeTax = floor + (federalTaxableIncome - taxBracket.Minimum_Taxable_Income__c) * (taxBracket.Tax_Bracket_Percentage__c * .01);
        
        return calculatedFederalIncomeTax;
    }

    public static Decimal calculateFloor(Tax_Bracket__mdt taxBracket, String filingStatus){
        List<Tax_Bracket__mdt> getLowerTaxBrackets = [
            SELECT MasterLabel, Filing_Status__c, Tax_Bracket_Percentage__c, Minimum_Taxable_Income__c, Maximum_Taxable_Income__c
            FROM Tax_Bracket__mdt 
            WHERE Filing_Status__c = :filingStatus
            AND Maximum_Taxable_Income__c < :taxBracket.Minimum_Taxable_Income__c
            ORDER BY Minimum_Taxable_Income__c ASC
        ];
        getLowerTaxBrackets.add(taxBracket);

        if((null == getLowerTaxBrackets && taxBracket.Minimum_Taxable_Income__c > 0)){
            throw new MisconfiguredMetadataException('Missing Custom Metadata Types Found within the Parameters: { Filing Status: '+filingStatus+', Income Limits Less Than: '+taxBracket.Minimum_Taxable_Income__c+'}');
        }

        Map<Decimal, Tax_Bracket__mdt> mappedMaxToBracket = new Map<Decimal, Tax_Bracket__mdt>();
        for(Tax_Bracket__mdt tb : getLowerTaxBrackets){
            mappedMaxToBracket.put(tb.Maximum_Taxable_Income__c, tb);
        }
 
        Decimal floor;
        Boolean firstIteration = true;
        Map<Tax_Bracket__mdt, Decimal> mappedBracketToFloor = new Map<Tax_Bracket__mdt, Decimal>();
        for(Tax_Bracket__mdt tb : getLowerTaxBrackets){
            if(firstIteration){
                firstIteration = false;
                mappedBracketToFloor.put(tb, 0);
            } else {
                Tax_Bracket__mdt lowerTaxBracket = mappedMaxToBracket.get((tb.Minimum_Taxable_Income__c - 1));
                if(null == lowerTaxBracket){
                    throw new MisconfiguredMetadataException('Missing Custom Metadata Type Found within the Parameters: { Filing Status: '+filingStatus+', Income Limit Maximum of '+(tb.Minimum_Taxable_Income__c - 1)+'}');
                }
                floor = math.ceil((lowerTaxBracket.Maximum_Taxable_Income__c - lowerTaxBracket.Minimum_Taxable_Income__c) * (lowerTaxBracket.Tax_Bracket_Percentage__c * .01) + (mappedBracketToFloor.get(lowerTaxBracket)));
                mappedBracketToFloor.put(tb, floor);
            }
        }

        return mappedBracketToFloor.get(taxBracket); 
    }
    
    public Void makeLineItems(Decimal productPassAdjustment, List<offerProductWrapperClass> offerProductListPass, String calcIdPass, String bundlePass, String productDescription, String opportunityIdPass, String pricebookEntryIdPass, String productIdPass, Integer quantityPass, String timePass, String timeDefPass, String billingTimePass, String quoteIdPass, String coQuoteIdPass, String coQuoteIdMonthPass, String coQuoteIdOneTimePass, String sowDescPass, String sowDescPassHTML, String accountIdPass, Decimal sortPass, Boolean doFeePass, Decimal feeAmountPass, String feeDesc, Boolean oneTimePass, Boolean noSplitPass, String numberOfTransactionsInputPass, String numberOfEmployeesInputPass)
    {
        
        // default variables declared here
        Boolean itemSoldInOffer = false;
        Datetime holdDate;
        String holdDateString = '';
        Decimal financeAmount = 0.00;
        Decimal subAmount = 0.00;
        Decimal totalFAmount = 0.00;
        Decimal subTotalAmount = 0.00;
        Decimal tmpACPrice = 0.00;
        Decimal tmpACPrice2 = 0.00;
        //Decimal productPassAdjustment = 0.00;
        String OLIPayInstall = '';
        
            
        // check for bundle price
        for(offerProductWrapperClass opwItem : offerProductListPass){
            
            if (opwItem.calcId == calcIdPass && bundlePass == opwItem.offerId && opwItem.usePricebook == false) {
                
                productPassAdjustment = opwItem.amount;
                itemSoldInOffer = true;
                
                if (opwItem.delayDays > 0) {
    
                    holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                    holdDateString = String.valueOf(holdDate);
               
               }
                
            } else if (opwItem.calcId == calcIdPass && bundlePass == opwItem.offerId) {
            
                itemSoldInOffer = true;
                
                if (opwItem.delayDays > 0) {
                
                    holdDate = System.today() + Integer.valueOf(opwItem.delayDays);
                    holdDateString = String.valueOf(holdDate);
                
                }
            
            }
            
        }
    
        // line item declarations
        OpportunityLineItem oLIPass;
        QuoteLineItem qLIPass;
        ChargeOver_Quote_Line_Item__c coqLIPass;
    
        // now we do something different depending on the timeframe for billing selected
        if (timePass == 'Monthly') {
        
            // what was the default for this product?
            if (timeDefPass == 'Monthly') {
            
                tmpACPrice = productPassAdjustment;
            
            } else {
            
                tmpACPrice = productPassAdjustment / 12;
            
            }
            
            tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
            
            OLIPayInstall = 'Monthly';
            
            subTotalAmount = productPassAdjustment * quantityPass;
            
            subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
            
            subAmount = tmpACPrice * quantityPass;
            
            oLIPass = new OpportunityLineItem(
                Description = productDescription,
                OpportunityId = opportunityIdPass,
                PricebookEntryId = pricebookEntryIdPass,
                Product2Id = productIdPass,
                Quantity = quantityPass,
                UnitPrice = productPassAdjustment,
                Payment_Cycle__c = 'mon',
                First_Charge_Price__c = tmpACPrice,
                First_Charge_Total__c = subAmount,
                Installment_Payment_Schedule__c = OLIPayInstall
            ); 
        
            insert oLIPass;
    
            qLIPass = new QuoteLineItem(
                QuoteId = quoteIdPass,
                OpportunityLineItemId = oLIPass.Id,
                PricebookEntryId = pricebookEntryIdPass,
                Product2Id = productIdPass,
                Quantity = quantityPass,
                UnitPrice = productPassAdjustment,
                First_Charge_Price__c = tmpACPrice,
                First_Charge_Total__c = subAmount
            );
            
            insert qLIPass;
            
            coqLIPass = new ChargeOver_Quote_Line_Item__c(
                ChargeOver_Quote__c = coQuoteIdMonthPass,
                Product__c = productIdPass,
                Price_Per_Unit__c = tmpACPrice,
                Quantity__c = quantityPass,
                Contract_Amount__c = subTotalAmount,
                Product_Description__c = sowDescPass,
                HTML_Description__c = sowDescPassHTML,
                Account__c = accountIdPass,
                Sales_Source__c = 'Sales',
                Sort_Order__c = sortPass,
                Sold_in_Offer__c = itemSoldInOffer,
                Date_Time_Invoice_Being_Held_Until__c = holdDateString
            );
            
            if (numberOfTransactionsInputPass != '') {
                
                coqLIPass.of_Monthly_Bookkeeping_Transactions__c = numberOfTransactionsInputPass;

            } 
            if (numberOfEmployeesInputPass.contains('+') == false && numberOfEmployeesInputPass != '') {
                
                coqLIPass.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInputPass);

            } 
        
        } else {
        
            if (noSplitPass == true) {
                billingTimePass = 'yrl';
            }
            
            if (billingTimePass == 'mon') {
            
                OLIPayInstall = 'Monthly';
                
                if (timeDefPass == 'Monthly') {
                
                    tmpACPrice = productPassAdjustment;
                    subTotalAmount = productPassAdjustment * quantityPass;
                    totalFAmount = productPassAdjustment;
                    
                } else {
                
                    tmpACPrice = (productPassAdjustment / 12) * 1.2;
                    subTotalAmount = (productPassAdjustment * 1.2) * quantityPass;
                    totalFAmount = productPassAdjustment * 1.2;
    
                }
                
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);
                totalFAmount = totalFAmount.setScale(2, RoundingMode.HALF_UP);
                
                subAmount = tmpACPrice * quantityPass;
                
                oLIPass = new OpportunityLineItem(
                    Description = productDescription,
                    OpportunityId = opportunityIdPass,
                    PricebookEntryId = pricebookEntryIdPass,
                    Product2Id = productIdPass,
                    Quantity = quantityPass,
                    UnitPrice = totalFAmount,
                    Payment_Cycle__c = 'mon',
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount,
                    Installment_Payment_Schedule__c = OLIPayInstall
                ); 
            
                insert oLIPass;
    
                qLIPass = new QuoteLineItem(
                    QuoteId = quoteIdPass,
                    OpportunityLineItemId = oLIPass.Id,
                    PricebookEntryId = pricebookEntryIdPass,
                    Product2Id = productIdPass,
                    Quantity = quantityPass,
                    UnitPrice = totalFAmount,
                    First_Charge_Price__c = tmpACPrice,
                    First_Charge_Total__c = subAmount
                );
                
                insert qLIPass;
                
                coqLIPass = new ChargeOver_Quote_Line_Item__c(
                    ChargeOver_Quote__c = coQuoteIdMonthPass,
                    Product__c = productIdPass,
                    Price_Per_Unit__c = tmpACPrice,
                    Quantity__c = quantityPass,
                    Contract_Amount__c = subTotalAmount,
                    Product_Description__c = sowDescPass,
                    HTML_Description__c = sowDescPassHTML,
                    Account__c = accountIdPass,
                    Sales_Source__c = 'Sales',
                    Sort_Order__c = sortPass,
                    Sold_in_Offer__c = itemSoldInOffer,
                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                );
                
                if (numberOfTransactionsInputPass != '') {
                    
                    coqLIPass.of_Monthly_Bookkeeping_Transactions__c = numberOfTransactionsInputPass;
    
                } 
                if (numberOfEmployeesInputPass.contains('+') == false && numberOfEmployeesInputPass != '') {
                
                    coqLIPass.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInputPass);
    
                } 
                
            } else {
                
                if (timeDefPass == 'Monthly') {
                    
                    tmpACPrice = productPassAdjustment * 11;
                    
                } else {
                
                    tmpACPrice = productPassAdjustment;
                
                }
                
                if (billingTimePass == '2pay') {
        
                    financeAmount = (tmpACPrice / 2);
                    subAmount = (tmpACPrice / 2) * quantityPass;
                    
                    OLIPayInstall = '2-Pay';
                    
                } else if (billingTimePass == '3pay') {
                
                    financeAmount = (tmpACPrice / 3);
                    subAmount = (tmpACPrice / 3) * quantityPass;
                    
                    OLIPayInstall = '3-Pay';
                    
                } else if (billingTimePass == '4pay') {
                
                    financeAmount = (tmpACPrice / 4);
                    subAmount = (tmpACPrice / 4) * quantityPass;
                    
                    OLIPayInstall = '4-Pay';
                    
                } else if (billingTimePass == '6pay') {
                    
                    financeAmount = (tmpACPrice / 6);
                    subAmount = (tmpACPrice / 6) * quantityPass;
                    
                    OLIPayInstall = '6-Pay';
                    
                } else {
                
                    financeAmount = tmpACPrice;
                    subAmount = tmpACPrice * quantityPass;
    
                    if (oneTimePass == true) {
                        OLIPayInstall = 'One-Time';
                    } else {
                        OLIPayInstall = 'Yearly';
                    }
                    
                }
                
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                
                subTotalAmount = tmpACPrice * quantityPass;
            
                oLIPass = new OpportunityLineItem(
                    Description = productDescription,
                    OpportunityId = opportunityIdPass,
                    PricebookEntryId = pricebookEntryIdPass,
                    Product2Id = productIdPass,
                    Quantity = quantityPass,
                    UnitPrice = tmpACPrice,
                    Payment_Cycle__c = 'yrl',
                    First_Charge_Price__c = financeAmount,
                    First_Charge_Total__c = subAmount,
                    Installment_Payment_Schedule__c = OLIPayInstall
                ); 
            
                insert oLIPass;
    
                qLIPass = new QuoteLineItem(
                    QuoteId = quoteIdPass,
                    OpportunityLineItemId = oLIPass.Id,
                    PricebookEntryId = pricebookEntryIdPass,
                    Product2Id = productIdPass,
                    Quantity = quantityPass,
                    UnitPrice = tmpACPrice,
                    First_Charge_Price__c = financeAmount,
                    First_Charge_Total__c = subAmount
                );
                
                insert qLIPass;
                
                if (oneTimePass == true && billingTimePass == 'yrl') {
                    
                    coqLIPass = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = coQuoteIdOneTimePass,
                        Product__c = productIdPass,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = quantityPass,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = sowDescPass,
                        HTML_Description__c = sowDescPassHTML,
                        Account__c = accountIdPass,
                        of_times_this_should_recur__c = 1,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = sortPass,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                    if (numberOfTransactionsInputPass != '') {
                    
                        coqLIPass.of_Monthly_Bookkeeping_Transactions__c = numberOfTransactionsInputPass;
        
                    } 
                    if (numberOfEmployeesInputPass.contains('+') == false && numberOfEmployeesInputPass != '') {
                
                        coqLIPass.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInputPass);
        
                    } 
                    
                } else {
                
                    coqLIPass = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = coQuoteIdPass,
                        Product__c = productIdPass,
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = quantityPass,
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = sowDescPass,
                        HTML_Description__c = sowDescPassHTML,
                        Account__c = accountIdPass,
                        Sales_Source__c = 'Sales',
                        Sort_Order__c = sortPass,
                        Sold_in_Offer__c = itemSoldInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    
                    if (numberOfTransactionsInputPass != '') {
                    
                        coqLIPass.of_Monthly_Bookkeeping_Transactions__c = numberOfTransactionsInputPass;
        
                    } 
                    if (numberOfEmployeesInputPass.contains('+') == false && numberOfEmployeesInputPass != '') {
                
                        coqLIPass.of_Payroll_Employees__c = Integer.valueOf(numberOfEmployeesInputPass);
        
                    } 
                    
                }                                
                
            }
            
        }
        
        insert coqLIPass;
        
        
    }
    
    public Decimal getDynamicAmount(String productNamePass, String entityTypeInputPass, String foreignOwnersInputPass, String industryTypeInputPass, String livingAbroadInputPass, String numberOfContractorsInputPass, String numberOfEmployeesInputPass, String numberOfK1sInputPass, String numberOfOwnersInputPass, String numberOfRentalPropertiesInputPass, String personalIncomeInputPass, String projectedFirstYearProfitInputPass, String projectedFirstYearRevenueInputPass, String stateOfIncorporationInputPass, String totalInvestorFundingInputPass, String totalStartupCostInputPass, String websiteSellingGoodsInputPass, String workedWithAccountantInPastInputPass, String numberOfTransactionsInputPass, String filingStatusInputPass, String businessMilesInputPass, String officeSqFtInputPass, String foreignStateInputPass, String yearsInBusinessInputPass) 
    {
        Decimal adjustAmount = 0.00;
        String tempValue = '';
        
        // start with business return calculation
        List<Calculator_Dropdown__c> dropListB = [SELECT Id, Dropdown_Value__c, Form_Field__c, Price_Adjustment__c, Product__c FROM Calculator_Dropdown__c WHERE Product__c = :productNamePass];
        
        for(Calculator_Dropdown__c dropItem : dropListB){
            
            tempValue = '';
            
            if (dropItem.Form_Field__c == 'Entity Type') {
                tempValue = entityTypeInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Foreign Owners') {
                tempValue = foreignOwnersInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Industry Type') {
                tempValue = industryTypeInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Living Abroad') {
                tempValue = livingAbroadInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Contractors') {
                tempValue = numberOfContractorsInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Employees') {
                tempValue = numberOfEmployeesInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of K1s') {
                tempValue = numberOfK1sInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Owners') {
                tempValue = numberOfOwnersInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Rental Properties') {
                tempValue = numberOfRentalPropertiesInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Personal Income') {
                tempValue = personalIncomeInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Projected 1st Year Profit') {
                tempValue = projectedFirstYearProfitInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Projected 1st Year Revenue') {
                tempValue = projectedFirstYearRevenueInputPass;
            }
            
            if (dropItem.Form_Field__c == 'State of Incorporation') {
                tempValue = stateOfIncorporationInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Total Investor Funding') {
                tempValue = totalInvestorFundingInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Total Startup Cost') {
                tempValue = totalStartupCostInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Website Selling Goods') {
                tempValue = websiteSellingGoodsInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Worked With Accountant in Past') {
                tempValue = workedWithAccountantInPastInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Transactions') {
                tempValue = numberOfTransactionsInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Filing Status') {
                tempValue = filingStatusInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Business Miles') {
                tempValue = businessMilesInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Office Square Footage') {
                tempValue = officeSqFtInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Foreign State') {
                tempValue = foreignStateInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Years In Business') {
                tempValue = yearsInBusinessInputPass;
            }
                
            if (tempValue == dropItem.Dropdown_Value__c) {
                adjustAmount = adjustAmount + dropItem.Price_Adjustment__c;
            }
        
        }
        
        return adjustAmount;
        
    }
    
}