public class PricingCalcController {
    public class MisconfiguredMetadataException extends Exception {} 
    public List<SelectOption> entityType {get;set;}
    public List<SelectOption> industryType {get;set;}
    public List<SelectOption> numberOfEmployees {get;set;}
    public List<SelectOption> numberOfOwners {get;set;}
    public List<SelectOption> numberOfTransactions {get;set;}
    public List<SelectOption> numberOfRentalProperties {get;set;}
    public List<SelectOption> personalIncome {get;set;}
    public List<SelectOption> projectedFirstYearProfit {get;set;}
    public List<SelectOption> projectedFirstYearRevenue {get;set;}
    public List<SelectOption> totalStartupCost {get;set;}
    public List<SelectOption> runPayrollBefore {get;set;}
    public List<SelectOption> filingStatus {get;set;}
    public List<SelectOption> stateOfIncorporation {get;set;}
    public List<SelectOption> businessMiles {get;set;}
    public List<SelectOption> officeSqFt {get;set;}
    public List<SelectOption> foreignState {get;set;}
    public List<SelectOption> bundleItems {get;set;}
    public List<SelectOption> billingItems {get;set;}
    public List<SelectOption> timeItems {get;set;}
    public List<SelectOption> billingStateItems {get;set;}
    public List<SelectOption> billingCountryItems {get;set;}
    
    public List<Product2> acListP {get;set;}
    public List<Product2> acListProducts {get;set;}
    //public List<Product2> bundle1List {get;set;}
    //public List<String> acList {get;set;}
    
    public String entityTypeInput {get;set;}
    public String industryTypeInput {get;set;}
    public String numberOfEmployeesInput {get;set;}
    public String numberOfOwnersInput {get;set;}
    public String numberOfTransactionsInput {get;set;}
    public String numberOfRentalPropertiesInput {get;set;}
    public String personalIncomeInput {get;set;}
    public String projectedFirstYearProfitInput {get;set;}
    public String projectedFirstYearRevenueInput {get;set;}
    public String totalStartupCostInput {get;set;}
    public String runPayrollBeforeInput {get;set;}
    public String filingStatusInput {get;set;}
    public String leadSourceInput {get;set;}
    public String leadTypeInput {get;set;}
    
    public String businessMilesInput {get;set;}
    public String officeSqFtInput {get;set;}
    public String foreignStateInput {get;set;}
    public String bookKeepingStartDateInput {get;set;}
    public String bookKeepingEndDateInput {get;set;}
    
    
    public String bundle {get;set;}
    public String billingTime {get;set;}
    public String accountNameInput {get;set;}
    public String stateOfIncorporationInput {get;set;}
    public String billingStateInput {get;set;}
    public String billingCountryInput {get;set;}
    public String billingStreetInput {get;set;}
    public String billingCityInput {get;set;}
    public String billingZipInput {get;set;}
    public String LeadTypeNew = '';
    public String LeadSource = '';
    public String UserSkill {get;set;}
    public String BundleOverride {get;set;}
    
    public String entityTypeClass {get;set;}
    public String industryTypeClass {get;set;}
    public String numberOfEmployeesClass {get;set;}
    public String numberOfOwnersClass {get;set;}
    public String numberOfTransactionsClass {get;set;}
    public String numberOfRentalPropertiesClass {get;set;}
    public String personalIncomeClass {get;set;}
    public String projectedFirstYearProfitClass {get;set;}
    public String projectedFirstYearRevenueClass {get;set;}
    public String totalStartupCostClass {get;set;}
    public String runPayrollBeforeClass {get;set;}
    public String filingStatusClass {get;set;}
    public String stateOfIncorporationClass {get;set;}
    public String bookKeepingStartDateClass {get;set;}
    public String bookKeepingEndDateClass {get;set;}
    
    public String businessMilesClass {get;set;}
    public String officeSqFtClass {get;set;}
    public String foreignStateClass {get;set;}
    
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
    public Boolean doNonProfitBackBookkeeping {get;set;}
    
    public Boolean doBackPayroll {get;set;}
    public Boolean doBackBusiness {get;set;}
    public Boolean doBackPersonal {get;set;}
    public Boolean doNonProfitBookkeeping {get;set;}
    public Boolean doNonProfitReturn {get;set;}
    
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
    public Boolean excludeNonProfitBackBookkeeping {get;set;}
    
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
    public Boolean disableNonProfitBackBookkeeping {get;set;}
    
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
    public String disableNonProfitBackBookkeepingMessage {get;set;}
    
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
    public Boolean disableQTYNonProfitBackBookkeeping {get;set;}
    
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
    public Boolean optionNonProfitBackBookkeeping {get;set;}
    
    // platform access
    public Boolean hasPlatformAccess {get;set;}

    public Account accountRecord {get;set;}
 
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
    public Decimal nonProfitBackBookkeepingAdjustment {get;set;}
    
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
    public Decimal nonProfitBackBookkeepingFee {get;set;}
    
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
    public Integer nonProfitBackBookkeepingQuantity {get;set;}
    
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
    public Decimal nonProfitBackBookkeepingSort {get;set;}
    
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
    public String nonProfitBackBookkeepingTime {get;set;}
    
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
    public String nonProfitBackBookkeepingTimeDef {get;set;}
    
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
    public String nonProfitBackBookkeepingID {get;set;}
    
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
    public Boolean nonProfitBackBookkeepingNoSplit {get;set;}
    
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

    public List<String> productsToQuery = new List<String>{'Business Return', 'Personal Return', 'Payroll', 'Bookkeeping', 'Advisory', 'LLC State Filing', 'Corp State Filing', 'Back Bookkeeping', 'Foreign State', 'Back Quarterly Payroll', 'Back Business Return', 'Back Personal Return', 'Non-Profit Bookkeeping', 'Non-Profit Back Bookkeeping'};
    public String newBundleType {get; set;}
    public Boolean hasActiveBTP {get; set;}
    public Boolean hasActivePTP {get; set;}
    public Boolean hasActiveNPTP {get; set;}
    public Boolean hasActiveAdvisory {get; set;}
    public Boolean hasActiveBundle {get; set;}
    public Map<String, String> productNameToId {get; set;}
    public String productNameToIdJSON {get{return JSON.serialize(productNameToId);} set;}
    public Map<String, List<String>> bundleToDefaultProductNames = new Map<String, List<String>>{
        'Core Accounting Package' => new List<String>{'Core Accounting Package','Business Tax Preparation', 'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP)' => new List<String>{'Core Accounting Package (Partner BTP)','Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review', 'Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP/BOI)' => new List<String>{'Core Accounting Package (Partner BTP/BOI)', 'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review'},
        'Core Accounting Package (Partner BTP/PTP/BOI)' => new List<String>{'Core Accounting Package (Partner BTP/PTP/BOI)', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review'},
        'Core Accounting Package (Partner BTPNS/BOI)' => new List<String>{'Core Accounting Package (Partner BTPNS/BOI)','Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review', 'Business Tax Preparation - State Only'},
        'Core Accounting Package (Non-Profit)' => new List<String>{'Core Accounting Package (Non-Profit)','Non-Profit Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'}
    };
    public String bundleToDefaultProductNamesJSON {get{return JSON.serialize(bundleToDefaultProductNames);}set;}
    public Decimal bundleDiscount {get; set;}
    public Decimal financingIncrease {get; set;}
    public Map<String, List<String>> bundleNameToFreeItems = new Map<String, List<String>>{
        'Core Accounting Package' => new List<String>{'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP)' => new List<String>{'Two-Year Review','Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP/BOI)' => new List<String>{'Two-Year Review'},
        'Core Accounting Package (Partner BTP/PTP/BOI)' => new List<String>{},
        'Core Accounting Package (Partner BTPNS/BOI)' => new List<String>{'Two-Year Review','Loan Agreement'},
        'Core Accounting Package (Non-Profit)' => new List<String>{'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'}
    };
    public String bundleNameToFreeItemsJSON {get{return JSON.serialize(bundleNameToFreeItems);}set;}

    public List<String> productsToHide {get{
        List<String> returnList = new List<String>(advisoryAddonProductNames);
        returnList.addAll(bundleNames); 
        return returnList;
    }set;}
    public String productsToHideJSON {get{return JSON.serialize(productsToHide);}set;}
    public List<String> dataIdsToHide {get{
        List<String> dataIds = new List<String>();
        for(String name : productsToHide){
            if(productNameToDataId.containsKey(name)){
                dataIds.add(productNameToDataId.get(name));
            }
        }
        return dataIds;
    }set;}
    public String dataIdsToHideJSON {get{return JSON.serialize(dataIdsToHide);}set;}

    public Map<String, String> calculatorIdToName = new Map<String,String>();

    public Map<String, String> productNameToDataId {get;set;}
    public String productNameToDataIdJSON {get{return JSON.serialize(productNameToDataId);}set;}

    public List<String> setupFeeItems {get; set;}
    
    public String setupFeeItemsJSON {get{return JSON.serialize(setupFeeItems);}set;}

    //Your wrapper 
    public class myWrapperClass{ 
        public String id {get;set;}
        public String name {get;set;}
        public Decimal price {get; set;} 
        public Decimal altPrice {get; set;} 
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
        public String fieldName2 {get;set;}
        public String fieldValue2 {get;set;}
        public String fieldOperator2 {get;set;}
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

    public List<String> bundleNames {
        get { return new List<String>{'Core Accounting Package','Core Accounting Package (Partner BTP)','Core Accounting Package (Partner BTP/BOI)','Core Accounting Package (Partner BTP/PTP/BOI)','Core Accounting Package (Partner BTPNS/BOI)', 'Core Accounting Package (Non-Profit)'};}
    }

    public string getEligibleBundle(){
        if(accountRecord != null && (accountRecord.Entity_Tax_Classification__c == 'Non-Profit' || accountRecord.Lead_Type_New__c == 'Non-Profit')){
            return 'Core Accounting Package (Non-Profit)';
        }
        if(entityTypeInput == 'Non-Profit'){
            return 'Core Accounting Package (Non-Profit)';
        }
        if(LeadSource == 'Tailor Brands'){
            if(LeadTypeNew.contains('BTPNS')){
                return 'Core Accounting Package (Partner BTPNS/BOI)';
            }
            if(hasActiveBTP){
                if(hasActivePTP){
                    return 'Core Accounting Package (Partner BTP/PTP/BOI)';
                } else {
                    return 'Core Accounting Package (Partner BTP/BOI)';
                }
            }
        } else if(LeadSource == 'ZenBusiness' && hasActiveBTP){
            return 'Core Accounting Package (Partner BTP)';
        }
        return 'Core Accounting Package';        
    }
    
    public List<String> advisoryAddonProductNames {get{
        if(LeadSource == 'Tailor Brands'){
            return new List<String>{'1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement'};
        } else {
            return new List<String>{'1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'};
        }        
    } set;}
    
    public String advisoryAddonsJSON {get{
        return JSON.serialize(advisoryAddonProductNames);
    } set;}
    

    public PricingCalcController(){
        financingIncrease = Dynamic_Pricing_Values__c.getValues('Financing increase')?.Percent_value__c;
        bundleDiscount = Dynamic_Pricing_Values__c.getValues('Bundle discount')?.Percent_value__c;
        if(bundleDiscount == null){
            bundleDiscount = 0.191;
        } else {
            bundleDiscount = bundleDiscount / 100.0;
        }
        productNameToId = new Map<String, String>();
    
        productNameToDataId = new Map<String, String>{
            'Tax Advisory' => 'a',
            'Business Tax Preparation' => 'b',
            'Personal Tax Preparation' => 'p',
            'Payroll' => 'pay',
            'Dedicated Bookkeeping' => 'bk',
            'LLC State Filing Fee' => 'sf',
            'Corp State Filing Fee' => 'sfc',
            'Back Bookkeeping' => 'bbk',
            'Foreign State' => 'fs',
            'Back Quarterly Payroll' => 'bpy',
            'Back Business Tax Preparation' => 'bb',
            'Back Personal Tax Preparation' => 'bp',
            'Non-Profit Bookkeeping' => 'npb',
            'Non-Profit Back Bookkeeping' => 'npbb'
        };
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
        nonProfitBackBookkeepingAdjustment = 0.00;
        
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
        nonProfitBackBookkeepingQuantity = 1;
        
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
        excludeNonProfitBackBookkeeping = false;
        
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
        disableQTYNonProfitBackBookkeeping = false;
        
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
        disableNonProfitBackBookkeeping = false;

        hasActiveAdvisory = false;
        hasActiveBTP = false;
        hasActivePTP = false;
        hasActiveNPTP = false;
        hasActiveBundle = false;
        
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
        disableNonProfitBackBookkeepingMessage = '';
        
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
        setupFeeItems = new List<String>();

        //String UserSalesSkill;
        //Boolean SellClientBooks;
        
        Boolean isBTPPrecheck = false;
        Boolean isPTPPrecheck = false;
        
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
        
        // checks to see if we need to lock the pricing calculator
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
        
        
        
        //String LeadSource = '';
        String Campaign = '';
        String StateOfFormationCheck = '';
        
        List<Account> ruleAccList = [SELECT Lead_Type_New__c, Lead_Source__c, Campaign__c, State_of_Formation__c FROM Account WHERE Id = :accountID];
        
        for (Account raItem : ruleAccList){
            if(raItem.Lead_Type_New__c == null) { raItem.Lead_Type_New__c = ''; }
            LeadTypeNew = raItem.Lead_Type_New__c;
            LeadSource = raItem.Lead_Source__c;
            Campaign = raItem.Campaign__c;
            StateOfFormationCheck = raItem.State_of_Formation__c;
        
        }

        if(LeadTypeNew.contains('BTP')){
            hasActiveBTP = true;
        }
        if(LeadTypeNew.contains('PTP')){
            hasActivePTP = true;
        }
        if(LeadTypeNew.contains('Advisory')){
            hasActiveAdvisory = true;
        }
        if(LeadTypeNew.contains('Non-Profit')){
            hasActiveNPTP = true;
        }

        // check for platform access
        List<Active_Subscriptions__c> activeSubList = [SELECT Id, Product__c, Subscription_Status__c, Name FROM Active_Subscriptions__c WHERE Account__c = :accountID];
        for (Active_Subscriptions__c aSubItem : activeSubList) {        
            if (aSubItem.Name == '1-800Accountant Access') {                
                hasPlatformAccess = (aSubItem.Subscription_Status__c == 'Active');                
            } else if(aSubItem.Name == 'Tax Advisory'){
                hasActiveAdvisory = (aSubItem.Subscription_Status__c == 'Active');
            } else if (aSubItem.Name == 'Personal Tax Preparation'){
                hasActivePTP = (aSubItem.Subscription_Status__c == 'Active');
            } else if (aSubItem.Name == 'Business Tax Preparation'){
                hasActiveBTP = (aSubItem.Subscription_Status__c == 'Active');
            } else if (aSubItem.Name.contains('Core Accounting Package') || aSubItem.Name.contains('Custom Accounting Package')){
                hasActiveBundle = (aSubItem.Subscription_Status__c == 'Active');
            } else if (aSubItem.Name == 'Non-Profit Tax Preparation'){
                hasActiveNPTP = (aSubItem.Subscription_Status__c == 'Active');
            }                 
        }

        if(!hasActiveBundle){
            if(getEligibleBundle() == 'Core Accounting Package (Non-Profit)'){ 
                hasActiveBundle = hasActiveAdvisory && hasActiveNPTP;
            } else { 
                hasActiveBundle = hasActiveAdvisory && hasActiveBTP && hasActivePTP; 
            }
        }

        for(List<String> prodList : bundleToDefaultProductNames.values()){
            if(hasActiveBTP && prodList.contains('Business Tax Preparation')){ prodList.remove(prodList.indexOf('Business Tax Preparation')); }
            if(hasActivePTP && prodList.contains('Personal Tax Preparation')){ prodList.remove(prodList.indexOf('Personal Tax Preparation')); }
            if(hasActiveNPTP && prodList.contains('Non-Profit Tax Preparation')){ prodList.remove(prodList.indexOf('Non-Profit Tax Preparation')); }
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
        
        leadSourceInput = LeadSource;
        leadTypeInput = LeadTypeNew;
        newBundleType = getEligibleBundle();
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
        
        List<String> defaultProductIDList = new List<String>();
        
        Map<String, String> productMessages = new Map<String, String>(); 
        Boolean doThisRule = false;
        Boolean tempRuleCheck = false;
        
        // get products to exclude by user and account details
        List<Calculator_Rule__c> ruleList = [SELECT Action__c, Criteria_Field_1__c, Criteria_Field_2__c, Criteria_Object__c, Field_1_Operator__c, Field_1_Value__c, Field_2_Operator__c, Field_2_Value__c, Message__c, Product__c, Amount__c, Environment__c, Calculator_Offer__c, Price_Adjustment_Percent__c FROM Calculator_Rule__c WHERE (Criteria_Object__c = 'User' OR Criteria_Object__c = 'Account' OR Criteria_Object__c = 'Form') AND Active__c = true];
        for (Calculator_Rule__c ruleItem : ruleList){
            System.debug(ruleItem);
            doThisRule = false;
            
            if (ruleItem.Criteria_Object__c == 'Form') {
                
                dynamicRuleClass tempDRC = new dynamicRuleClass();
                
                tempDRC.productId = ruleItem.Product__c;
                tempDRC.fieldName = ruleItem.Criteria_Field_1__c;
                tempDRC.fieldValue = ruleItem.Field_1_Value__c;
                tempDRC.fieldOperator = ruleItem.Field_1_Operator__c;
                tempDRC.fieldName2 = ruleItem.Criteria_Field_2__c;
                tempDRC.fieldValue2 = ruleItem.Field_2_Value__c;
                tempDRC.fieldOperator2 = ruleItem.Field_2_Operator__c;
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
                System.debug(StateOfFormationCheck);
                if (ruleItem.Criteria_Field_1__c == 'Lead_Type_New__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Contains String') {
                        
                        if (LeadTypeNew.contains(ruleItem.Field_1_Value__c)) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                    
                    if (ruleItem.Field_1_Operator__c == 'Does Not Contain String') {
                        
                        if (LeadTypeNew.contains(ruleItem.Field_1_Value__c)) {
                        
                            
                            
                        } else {
                        
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
                    
                    if (ruleItem.Field_1_Operator__c == 'Not Equal String') {
                        
                        if (LeadSource == ruleItem.Field_1_Value__c) {
                        
                            
                            
                        } else {
                        
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
                
                } else if (ruleItem.Criteria_Field_1__c == 'State_of_Formation__c') {
                
                    if (ruleItem.Field_1_Operator__c == 'Equal String') {
                        
                        if (StateOfFormationCheck == ruleItem.Field_1_Value__c) {
                        
                            doThisRule = true;
                            
                        }
                        
                    }
                    
                    if (ruleItem.Field_1_Operator__c == 'Not Equal String') {
                        
                        if (StateOfFormationCheck == ruleItem.Field_1_Value__c) {
                        
                            
                            
                        } else {
                        
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
                    
                    if (ruleItem.Field_2_Operator__c == 'Does Not Contain String') {
                        
                        if (LeadTypeNew.contains(ruleItem.Field_2_Value__c)) {
                        
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
                    
                    if (ruleItem.Field_2_Operator__c == 'Not Equal String') {
                        
                        if (LeadSource == ruleItem.Field_2_Value__c) {
                        
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
                
                } else if (ruleItem.Criteria_Field_2__c == 'State_of_Formation__c') {
                
                    if (ruleItem.Field_2_Operator__c == 'Equal String') {
                        
                        if (StateOfFormationCheck == ruleItem.Field_2_Value__c) {
                        
                        } else {
                        
                            doThisRule = false;
                            
                        }
                        
                    }
                    
                    if (ruleItem.Field_2_Operator__c == 'Not Equal String') {
                        
                        if (StateOfFormationCheck == ruleItem.Field_2_Value__c) {
                        
                            doThisRule = false;
                        
                        } 
                        
                    }
                
                }
                
            }
            
            if (doThisRule == true) {
            	System.debug('^doThisRule');
                if (ruleItem.Action__c == 'Environment Whitelist') {
                    environment = ruleItem.Environment__c;
                }
                
                if (ruleItem.Action__c == 'Remove Product' && UserSalesSkill.contains('Calculator Override') == false) {
                    System.debug('removing '+ruleItem.Product__c);
                    excludeProductList.add(ruleItem.Product__c);
                    
                }
                
                if (ruleItem.Action__c == 'Remove Offer' && UserSalesSkill.contains('Calculator Override') == false) {
                    
                    excludeOfferList.add(ruleItem.Calculator_Offer__c);
                    
                }
                
                if (ruleItem.Action__c == 'Default Product') {
                
                    //defaultProductIDList.add(ruleItem.Product__c);
                
                }
                
                if (ruleItem.Action__c == 'Disable Product' && UserSalesSkill.contains('Calculator Override') == false) {
                    
                    disableProductList.add(ruleItem.Product__c);
                    System.debug('disabling '+ruleItem.Product__c);
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
            
            // System.debug(overrideList.size());
            // System.debug(adjustPriceList.size());
        }
        
        

        System.debug(excludeProductList);
        // default class data
        entityTypeClass = '';
        industryTypeClass = '';
        numberOfEmployeesClass = '';
        numberOfOwnersClass = '';
        numberOfTransactionsClass = '';
        numberOfRentalPropertiesClass = '';
        personalIncomeClass = '';
        projectedFirstYearProfitClass = '';
        projectedFirstYearRevenueClass = '';
        totalStartupCostClass = '';
        runPayrollBeforeClass = '';
        filingStatusClass = '';
        businessMilesClass = '';
        officeSqFtClass = '';
        foreignStateClass = '';
        stateOfIncorporationClass = '';
        bookKeepingStartDateClass = '';
        bookKeepingEndDateClass = '';
        
        List<Calculator_Field__c> myFieldList = [SELECT Id, Name, Required_In_Environment__c FROM Calculator_Field__c];
        for(Calculator_Field__c fieldItem : myFieldList){
        
            if (fieldItem.Required_In_Environment__c  != null && fieldItem.Required_In_Environment__c.contains(environment)) {
            
                if (fieldItem.Name == 'Entity Type') {
                    entityTypeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Industry Type') {
                    industryTypeClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Number of Employees') {
                    numberOfEmployeesClass = ' jq_req1';
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
                
                if (fieldItem.Name == 'Total Startup Cost') {
                    totalStartupCostClass = ' jq_req1';
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
                
                if (fieldItem.Name == 'Bookkeeping Start Date') {
                    bookKeepingStartDateClass = ' jq_req1';
                }
                
                if (fieldItem.Name == 'Bookkeeping End Date') {
                    bookKeepingEndDateClass = ' jq_req1';
                }
                
            
            }
        
            //standardPriceBookID = pbItem.Id;
        } 
        
        // create master product list
        
        
        if (LeadTypeNew.contains('BTP')) {
            isBTPPrecheck = true;       
        }
        if (LeadTypeNew.contains('PTP')) {
            isPTPPrecheck = true;       
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
            List<Product2> productList = [SELECT Id, Calculator_Location__c, Name, Bundles__c, AnnualMonthlyOption__c, RevenueInstallmentPeriod, Disable_QTY_on_Calc__c, Sort_Order__c, Setup_Fee__c, No_Split_Allowed__c FROM Product2 WHERE Environment__c INCLUDES (:environment) AND Calculator_Location__c IN :productsToQuery];
            
            List<PricebookEntry> pbACList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id, Dynamic__c FROM PricebookEntry WHERE Pricebook2Id = :standardPriceBookID];
                
            for(PricebookEntry pbACItem : pbACList){
            
                for(Product2 pItem : productList){
                    productNameToId.put(pItem.Name, pItem.Id);
                    if(!productNameToDataId.containsKey(pItem.Name)){productNameToDataId.put(pItem.Name, pItem.Id);}
                    calculatorIdToName.put(pItem.Calculator_Location__c, pItem.Name);
                    if (pbACItem.Product2Id == pItem.Id && pbACItem.Dynamic__c == false) { 
                        priceOverrideWrapper orPrice = new priceOverrideWrapper();
                    
                        orPrice.productId = pItem.Id;
                        orPrice.amount = pbACItem.UnitPrice; 
                        orPrice.productPostion = pItem.Calculator_Location__c; 
                        overrideList.add(orPrice); 
                    }
                    if(!setupFeeItems.contains(pItem.Calculator_Location__c) && pItem.Setup_Fee__c != null){ setupFeeItems.add(pItem.Calculator_Location__c); setupFeeItems.add(pItem.Name); }

                    
                }
            
            }
            System.debug('calculatorIdToName: ');
            for(String calcId : calculatorIdToName.keySet()){
                System.debug(calcId + ': ' + calculatorIdToName.get(calcId));
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
                    
                    // query products for offers
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
                                
                                if (pItem.Calculator_Location__c == 'Non-Profit Back Bookkeeping') {
        
                                    mcProduct.calcId = 'npbbcheck';
        
                                }
                                
                            }
                            
                        }
    
                        offerProductList.add(mcProduct);
                        
                    }
                    
                    bundleItems.add(new SelectOption(offerItem.Id,offerItem.Name));
                    
                    showBundles = true;
                
                }
                
            } 
            System.debug(offerProductList.size());
        
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
            industryType = new List<SelectOption>();
            numberOfEmployees = new List<SelectOption>();
            
            List<String> entType = new List<String>();
            List<String> forOwn = new List<String>();
            List<String> indType = new List<String>();
            List<String> livAbroad = new List<String>();
            List<String> numCont = new List<String>();
            List<String> numEmp = new List<String>();
            List<String> stateList = new List<String>();
            List<String> numTrans = new List<String>();
            
            List<String> numberOfOwnersMatch = new List<String>();
            List<String> numberOfRentalPropertiesMatch = new List<String>();
            List<String> personalIncomeMatch = new List<String>();
            List<String> projectedFirstYearProfitMatch = new List<String>();
            List<String> projectedFirstYearRevenueMatch = new List<String>();
            List<String> totalStartupCostMatch = new List<String>();
            List<String> runPayrollBeforeMatch = new List<String>();
            List<String> filingStatusMatch = new List<String>();
            List<String> businessMilesMatch = new List<String>();
            List<String> officeSqFtMatch = new List<String>();
            List<String> foreignStateMatch = new List<String>();
            
            numberOfOwners = new List<SelectOption>();
            numberOfTransactions = new List<SelectOption>();
            numberOfRentalProperties = new List<SelectOption>();
            personalIncome = new List<SelectOption>();
            projectedFirstYearProfit = new List<SelectOption>();
            projectedFirstYearRevenue = new List<SelectOption>();
            totalStartupCost = new List<SelectOption>();
            billingStateItems = new List<SelectOption>();
            billingCountryItems = new List<SelectOption>();
            runPayrollBefore = new List<SelectOption>();
            filingStatus = new List<SelectOption>();
            businessMiles = new List<SelectOption>();
            officeSqFt = new List<SelectOption>();
            foreignState = new List<SelectOption>();
            stateOfIncorporation = new List<SelectOption>();
            
            // placeholder variables
            Decimal formatInput = 0;
            String formatOutput = '';
            String shortState = '';
            
            adjustList = new List<priceWrapper>();
            
            industryType.add(new SelectOption('','--'));
            totalStartupCost.add(new SelectOption('','--'));
            projectedFirstYearRevenue.add(new SelectOption('','--'));
            filingStatus.add(new SelectOption('','--'));
            businessMiles.add(new SelectOption('','--'));
            officeSqFt.add(new SelectOption('','--'));
            foreignState.add(new SelectOption('','--'));
            stateOfIncorporation.add(new SelectOption('','--'));
            
            // get dropdown values from custom object
            List<Calculator_Dropdown__c> dropList;
            if(Test.isRunningTest()){
                dropList = [SELECT Id, Dropdown_Value__c, Form_Field__c, Price_Adjustment__c, Product__c, Setup_fee__c FROM Calculator_Dropdown__c ORDER BY Sort__c LIMIT 20];
            } else {
                dropList = [SELECT Id, Dropdown_Value__c, Form_Field__c, Price_Adjustment__c, Product__c, Setup_fee__c FROM Calculator_Dropdown__c ORDER BY Sort__c];
            }
            System.debug(dropList);
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
                
                if (dropItem.Form_Field__c == 'Industry Type' && !indType.contains(dropItem.Dropdown_Value__c)) {
                    indType.add(dropItem.Dropdown_Value__c);
                    industryType.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'IndustryType';
                } else if(dropItem.Form_Field__c == 'Industry Type') {
                    wrapPrice.field = 'IndustryType';
                }
                
                if (dropItem.Form_Field__c == 'Number of Employees' && !numEmp.contains(dropItem.Dropdown_Value__c)) {
                    numEmp.add(dropItem.Dropdown_Value__c);
                    numberOfEmployees.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'NumberOfEmployees';
                } else if(dropItem.Form_Field__c == 'Number of Employees') {
                    wrapPrice.field = 'NumberOfEmployees';
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
                
                    stateOfIncorporation.add(new SelectOption(dropItem.Dropdown_Value__c,dropItem.Dropdown_Value__c));
                    wrapPrice.field = 'StateOfIncorporation';
                } else if(dropItem.Form_Field__c == 'State of Incorporation') {
                    wrapPrice.field = 'StateOfIncorporation';
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
                
                adjustList.add(wrapPrice);
                
            }
            System.debug(adjustList);
            
            // add billing state items
            //shortState = changeStateToAbbrev(dropItem.Dropdown_Value__c);
            billingStateItems.add(new SelectOption('',''));
            
            // populate country list
            List<String> countryList = new List<String>{'', 'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Anguilla', 'Antigua', 'Argentina', 'Armenia', 'Aruba', 'Ascension Island', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Barbuda', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Canasa', 'Cape Verde Islands', 'Cayman Islands', 'Central African Republic', 'Chad', 'Chile', 'China', 'Christmas Island', 'Cocos-Keeling Islands', 'Colombia', 'Comoros', 'Congo', 'Cook Islands', 'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Diego Garcia', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'England', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Ethiopia', 'Faeroe Islands', 'Falkland Islands', 'Fiji Islands', 'Finland', 'France', 'French Antilles', 'French Guiana', 'French Polynesia', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Gibraltar', 'Ginea-Bissau', 'Greece', 'Greenland', 'Grenada', 'Guadeloupe', 'Guam', 'Guantanamo Bay', 'Guatemala', 'Guinea', 'Guyana', 'Haiti', 'Hamilton', 'Honduras', 'Hong Kong', 'Hungary', 'Iceland', 'India', 'Indonesia ', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Ivory Coast', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati Republic', 'Korea North', 'Korea South', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macao', 'Macedonia', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Martinique', 'Mauritania', 'Mauritius', 'Mayotte Island', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montserrat', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'Nevis', 'New Caledonia', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'Norway', 'Oman', 'Pakistan', 'Palau ', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Principe', 'Puerto Rico', 'Qatar', 'Reunion Island', 'Romania', 'Rota Island', 'Russia', 'Rwanda', 'Saint Lucia', 'Saipan Islands', 'San Marino', 'Sao Tome', 'Saudi Arabia', 'Senegal Republic', 'Serbia (Republic of)', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovak Republic', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Togo', 'Tokelau', 'Tonga', 'Trinidad and Tabago', 'Tunisia', 'Turkey', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican city', 'Venezuela', 'Vietnam', 'Virgin Islands', 'Western Somoa', 'Yemen', 'Yugoslavia', 'Zaire', 'Zambia', 'Zimbabwe'};
            for(String country : countryList){
                billingCountryItems.add(new SelectOption(country, country));
            }
                        
            // sort seperately by product
            
            // prepare data for view - sort
            //entityType.sort();
            //industryType.sort();
            //numberOfEmployees.sort();
            //numberOfOwners.sort();
            //numberOfRentalProperties.sort();
            //personalIncome.sort();
            //projectedFirstYearProfit.sort();
            //projectedFirstYearRevenue.sort();
            billingStateItems.sort();
            billingCountryItems.sort();
            //totalStartupCost.sort();
            stateOfIncorporation.sort();
            foreignState.sort();
            
            // set defaults
            numberOfOwnersInput = '1';
            numberOfEmployeesInput = '1';
            billingTime = 'yrl';
            runPayrollBeforeInput = 'No';
            businessMilesInput = '10000';
            officeSqFtInput = '300';
            bookKeepingStartDateInput = '';
            bookKeepingEndDateInput = '';
            
            // get defaults from account
            List <Account> accList = [SELECT Industry, Lead_Type_New__c, Expected_1st_year_revenue__c, Entity_Tax_Classification__c, Total_Startup_Costs__c, NumberOfEmployees, Number_of_owners__c, Trans_Per_Month__c, Personal_Income__c, Rental_Properties__c, Name, BillingState, BillingStreet, BillingCity, BillingPostalCode, BillingCountry, Personal_Return_Filing_Status__c, Current_Year_Profit_Projection__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c, State_of_Residence__c, State_of_Formation__c, Foreign_State__c FROM Account WHERE Id = :accountID];
            for (Account accItem : accList){
                accountRecord = accItem;
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
                
                accountNameInput = accItem.Name;
                billingStateInput = accItem.BillingState;
                
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
                List<Quote> quoteList = [SELECT Id, Calc_Entity_Type__c, Calc_Industry_Type__c, Calc_Number_of_Employees__c, Calc_Number_of_Owners__c, Calc_Number_of_Rental_Properties__c, Calc_Number_of_Transactions__c, Calc_Personal_Income__c, Calc_Projected_1st_Year_Profit__c, Calc_Projected_1st_Year_Revenue__c, Calc_Total_Startup_Cost__c, Calc_Run_Payroll_Before__c, OpportunityId, AccountId, billingSchedule__c, Bundle__c, Calc_Filing_Status__c, Calc_Business_Miles__c, Calc_Office_Square_Footage__c, Calc_State_of_Incorporation__c, Calc_Foreign_State__c, Calc_Bookkeeping_Start_Date__c, Calc_Bookkeeping_End_Date__c FROM Quote WHERE Id = :quoteID];
                
                for(Quote quoteItem : quoteList){
                
                    opportunityID = quoteItem.OpportunityId;
                    accountID = quoteItem.AccountId;
                    entityTypeInput = quoteItem.Calc_Entity_Type__c;
                    industryTypeInput = quoteItem.Calc_Industry_Type__c;
                    numberOfEmployeesInput = quoteItem.Calc_Number_of_Employees__c;
                    numberOfOwnersInput = quoteItem.Calc_Number_of_Owners__c;
                    numberOfTransactionsInput = quoteItem.Calc_Number_of_Transactions__c;
                    numberOfRentalPropertiesInput = quoteItem.Calc_Number_of_Rental_Properties__c;
                    personalIncomeInput = quoteItem.Calc_Personal_Income__c;
                    projectedFirstYearProfitInput = quoteItem.Calc_Projected_1st_Year_Profit__c;
                    projectedFirstYearRevenueInput = quoteItem.Calc_Projected_1st_Year_Revenue__c;
                    stateOfIncorporationInput = quoteItem.Calc_State_of_Incorporation__c;
                    totalStartupCostInput = quoteItem.Calc_Total_Startup_Cost__c;
                    runPayrollBeforeInput = quoteItem.Calc_Run_Payroll_Before__c;
                    filingStatusInput = quoteItem.Calc_Filing_Status__c;
                    businessMilesInput = quoteItem.Calc_Business_Miles__c;
                    officeSqFtInput = quoteItem.Calc_Office_Square_Footage__c;
                    foreignStateInput = quoteItem.Calc_Foreign_State__c;
                    bookKeepingStartDateInput = quoteItem.Calc_Bookkeeping_Start_Date__c;
                    bookKeepingEndDateInput = quoteItem.Calc_Bookkeeping_End_Date__c;
                    
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
            
            String bundleName = getEligibleBundle();
            System.debug(bundleName);
           
            
            for(Product2 acItem : acListP){
                productNameToId.put(acItem.Name, acItem.Id);         
                if(!productNameToDataId.containsKey(acItem.Name)){productNameToDataId.put(acItem.Name, acItem.Id);}
                //if(bundleNames.contains(acItem.Name) && acItem.Name != bundleName) {excludeProductList.add(acItem.Id);}   
                //if(bundleNames.contains(acItem.Name)) {excludeProductList.add(acItem.Id);}   

                // exclude products based upon rules
                if (excludeProductList.contains(acItem.Id)) {
                    System.debug('excluding '+acItem.Name);
                } else {
                    System.debug('not excluding '+acItem.Name);
                    acListProducts.add(acItem);
                
                }
            
            }

            
            //List<PricebookEntry> pbACList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id FROM PricebookEntry WHERE Pricebook2Id = :standardPriceBookID];
                
            //controller price calculation of a la cart items
            for(Product2 acItem : acListProducts){
                
                for(PricebookEntry pbACItem : pbACList){
                    
                    if (pbACItem.Product2Id == acItem.Id) {
                        
                        // check to see if billing schedule is monthly, and if so multiply amount x 12 to set annual $
            
                        myWrapperClass wrapRec = new myWrapperClass();
                        
                        wrapRec.id = acItem.Id;
                        wrapRec.name = acItem.Name;
                        wrapRec.price = pbACItem.UnitPrice;
                        wrapRec.altPrice = (pbACItem.UnitPrice);// * (1-bundleDiscount).setScale(2);
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
                        
                        // if (acItem.Id == '01tf1000003JjrwAAC') {
                        //     wrapRec.altPrice = 329.89;
                        //     wrapRec.price = 439.89;
                        // }
                        
                        // check for price override
                        for(priceOverrideWrapper powItem : overrideList){
                    
                            if (powItem.productPostion == 'A La Carte' && powItem.productId == acItem.Id) {
                            
                                wrapRec.price = powItem.amount;
                                wrapRec.altPrice = powItem.amount;
                                
                            }
                            
                        }
                        
                        // check for price adjustment
                        for(priceAdjustmentWrapper padjItem : adjustPriceList){
                        
                            if (padjItem.productPostion == 'A La Carte' && padjItem.productId == acItem.Id) {
                            
                                // first increment price based on amount which defaults to zero so no negative effect when not used
                                wrapRec.price = wrapRec.price + padjItem.amount;
                                
                                // then increment price based on percent which defaults to 1 so not negative effect when not used
                                wrapRec.price = wrapRec.price * padjItem.percent;
                                
                                wrapRec.altPrice = wrapRec.price;
                                
                                //online access
                                if (acItem.Id == '01tf1000003JjrwAAC') {
                                    // first increment price based on amount which defaults to zero so no negative effect when not used
                                    wrapRec.altPrice = 329.89 + padjItem.amount;
                                
                                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                                    wrapRec.altPrice = wrapRec.altPrice * padjItem.percent;
                                }
                                 
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
                        if (defaultProductIDList.contains(acItem.Id)) {
                            wrapRec.doIt = true;
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
                        
                        System.debug('adding: '+wrapRec.name);
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
            nonProfitBackBookkeepingID = '';
            
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
            nonProfitBackBookkeepingNoSplit = false;
            
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
                
                if (pItem.Calculator_Location__c == 'Non-Profit Back Bookkeeping') {
                
                    nonProfitBackBookkeepingID = pItem.Id;
                    bundleWrapperClass bundleRec = new bundleWrapperClass();
                    
                    bundleRec.id = pItem.Id;
                    bundleRec.calcid = 'npbbcheck';
                    bundleRec.bundlelist = pItem.Bundles__c;
                    
                    bundleProductList.add(bundleRec);
                    
                    optionNonProfitBackBookkeeping = pItem.AnnualMonthlyOption__c;
                    
                    nonProfitBackBookkeepingTime = pItem.RevenueInstallmentPeriod;
                    nonProfitBackBookkeepingTimeDef = pItem.RevenueInstallmentPeriod;
                    
                    if (pItem.Sort_Order__c == NULL) {
                        nonProfitBackBookkeepingSort = 4;
                    } else {
                        nonProfitBackBookkeepingSort = pItem.Sort_Order__c;
                    }
                    
                    if (excludeProductList.contains(pItem.Id)) {
                    
                        excludeNonProfitBackBookkeeping = true;
                        
                    }
                    
                    if (disableProductList.contains(pItem.Id)) {
                    
                        disableNonProfitBackBookkeeping = true;
                        
                        disableNonProfitBackBookkeepingMessage = productMessages.get(pItem.Id);
                        
                    }
                    
                    disableQTYNonProfitBackBookkeeping = pItem.Disable_QTY_on_Calc__c;
                    
                    nonProfitBackBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                    
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
                
                if (nonProfitBackBookkeepingID != '' && eItem.Product2Id == nonProfitBackBookkeepingID) {
                    doNonProfitBackBookkeeping = true;
                    nonProfitBackBookkeepingQuantity = integer.valueOf(eItem.Quantity);
                    
                    prevSel = true;
                }
                doNonProfitReturn = false;
                for(myWrapperClass acItem : acList){
                
                    if (eItem.Product2Id == acItem.id) {
                        acItem.doIt = true;// check for existing products and mark them as selected
                        acItem.quantity = integer.valueOf(eItem.Quantity);
                        if(acItem.name == 'Non-Profit Tax Preparation') { doNonProfitReturn = true; }
                        prevSel = true;
                    }
                
                }
                
            }
            
            // if we aren't prepopulating from a previous attempt, then set default selections
            if (prevSel == false) {
                isBTPPrecheck = hasActiveBTP;
                isPTPPrecheck = hasActivePTP;
                doBusinessReturn = doPersonalReturn = true;
                //if(isBTPPrecheck || entityTypeInput == 'Non-Profit') {doBusinessReturn = false;}
                //if(isPTPPrecheck) {doPersonalReturn = false;}
                
                //if(newBundleType != 'Core Accounting Package') {doBusinessReturn = false;}
                //if(newBundleType == 'Core Accounting Package (Partner BTP/PTP/BOI)') {doPersonalReturn = false;}
				if(hasActiveBTP) {doBusinessReturn = false;}
                if(hasActivePTP) {doPersonalReturn = false;}
                doAdvisory = true;
                doNonProfitReturn = false;
                List<String> defaultProductNames = bundleToDefaultProductNames.get(getEligibleBundle());
                System.debug('defaultProductNames:');
                System.debug(defaultProductNames);
                for(myWrapperClass acItem : acList){
                    if(defaultProductNames.contains(acItem.name)){
                        acItem.doIt = true;
                        if(acItem.name == 'Non-Profit Tax Preparation') { doNonProfitReturn = true; }

                        acItem.quantity = 1;
                    }
                }

                // if (isBTPPrecheck) {
                
                //     //doPersonalReturn = true;
                //     doAdvisory = true;
                    
                //     for(myWrapperClass acItem : acList){
                        
                //         // 1800accountant access
                //         if ('01tf1000003JjrwAAC' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         //audit defense business
                //         if ('01tf1000003JjrgAAC' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         //audit defense personal
                //         if ('01tf1000003JjrfAAC' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         //two year review
                //         if ('01tf1000003JjrhAAC' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         if ('01tj0000000LLamAAG' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }                    
                //     }                
                // } else {
                
                //     // if (entityTypeInput == 'Non-Profit') {
                //     //     doBusinessReturn = false;
                //     // } else {
                //     //     doBusinessReturn = true;
                //     // }
                    
                //     if (entityTypeInput == 'S Corporation') {
                //         doPayroll = true;
                //     }
                    
                //     //doPersonalReturn = true;
                //     doAdvisory = true;
                    
                //     for(myWrapperClass acItem : acList){
                        
                //         // 1800accountant access
                //         if ('01tf1000003JjrwAAC' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         // loan agreement
                //         if ('01tj0000000LLamAAG' == acItem.id) {
                //             acItem.doIt = true;
                //             acItem.quantity = 1;
                //         }
                        
                //         if (entityTypeInput == 'Non-Profit') {
                //             // non profit
                //             if ('01tf1000003JjruAAC' == acItem.id) {
                //                 acItem.doIt = true;
                //                 acItem.quantity = 1;
                //             }
                //         } 
                    
                //     }
                // } 
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
            
            if (excludeNonProfitBackBookkeeping == true || nonProfitBackBookkeepingID == '') {
            
                doNonProfitBackBookkeeping = false;
                excludeNonProfitBackBookkeeping = true;
                
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
            
            if (disableNonProfitBackBookkeeping == true) {
            
                doNonProfitBackBookkeeping = false;
                
            }
            
            for(myWrapperClass acItem : acList){
                
                if (acItem.disableProduct) {
                
                    acItem.doIt = false;
                    if(acItem.name == 'Non-Profit Tax Preparation') { doNonProfitReturn = false; }

                    
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

        
        String bundleName = useBundlePricing() ? getEligibleBundle() : 'Core Accounting Package';
        List<String> freeItems = bundleNameToFreeItems.get(bundleName);
        List<String> defaultItems = bundleToDefaultProductNames.get(bundleName);
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
        nonProfitBackBookkeepingAdjustment = 0.00;
        
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
            
            if (powItem.productPostion == 'Non-Profit Back Bookkeeping') {
                nonProfitBackBookkeepingAdjustment = powItem.amount;
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
        nonProfitBackBookkeepingFee = 0.00;
        
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
        
            businessAdjustment = getDynamicAmount('Business Return', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (personalAdjustment > 0) {
        
        } else {
        
            personalAdjustment = getDynamicAmount('Personal Return', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (payrollAdjustment > 0) {
        
        } else {
        
            payrollAdjustment = getDynamicAmount('Payroll', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (bookkeepingAdjustment > 0) {
        
        } else {
        
            bookkeepingAdjustment = getDynamicAmount('Bookkeeping', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (stateFilingAdjustment > 0) {
        
        } else {
        
            stateFilingAdjustment = getDynamicAmount('LLC State Filing', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (stateFilingCorpAdjustment > 0) {
        
        } else {
        
            stateFilingCorpAdjustment = getDynamicAmount('Corp State Filing', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (backBookkeepingAdjustment > 0) {
        
        } else {
        
            backBookkeepingAdjustment = getDynamicAmount('Back Bookkeeping', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (foreignStateAdjustment > 0) {
        
        } else {
        
            foreignStateAdjustment = getDynamicAmount('Foreign State', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (backPayrollAdjustment > 0) {
        
        } else {
        
            backPayrollAdjustment = getDynamicAmount('Back Quarterly Payroll', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (backBusinessAdjustment > 0) {
        
        } else {
        
            backBusinessAdjustment = getDynamicAmount('Back Business Return', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (backPersonalAdjustment > 0) {
        
        } else {
        
            backPersonalAdjustment = getDynamicAmount('Back Personal Return', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (nonProfitBookkeepingAdjustment > 0) {
        
        } else {
        
            nonProfitBookkeepingAdjustment = getDynamicAmount('Non-Profit Bookkeeping', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        }
        
        if (nonProfitBackBookkeepingAdjustment > 0) {
        
        } else {
        
            nonProfitBackBookkeepingAdjustment = getDynamicAmount('Non-Profit Back Bookkeeping', entityTypeInput, industryTypeInput, numberOfEmployeesInput, numberOfOwnersInput, numberOfRentalPropertiesInput, personalIncomeInput, projectedFirstYearProfitInput, projectedFirstYearRevenueInput, stateOfIncorporationInput, totalStartupCostInput, numberOfTransactionsInput, filingStatusInput, businessMilesInput, officeSqFtInput, foreignStateInput); 
        } 
        // todo - mark checkboxes where product was added if we are editing a quote
            
        
        // now tax advisory calculation
        if (taxAdvisoryPrice > 0) {
        
        } else {
            taxAdvisoryPrice = ((businessAdjustment + personalAdjustment) / (949 + 399)) * 1569;  
            System.debug('advisory base price: '+taxAdvisoryPrice);
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
                    System.debug('adjusted advisory price: '+taxAdvisoryPrice);
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
                when 'Non-Profit Back Bookkeeping' {
                    
                    // first increment price based on amount which defaults to zero so no negative effect when not used
                    nonProfitBackBookkeepingAdjustment = nonProfitBackBookkeepingAdjustment + padjItem.amount;
                    
                    // then increment price based on percent which defaults to 1 so not negative effect when not used
                    nonProfitBackBookkeepingAdjustment = nonProfitBackBookkeepingAdjustment * padjItem.percent;
                    
                    // since we are doing multiplication on a float lets set our decimal precision for currency
                    nonProfitBackBookkeepingAdjustment = nonProfitBackBookkeepingAdjustment.setScale(2);
                    
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
        nonProfitBackBookkeepingID = '';
        
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
        Boolean nonProfitBackBookkeepingOT = false;
        
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
        nonProfitBackBookkeepingNoSplit = false;
        
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
        String nonProfitBackBookkeepingDesc = '';
        String nonProfitBackBookkeepingHTMLDesc = '';
        
        //setupFeeItems = new List<String>();
        
        // check for existing products and mark them as selected
        List<Product2> productList = [SELECT Id, Calculator_Location__c, Name, AnnualMonthlyOption__c, Billing_Frequency__c, HTML_Description__c, Description, No_Split_Allowed__c FROM Product2 WHERE Calculator_Location__c IN :productsToQuery];
        
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
                bookkeepingDesc = bookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions per month.'; 
                bookkeepingHTMLDesc = bookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions per month.'; 
                
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
                backBookkeepingDesc = backBookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions per month.'; 
                backBookkeepingHTMLDesc = backBookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions per month.'; 
                
                // append description with start date
                backBookkeepingDesc = backBookkeepingDesc + ' Back Bookkeeping services will cover the period beginning ' + bookKeepingStartDateInput + ' and ending ' + bookKeepingEndDateInput; 
                backBookkeepingHTMLDesc = backBookkeepingHTMLDesc + ' Back Bookkeeping services will cover the period beginning ' + bookKeepingStartDateInput + ' and ending ' + bookKeepingEndDateInput; 
                
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
                nonProfitBookkeepingDesc = nonProfitBookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions per month.'; 
                nonProfitBookkeepingHTMLDesc = nonProfitBookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions per month.'; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    nonProfitBookkeepingOT = true;
                    
                }
                
                nonProfitBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                
            }
            
            if (pItem.Calculator_Location__c == 'Non-Profit Back Bookkeeping') {
            
                nonProfitBackBookkeepingID = pItem.Id;
                nonProfitBackBookkeepingDesc = pItem.Description;
                nonProfitBackBookkeepingHTMLDesc = pItem.HTML_Description__c;
                
                // append description with number of employees
                nonProfitBackBookkeepingDesc = nonProfitBackBookkeepingDesc + ' For ' + numberOfTransactionsInput + ' transactions per month.'; 
                nonProfitBackBookkeepingHTMLDesc = nonProfitBackBookkeepingHTMLDesc + ' For  ' + numberOfTransactionsInput + ' transactions per month.'; 
                
                // append description with start date
                nonProfitBackBookkeepingDesc = nonProfitBackBookkeepingDesc + ' Back Bookkeeping services will cover the period beginning ' + bookKeepingStartDateInput + ' and ending ' + bookKeepingEndDateInput; 
                nonProfitBackBookkeepingHTMLDesc = nonProfitBackBookkeepingHTMLDesc + ' Back Bookkeeping services will cover the period beginning ' + bookKeepingStartDateInput + ' and ending ' + bookKeepingEndDateInput; 
                
                if (pItem.Billing_Frequency__c == 'One-Time') {
                
                    nonProfitBackBookkeepingOT = true;
                    
                }
                
                nonProfitBackBookkeepingNoSplit = pItem.No_Split_Allowed__c;
                
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
        String priceBookNonProfitBackBookkeepingID = '';
        
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
        String nonProfitBackBookkeepingPBEID = '';
        
        // check for price book entry, add if necessary
        List<PricebookEntry> pbAllList = [SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id FROM PricebookEntry WHERE (Product2Id = :bizTaxPrepID OR Product2Id = :personalTaxPrepID OR Product2Id = :payrollID OR Product2Id = :taxAdvisoryID OR Product2Id = :bookkeepingID OR Product2Id = :stateFilingID OR Product2Id = :stateFilingCorpID OR Product2Id = :backBookkeepingID OR Product2Id = :foreignStateID OR Product2Id = :backPayrollID OR Product2Id = :backBusinessID OR Product2Id = :backPersonalID OR Product2Id = :nonProfitBookkeepingID OR Product2Id = :nonProfitBackBookkeepingID) AND Pricebook2Id = :standardPriceBookID];
        
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
            } else if (pbAllItem.Product2Id == nonProfitBackBookkeepingID) {
                nonProfitBackBookkeepingPBEID = pbAllItem.Id;
                priceBookNonProfitBackBookkeepingID = pbAllItem.Pricebook2Id;
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
                Calc_Industry_Type__c = industryTypeInput,
                Calc_Number_of_Employees__c = numberOfEmployeesInput,
                Calc_Number_of_Owners__c = numberOfOwnersInput,
                Calc_Number_of_Transactions__c = numberOfTransactionsInput,
                Calc_Number_of_Rental_Properties__c = numberOfRentalPropertiesInput,
                Calc_Personal_Income__c = personalIncomeInput,
                Calc_Projected_1st_Year_Profit__c = projectedFirstYearProfitInput,
                Calc_Projected_1st_Year_Revenue__c = projectedFirstYearRevenueInput,
                Calc_State_of_Incorporation__c = stateOfIncorporationInput,
                Calc_Total_Startup_Cost__c = totalStartupCostInput,
                Calc_Run_Payroll_Before__c = runPayrollBeforeInput,
                Calc_Filing_Status__c = filingStatusInput,
                Calc_Business_Miles__c = businessMilesInput,
                Calc_Office_Square_Footage__c = officeSqFtInput,
                Calc_Foreign_State__c = foreignStateInput,
                billingSchedule__c = billingTime,
                Bundle__c = bundle,
                Calc_Savings_Amount__c = potentialSavings,
                Calc_Bookkeeping_Start_Date__c = bookKeepingStartDateInput,
                Calc_Bookkeeping_End_Date__c = bookKeepingEndDateInput
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
                Calc_Industry_Type__c = industryTypeInput,
                Calc_Number_of_Employees__c = numberOfEmployeesInput,
                Calc_Number_of_Owners__c = numberOfOwnersInput,
                Calc_Number_of_Transactions__c = numberOfTransactionsInput,
                Calc_Number_of_Rental_Properties__c = numberOfRentalPropertiesInput,
                Calc_Personal_Income__c = personalIncomeInput,
                Calc_Projected_1st_Year_Profit__c = projectedFirstYearProfitInput,
                Calc_Projected_1st_Year_Revenue__c = projectedFirstYearRevenueInput,
                Calc_State_of_Incorporation__c = stateOfIncorporationInput,
                Calc_Total_Startup_Cost__c = totalStartupCostInput,
                Calc_Run_Payroll_Before__c = runPayrollBeforeInput,
                Calc_Filing_Status__c = filingStatusInput,
                Calc_Business_Miles__c = businessMilesInput,
                Calc_Office_Square_Footage__c = officeSqFtInput,
                Calc_Foreign_State__c = foreignStateInput,
                billingSchedule__c = billingTime,
                Bundle__c = bundle,
                Calc_Savings_Amount__c = potentialSavings,
                Calc_Bookkeeping_Start_Date__c = bookKeepingStartDateInput,
                Calc_Bookkeeping_End_Date__c = bookKeepingEndDateInput
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
                SELECT Industry, Expected_1st_year_revenue__c, Entity_Tax_Classification__c, State_of_Formation__c, 
                Total_Startup_Costs__c, NumberOfEmployees, Number_of_owners__c, Primary_Contact_ID__c, 
                Trans_Per_Month__c, Personal_Income__c, Rental_Properties__c, Personal_Return_Filing_Status__c, Current_Year_Profit_Projection__c, 
                Potential_Business_Mile_Savings__c, Potential_Home_Office_Savings__c, Potential_QBI_Savings__c, Potential_SCorp_Savings__c, Potential_Startup_Savings__c, 
                Potential_Total_Savings__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c 
                FROM Account 
                WHERE Id = :accountID
            ];
            //List<Account> accList = [
            //    SELECT Industry, Expected_1st_year_revenue__c, Entity_Tax_Classification__c, State_of_Formation__c, 
            //    Total_Startup_Costs__c, NumberOfEmployees, Number_of_owners__c, Primary_Contact_ID__c, 
            //    Trans_Per_Month__c, Personal_Income__c, Rental_Properties__c, Personal_Return_Filing_Status__c, Current_Year_Profit_Projection__c, 
            //    Estimated_Business_Mileage__c, Home_Office_Square_Feet__c 
            //    FROM Account 
            //    WHERE Id = :accountID
            //];
            for (Account accItem : accList){
            
                // save contact id
                contactID = accItem.Primary_Contact_ID__c;
                
                String cleanBusMileSavings = busMileSavings.replace('$', '').trim();
                Decimal decimalBusMileSavings = 0.00;
                
                if (cleanBusMileSavings != '') {
                    decimalBusMileSavings = Decimal.valueOf(cleanBusMileSavings);
                } 
                String cleanHomeOfficeSavings = homeOfficeSavings.replace('$', '').trim();
                Decimal decimalHomeOfficeSavings = 0.00;
                
                if (cleanHomeOfficeSavings != '') {
                    decimalHomeOfficeSavings = Decimal.valueOf(cleanHomeOfficeSavings);
                }
                
                String cleanQbiSavings = qbiSavings.replace('$', '').trim();
                Decimal decimalQbiSavings = 0.00;
                
                if (cleanQbiSavings != '') {
                    decimalQbiSavings = Decimal.valueOf(cleanQbiSavings);
                }
                
                String cleanSCorpSavings = sCorpSavings.replace('$', '').trim();
                Decimal decimalSCorpSavings = 0.00;
                
                if (cleanSCorpSavings != '') {
                    decimalSCorpSavings = Decimal.valueOf(cleanSCorpSavings);
                }
                
                String cleanStartupExpSavings = startupExpSavings.replace('$', '').trim();
                Decimal decimalStartupExpSavings = 0.00;
                
                if (cleanStartupExpSavings != '') {
                    decimalStartupExpSavings = Decimal.valueOf(cleanStartupExpSavings);
                }
                
                String cleanPotentialSavings = potentialSavings.replace('$', '').trim();
                Decimal decimalPotentialSavings = 0.00;
                
                if (cleanPotentialSavings != '') {
                    decimalPotentialSavings = Decimal.valueOf(cleanPotentialSavings);
                }
                
                accItem.Potential_Business_Mile_Savings__c = decimalBusMileSavings;
                accItem.Potential_Home_Office_Savings__c = decimalHomeOfficeSavings;
                accItem.Potential_QBI_Savings__c = decimalQbiSavings;
                accItem.Potential_SCorp_Savings__c = decimalSCorpSavings;
                accItem.Potential_Startup_Savings__c = decimalStartupExpSavings;
                accItem.Potential_Total_Savings__c = decimalPotentialSavings;
                accItem.Estimated_Business_Mileage__c = businessMilesInput;
                accItem.Home_Office_Square_Feet__c = officeSqFtInput;
                accItem.Foreign_State__c = foreignStateInput; 
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
                if(acItem.name == 'Non-Profit Tax Preparation') { doNonProfitReturn = true; }

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
               
                if (acItem.Id != '01tf1000004VPb5AAG' 
                && acItem.Id != '01tf1000004hsUWAAY' 
                && acItem.Id != '01t3Z000004bH2fQAE' 
                && acItem.Id != '01t3Z0000057HZGQA2' 
                && acItem.Id != '01tf1000003rJGkAAM' 
                && acItem.Id != '01tf1000003JjrkAAC' 
                && acItem.Id != '01tf1000004q0lgAAA' 
                && acItem.Id != '01tf1000004q0lbAAA' 
                && acItem.Id != '01tj0000000LLamAAG' 
                && acItem.Id != '01tf1000003JjrhAAC' 
                && acItem.Id != '01tf1000003JjrgAAC' 
                && acItem.Id != '01tf1000003JjrfAAC' 
                && acItem.Id != '01tj0000003mdhMAAQ' 
                && acItem.Id != '01tj0000000uEdUAAU') {
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
        
        String schedulerURL = sURL+'?TID='+apptType+'&WID='+contactID+'&OtherTrackingID=Pricing%20Calculator';
        String schedulerVIPURL = '';
        String schedulerCSAURL = '';
        
        if (apptType == 'Discovery') {
        
            schedulerVIPURL = sURL+'?TID=DiscoveryVIP&WID='+contactID+'&OtherTrackingID=Pricing%20Calculator';
            schedulerCSAURL = sURL+'?TID=CSAO&WID='+contactID+'&OtherTrackingID=Pricing%20Calculator';
            
        }
        
        if (doAdvisory || doBusinessReturn || doPersonalReturn || doPayroll || doBookkeeping || brand == 'EzBizFile') {
            doSomeSchedule = true;
        }
 
        if (doSomeSchedule == false) {
            schedulerURL = '';
            schedulerVIPURL = '';
            schedulerCSAURL = '';
        }
        
        // update brand on opportunity
        update new Opportunity(
            Id = opportunityID,
            Sales_Platform__c = 'Pricing Calculator',
            Brand__c = brand
        );
        
        Boolean updatedEventWithEC = false; 
        
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
            makeLineItems(businessAdjustment, offerProductList, 'bcheck', bundle, 'Business Return', opportunityID, bizTaxPrepPBEID, bizTaxPrepID, businessQuantity, businessTime, businessTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, bizTaxPrepDesc, bizTaxPrepHTMLDesc, accountID, businessSort, false, 0.00, '', bizTaxPrepOT, bizTaxPrepNoSplit, '', numberOfEmployeesInput);
            
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + getVIPAmount(businessAdjustment, offerProductList, 'bcheck', bundle, 'Business Return', opportunityID, bizTaxPrepPBEID, bizTaxPrepID, businessQuantity, businessTime, businessTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, bizTaxPrepDesc, bizTaxPrepHTMLDesc, accountID, businessSort, false, 0.00, '', bizTaxPrepOT, bizTaxPrepNoSplit, '', numberOfEmployeesInput);
            
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
            makeLineItems(personalAdjustment, offerProductList, 'pcheck', bundle, 'Personal Return', opportunityID, personalTaxPrepPBEID, personalTaxPrepID, personalQuantity, personalTime, personalTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, personalTaxPrepDesc, personalTaxPrepHTMLDesc, accountID, personalSort, false, 0.00, '', personalTaxPrepOT, personalTaxPrepNoSplit, '', numberOfEmployeesInput); 
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + getVIPAmount(personalAdjustment, offerProductList, 'pcheck', bundle, 'Personal Return', opportunityID, personalTaxPrepPBEID, personalTaxPrepID, personalQuantity, personalTime, personalTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, personalTaxPrepDesc, personalTaxPrepHTMLDesc, accountID, personalSort, false, 0.00, '', personalTaxPrepOT, personalTaxPrepNoSplit, '', numberOfEmployeesInput); 
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
        	
            if(useBundlePricing() && !setupFeeItems.contains('Payroll')){
                    payrollAdjustment *= (1-bundleDiscount);
            }
            if(freeItems.contains('Payroll') && !setupFeeItems.contains('Payroll')){
                payrollAdjustment = 0;
            }
            if (payrollTime == 'Monthly') {
            
                if (payrollTimeDef == 'Monthly') {
                
                    tmpACPrice = payrollAdjustment;
                
                } else {
                
                    tmpACPrice = payrollAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = payrollAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                
                //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                
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
                if(useBundlePricing() && defaultItems.contains('Payroll')){
                    coqLIPay.Bundle_Name__c = bundleName;
                }
                
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
                    if(useBundlePricing() && defaultItems.contains('Payroll Setup Fee')){
                        coqLIPayFee.Bundle_Name__c = bundleName;
                    }
                    
                    insert coqLIPayFee;
                    
                }
            
            } else {
                
                if (billingTime == 'mon') {
                
                    if (payrollTimeDef == 'Monthly') {
                        
                        tmpACPrice = payrollAdjustment;
                        subTotalAmount = payrollAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        totalFAmount = payrollAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (payrollAdjustment / 12) * 1.2;
                        subTotalAmount = (payrollAdjustment * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        totalFAmount = payrollAdjustment * 1.2;
                    
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    totalFAmount = totalFAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                    if(useBundlePricing() && defaultItems.contains('Payroll')){
                        coqLIPay.Bundle_Name__c = bundleName;
                    }
                    
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
                        if(useBundlePricing() && defaultItems.contains('Payroll Setup Fee')){
                            coqLIPayFee.Bundle_Name__c = bundleName;
                        }
                        
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
                        subAmount = (tmpACPrice / 2).setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay') {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3).setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay') {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4).setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay') {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6).setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * payrollQuantity;
                        
                        if (payrollOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subAmount = subAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    financeAmount = financeAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                        if(useBundlePricing() && defaultItems.contains('Payroll')){
                            coqLIPay.Bundle_Name__c = bundleName;
                        }
                        
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
                            if(useBundlePricing() && defaultItems.contains('Payroll Setup Fee')){
                                coqLIPayFee.Bundle_Name__c = bundleName;
                            }
                            
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
                        if(useBundlePricing() && defaultItems.contains('Payroll')){
                            coqLIPay.Bundle_Name__c = bundleName;
                        }
                        
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
                            if(useBundlePricing() && defaultItems.contains('Payroll Setup Fee')){
                                coqLIPayFee.Bundle_Name__c = bundleName;
                            }
                            
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
            vipAmount = vipAmount + getVIPAmount(taxAdvisoryPrice, offerProductList, 'acheck', bundle, 'Advisory', opportunityID, taxAdvisoryPBEID, taxAdvisoryID, taxAdvisoryQuantity, taxAdvisoryTime, taxAdvisoryTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, taxAdvisoryDesc, taxAdvisoryHTMLDesc, accountID, taxAdvisorySort, false, 0.00, '', taxAdvisoryOT, payrollNoSplit, '', numberOfEmployeesInput); 
 
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
            vipAmount = vipAmount + getVIPAmount(bookkeepingAdjustment, offerProductList, 'bkcheck', bundle, 'Bookkeeping', opportunityID, bookkeepingPBEID, bookkeepingID, bookkeepingQuantity, bookkeepingTime, bookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, bookkeepingDesc, bookkeepingHTMLDesc, accountID, bookkeepingSort, false, 0.00, '', bookkeepingOT, bookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput);  
        }
        
        if (doStateFiling) {
        	system.debug('doStateFiling');
            System.debug(useBundlePricing());
            System.debug(setupFeeItems.contains('LLC State Filing'));
            System.debug(setupFeeItems);
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
            
            if(useBundlePricing() && !setupFeeItems.contains('LLC State Filing')){
                stateFilingAdjustment *= (1-bundleDiscount);
            }
            if(freeItems.contains('LLC State Filing') && !setupFeeItems.contains('LLC State Filing')){
                stateFilingAdjustment = 0;
            }
            if (stateFilingTime == 'Monthly') {
            
                if (stateFilingTimeDef == 'Monthly') {
                
                    tmpACPrice = stateFilingAdjustment;
                
                } else {
                
                    tmpACPrice = stateFilingAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = stateFilingAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                
                //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                
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
                if(useBundlePricing() && defaultItems.contains('LLC State Filing')){
                    coqLISF.Bundle_Name__c = bundleName;
                }
            
            } else {
                
                if (billingTime == 'mon' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                    if (stateFilingTimeDef == 'Monthly') {
                    
                        tmpACPrice = stateFilingAdjustment;
                        subTotalAmount = stateFilingAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        totalFAmount = stateFilingAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (stateFilingAdjustment / 12) * 1.2;
                        subTotalAmount = (stateFilingAdjustment * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        totalFAmount = stateFilingAdjustment * 1.2; 
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    totalFAmount = totalFAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                    if(useBundlePricing() && defaultItems.contains('LLC State Filing')){
                        coqLISF.Bundle_Name__c = bundleName;
                    }
                    
                } else {
                    
                    if (stateFilingTimeDef == 'Monthly') {
                        
                        tmpACPrice = stateFilingAdjustment * 11;
                        
                    } else {
                    
                        tmpACPrice = stateFilingAdjustment;
                    
                    }
                    
                    if (billingTime == '2pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
            
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay' && stateFilingSetupFee != 'One-Time' && stateFilingNoSplit == false) {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingQuantity;
                        
                        if (stateFilingOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subAmount = subAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    financeAmount = financeAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                        if(useBundlePricing() && defaultItems.contains('LLC State Filing')){
                            coqLISF.Bundle_Name__c = bundleName;
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
                        if(useBundlePricing() && defaultItems.contains('LLC State Filing')){
                            coqLISF.Bundle_Name__c = bundleName;
                        }
                    
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
            
            if(useBundlePricing() && !setupFeeItems.contains('Corp State Filing')){
                stateFilingCorpAdjustment *= (1-bundleDiscount);
            }
            if(freeItems.contains('Corp State Filing') && !setupFeeItems.contains('Corp State Filing')){
                stateFilingCorpAdjustment = 0;
            } 
            
            if (stateFilingCorpTime == 'Monthly') {
            
                if (stateFilingCorpTimeDef == 'Monthly') {
                
                    tmpACPrice = stateFilingCorpAdjustment;
                
                } else {
                
                    tmpACPrice = stateFilingCorpAdjustment / 12;
                
                }
                
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                
                OLIPayInstall = 'Monthly';
                
                subTotalAmount = stateFilingCorpAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                
                //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                
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
                if(useBundlePricing() && defaultItems.contains('Corp State Filing')){
                    coqLISFC.Bundle_Name__c = bundleName;
                }
            
            } else {
                
                if (billingTime == 'mon' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                    if (stateFilingCorpTimeDef == 'Monthly') {
                    
                        tmpACPrice = stateFilingCorpAdjustment;
                        subTotalAmount = stateFilingCorpAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        totalFAmount = stateFilingCorpAdjustment;
                        
                    } else {
                    
                        tmpACPrice = (stateFilingCorpAdjustment / 12) * 1.2;
                        subTotalAmount = (stateFilingCorpAdjustment * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        totalFAmount = stateFilingCorpAdjustment * 1.2; 
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    totalFAmount = totalFAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                    if(useBundlePricing() && defaultItems.contains('Corp State Filing')){
                        coqLISFC.Bundle_Name__c = bundleName;
                    }
                    
                } else {
                    
                    if (stateFilingCorpTimeDef == 'Monthly') {
                        
                        tmpACPrice = stateFilingCorpAdjustment * 11;
                        
                    } else {
                    
                        tmpACPrice = stateFilingCorpAdjustment;
                    
                    }
                    
                    if (billingTime == '2pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
            
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '2-Pay';
                        
                    } else if (billingTime == '3pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '3-Pay';
                        
                    } else if (billingTime == '4pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                    
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '4-Pay';
                        
                    } else if (billingTime == '6pay' && stateFilingCorpSetupFee != 'One-Time' && stateFilingCorpNoSplit == false) {
                        
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6).setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        
                        OLIPayInstall = '6-Pay';
                        
                    } else {
                    
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * stateFilingCorpQuantity;
                        
                        if (stateFilingOT == true) {
                            OLIPayInstall = 'One-Time';
                        } else {
                            OLIPayInstall = 'Yearly';
                        }
                        
                    }
                    
                    tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                    //subAmount = subAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    financeAmount = financeAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                    
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
                        if(useBundlePricing() && defaultItems.contains('Corp State Filing')){
                            coqLISFC.Bundle_Name__c = bundleName;
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
                        if(useBundlePricing() && defaultItems.contains('Corp State Filing')){
                            coqLISFC.Bundle_Name__c = bundleName;
                        }
                    
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
            vipAmount = vipAmount + getVIPAmount(backBookkeepingAdjustment, offerProductList, 'bbkcheck', bundle, 'Back Bookkeeping', opportunityID, backBookkeepingPBEID, backBookkeepingID, backBookkeepingQuantity, backBookkeepingTime, backBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backBookkeepingDesc, backBookkeepingHTMLDesc, accountID, backBookkeepingSort, false, 0.00, '', backBookkeepingOT, backBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
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
            vipAmount = vipAmount + getVIPAmount(foreignStateAdjustment, offerProductList, 'fscheck', bundle, 'Foreign State', opportunityID, foreignStatePBEID, foreignStateID, foreignStateQuantity, foreignStateTime, foreignStateTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, foreignStateDesc, foreignStateHTMLDesc, accountID, foreignStateSort, false, 0.00, '', foreignStateOT, foreignStateNoSplit, '', numberOfEmployeesInput); 
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
            vipAmount = vipAmount + getVIPAmount(backPayrollAdjustment, offerProductList, 'bpycheck', bundle, 'Back Quarterly Payroll', opportunityID, backPayrollPBEID, backPayrollID, backPayrollQuantity, backPayrollTime, backPayrollTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backPayrollDesc, backPayrollHTMLDesc, accountID, backPayrollSort, false, 0.00, '', backPayrollOT, backPayrollNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
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
            vipAmount = vipAmount + getVIPAmount(backBusinessAdjustment, offerProductList, 'bbcheck', bundle, 'Back Business Return', opportunityID, backBusinessPBEID, backBusinessID, backBusinessQuantity, backBusinessTime, backBusinessTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backBusinessDesc, backBusinessHTMLDesc, accountID, backBusinessSort, false, 0.00, '', backBusinessOT, backBusinessNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
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
            vipAmount = vipAmount + getVIPAmount(backPersonalAdjustment, offerProductList, 'bpcheck', bundle, 'Back Personal Return', opportunityID, backPersonalPBEID, backPersonalID, backPersonalQuantity, backPersonalTime, backPersonalTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, backPersonalDesc, backPersonalHTMLDesc, accountID, backPersonalSort, false, 0.00, '', backPersonalOT, backPersonalNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
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
            vipAmount = vipAmount + getVIPAmount(nonProfitBookkeepingAdjustment, offerProductList, 'npbcheck', bundle, 'Non-Profit Bookkeeping', opportunityID, nonProfitBookkeepingPBEID, nonProfitBookkeepingID, nonProfitBookkeepingQuantity, nonProfitBookkeepingTime, nonProfitBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, nonProfitBookkeepingDesc, nonProfitBookkeepingHTMLDesc, accountID, nonProfitBookkeepingSort, false, 0.00, '', nonProfitBookkeepingOT, nonProfitBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
        }
        
        if (doNonProfitBackBookkeeping) {
        
            // do i need to create a chargeover quote?
            if (nonProfitBackBookkeepingTime == 'Monthly') {
            
                if (madeMonth == false) {
                    
                    insert theCOQuoteMonth;
                    
                    cOQuoteIDMonth = theCOQuoteMonth.Id;
                    
                    madeMonth = true;
                        
                }
                
            } else {
                
                if (billingTime == 'mon' && nonProfitBackBookkeepingNoSplit == false) {
                
                    if (madeMonth == false) {
                    
                        insert theCOQuoteMonth;
                        
                        cOQuoteIDMonth = theCOQuoteMonth.Id;
                        
                        madeMonth = true;
                            
                    }
                    
                } else {
                    
                    if (nonProfitBackBookkeepingOT == true && (billingTime == 'yrl' || nonProfitBackBookkeepingNoSplit == true)) {
                    
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
            makeLineItems(nonProfitBackBookkeepingAdjustment, offerProductList, 'npbbcheck', bundle, 'Non-Profit Back Bookkeeping', opportunityID, nonProfitBackBookkeepingPBEID, nonProfitBackBookkeepingID, nonProfitBackBookkeepingQuantity, nonProfitBackBookkeepingTime, nonProfitBackBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, nonProfitBackBookkeepingDesc, nonProfitBackBookkeepingHTMLDesc, accountID, nonProfitBackBookkeepingSort, false, 0.00, '', nonProfitBackBookkeepingOT, nonProfitBackBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
            // update vipAmount for scheduler url reasons
            vipAmount = vipAmount + getVIPAmount(nonProfitBackBookkeepingAdjustment, offerProductList, 'npbbcheck', bundle, 'Non-Profit Back Bookkeeping', opportunityID, nonProfitBackBookkeepingPBEID, nonProfitBackBookkeepingID, nonProfitBackBookkeepingQuantity, nonProfitBackBookkeepingTime, nonProfitBackBookkeepingTimeDef, billingTime, quoteID, cOQuoteID, cOQuoteIDMonth, cOQuoteIDOneTime, nonProfitBackBookkeepingDesc, nonProfitBackBookkeepingHTMLDesc, accountID, nonProfitBackBookkeepingSort, false, 0.00, '', nonProfitBackBookkeepingOT, nonProfitBackBookkeepingNoSplit, numberOfTransactionsInput, numberOfEmployeesInput); 
        }
        
        System.debug('doNonProfitReturn: '+doNonProfitReturn);
        System.debug(bundleNameToFreeItems.get(getEligibleBundle()));
        System.debug(useBundlePricing()+': '+getEligibleBundle());
        System.debug(setupFeeItems);
        for(myWrapperClass acItem : acList){
            System.debug(acItem.doIt+': '+acItem.name);
            if (acItem.doIt) {
                
                tmpACPrice = acItem.price;
            
                //loan agreement
                // check to see if we need to zero out price for bundle
                if (acItem.id == '01tj0000000LLamAAG') {
                
                    if(useBundlePricing()){
                        tmpACPrice = acItem.price;
                    } else if ((doPersonalReturn || (leadTypeInput != null && leadTypeInput.contains('PTP'))) && doAdvisory) {
                        tmpACPrice = 0;
                    } else {
                        tmpACPrice = acItem.price;
                    }
                    if(setupFeeItems.contains('Loan Agreement')){
                        tmpACPrice = acItem.price;
                    }
                    //online access
                } else if (acItem.id == '01tf1000003JjrwAAC') {                
                   
                    
                    // if ((doBusinessReturn || (leadTypeInput != null && leadTypeInput.contains('BTP'))) && (doPersonalReturn || (leadTypeInput != null && leadTypeInput.contains('PTP'))) && doAdvisory) {
                    //     tmpACPrice = acItem.altPrice;
                    // } else if ((doPersonalReturn || (leadTypeInput != null && leadTypeInput.contains('PTP'))) && doAdvisory && doADP && doADB && doLA && doTYR) {
                    //     tmpACPrice = acItem.altPrice;
                    // } else if ((doPersonalReturn || (leadTypeInput != null && leadTypeInput.contains('PTP'))) && doAdvisory && doNP) {
                    //     tmpACPrice = acItem.altPrice;
                    // } else {
                    //     tmpACPrice = acItem.price;
                    // }
                    tmpACPrice = acItem.price;
                    
                } else if (acItem.id == '01tf1000004s3nYAAQ') {
                
                    // 1099 product, we need to do a one off discount, $20 per additional quantity
                    // if (acItem.quantity == 1 || acItem.price == 0) {
                    
                    //     tmpACPrice = acItem.price;
                    
                    // } else { 
                    //     tmpACPrice = (acItem.price + ((acItem.quantity - 1) * 20)) / acItem.quantity;
                    //     tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    
                    // }
                
                } else {
                    tmpACPrice = acItem.price;
                }
                
                // default delayed billing value goes here
                holdDateString = '';
                itemSoldInOffer = false;
                
                if(useBundlePricing() && !setupFeeItems.contains(acItem.name)){
                    tmpACPrice = tmpACPrice * (1-bundleDiscount);
                }
                if(freeItems.contains(acItem.name) && !setupFeeItems.contains(acItem.name)){
                    tmpACPrice = 0;
                } 
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
            System.debug(acItem.Name+', billingTime: '+billingTime+', acItem.billingTime: '+acItem.billingTime+', acItem.billingTimeDef: '+acItem.billingTimeDef);
                System.debug('acItem.noSplit: '+acItem.noSplit+', acItem.setupFee: '+acItem.setupFee);
                // is this a monthly billing item
                if (acItem.billingTime == 'Monthly') { 
                    System.debug(LoggingLevel.FINER, 'acItem.billingTime Monthly :: -- ');
                    if (acItem.billingTimeDef == 'Monthly') {
                        
                        tmpACPrice2 = tmpACPrice;
                        
                    } else {
                    
                        if (acItem.Id == '01tf1000003JjrwAAC') {
                            tmpACPrice2 = tmpACPrice / 11;
                        } else {
                            tmpACPrice2 = tmpACPrice / 12;
                        } 
                    }
                    
                    tmpACPrice2 = tmpACPrice2.setScale(0, RoundingMode.CEILING).setScale(2);
                    
                    OLIPayInstall = 'Monthly';
                    
                    subTotalAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                
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
                    if(useBundlePricing() && defaultItems.contains(acItem.name)){
                        coqLIA.Bundle_Name__c = bundleName;
                    }
    
                    
                
                    insert coqLIA; 
                } else {
                    
                    // if not, are we financing
                    //if (billingTime == 'mon' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                    if (billingTime == 'mon' && acItem.noSplit == false) {
                        if (acItem.billingTimeDef == 'Monthly') {
                    
                            tmpACPrice2 = tmpACPrice;
                            subTotalAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            totalFAmount = tmpACPrice;
                            
                        } else {
                        
                            tmpACPrice2 = (tmpACPrice / 12) * 1.2;
                            subTotalAmount = (tmpACPrice * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            totalFAmount = tmpACPrice * 1.2;
    
                        }
                        
                        tmpACPrice2 = tmpACPrice2.setScale(0, RoundingMode.CEILING).setScale(2);
                        //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                        totalFAmount = totalFAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                        
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
                        if(useBundlePricing() && defaultItems.contains(acItem.name)){
                            coqLIA.Bundle_Name__c = bundleName;
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
                            subAmount = (tmpACPrice2 / 2).setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            
                            OLIPayInstall = '2-Pay';
                            
                        } else if (billingTime == '3pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                        
                            financeAmount = (tmpACPrice2 / 3);
                            subAmount = (tmpACPrice2 / 3).setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            
                            OLIPayInstall = '3-Pay';
                            
                        } else if (billingTime == '4pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                        
                            financeAmount = (tmpACPrice2 / 4);
                            subAmount = (tmpACPrice2 / 4).setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            
                            OLIPayInstall = '4-Pay';
                            
                        } else if (billingTime == '6pay' && acItem.setupFee != 'One-Time' && acItem.noSplit == false) {
                            
                            financeAmount = (tmpACPrice2 / 6);
                            subAmount = (tmpACPrice2 / 6).setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            
                            OLIPayInstall = '6-Pay';
                            
                        } else {
                        
                            financeAmount = tmpACPrice2;
                            subAmount = tmpACPrice2.setScale(0, RoundingMode.CEILING).setScale(2) * acItem.quantity;
                            
                            if (acItem.billingFreq == 'One-Time') {
                                OLIPayInstall = 'One-Time';
                            } else {
                                OLIPayInstall = 'Yearly';
                            }
                            
                        }
                        
                        tmpACPrice2 = tmpACPrice2.setScale(0, RoundingMode.CEILING).setScale(2);
                        //subAmount = subAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                        financeAmount = financeAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                        
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
                        if (acItem.billingFreq == 'One-Time' && (billingTime == 'yrl' || acItem.noSplit == true)) {
                        //if (acItem.billingFreq == 'One-Time') {
                        
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
                        if(useBundlePricing() && defaultItems.contains(acItem.name)){
                            coqLIA.Bundle_Name__c = bundleName;
                        }
                    
                        insert coqLIA;
                    
                    }
                    
                }
                
                // update vipAmount for scheduler url reasons
                vipAmount = vipAmount + subTotalAmount; 
            }
        
        }
        //
        Boolean isPreferredLeadSource = (LeadSource == '1-800Accountant' || LeadSource == 'Bark' || LeadSource =='Inc. Authority' || LeadSource =='ZenBusiness');
        Boolean isAdvisoryClient = (hasActiveAdvisory || doAdvisory);
        Boolean isCSA =  isAdvisoryClient && (isPreferredLeadSource || vipAmount >= 7500);

        Boolean isVIP = (!isCSA && vipAmount > 4999.00);

        // update chargeover quote to confirm done
        if (madeYear == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuote :: ' + theCOQuote);
            theCOQuote.Quote_Created__c = true;
            
            
            if (isCSA && schedulerCSAURL != '') {
                theCOQuote.Scheduler_URL__c = schedulerCSAURL;
            } else if (isVIP && schedulerVIPURL != '') {
                theCOQuote.Scheduler_URL__c = schedulerVIPURL;
            }
            
            update theCOQuote;
        }
        
        if (madeMonth == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuoteMonth :: ' + theCOQuoteMonth);
            theCOQuoteMonth.Quote_Created__c = true;
            
            if (isCSA && schedulerCSAURL != '') {
                theCOQuoteMonth.Scheduler_URL__c = schedulerCSAURL;
            } else if (isVIP && schedulerVIPURL != '') {
                theCOQuoteMonth.Scheduler_URL__c = schedulerVIPURL;
            }
            
            update theCOQuoteMonth;
        }
        
        if (madeOneTime == true) {
            System.debug(LoggingLevel.FINER, 'setting madeYear to true for theCOQuoteMonth :: ' + theCOQuoteMonth);
            theCOQuoteOneTime.Quote_Created__c = true;
            
            if (isCSA && schedulerCSAURL != '') {
                theCOQuoteOneTime.Scheduler_URL__c = schedulerCSAURL;
            } else if (isVIP && schedulerVIPURL != '') {
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
    public static String getDiscountData(String formEntityType, String formIndustryType, String formNumberOfEmployees, String formNumberOfOwners, String formNumberOfTransactions, String formNumberOfRentalProperties, String formPersonalIncome, String formProjectedFirstYearProfit, String formProjectedFirstYearRevenue, String formStateOfIncorporation, String formTotalStartupCost, String formRunPayrollBefore, String formFilingStatus, String formOfficeSqFT, String formBusMiles){
        
        // initialize list to hold object that we will return from this method, properties are below
        // public String DiscountType {get;set;}
        // public Boolean DisplayDiscount {get;set;}
        // public Decimal Amount {get;set;} 

        List<discountWrapper> discountList = new List<discountWrapper>();
        discountWrapper discountItem = new discountWrapper();
        
        discountItem.DiscountType = 'sCorpSavings';
        discountItem.DisplayDiscount = displaySCorporationSavings(Integer.valueOf(formProjectedFirstYearProfit), formEntityType, formIndustryType);
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
    public static Boolean displaySCorporationSavings(Integer formProjectedFirstYearProfit, String formEntityType, String formIndustryType){
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
    
    //only runs for non a la carte items
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
        String bundleName = useBundlePricing() ? getEligibleBundle() : 'Core Accounting Package';
        List<String> freeItems = bundleNameToFreeItems.get(bundleName);
        List<String> defaultItems = bundleToDefaultProductNames.get(bundleName);

        System.debug(calcIdPass);
        String productName = calculatorIdToName.containsKey(calcIdPass) ? calculatorIdToName.get(calcIdPass) : calculatorIdToName.get(productDescription);
        System.debug(productName);
        System.debug(defaultItems);
        System.debug(useBundlePricing());

        
        if(useBundlePricing() && !setupFeeItems.contains(productName)){
            productPassAdjustment *= (1-bundleDiscount);
        }
        if(productName == 'Loan Agreement' && !doAdvisory){
            //don't overwrite price of standalone loan agreement
        } else if(freeItems.contains(productName) && !setupFeeItems.contains(productName)){
            productPassAdjustment = 0;
        } 
        if(productDescription == 'Advisory'){ System.debug('makeLineItems bundled advisory: '+productPassAdjustment); }
        
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
        if(productDescription == 'Advisory'){ System.debug('makeLineItems advisory price with offer: '+productPassAdjustment); }

    
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
            
            tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
            
            OLIPayInstall = 'Monthly';
            
            subTotalAmount = productPassAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
            
            //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
            
            subAmount = tmpACPrice * quantityPass;
            if(productDescription == 'Advisory'){ System.debug('makeLineItems tmpACPrice: '+tmpACPrice); }

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
            if(useBundlePricing() && defaultItems.contains(productName)){
                coqLIPass.Bundle_Name__c = bundleName;
            }
            
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
                    subTotalAmount = productPassAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    totalFAmount = productPassAdjustment;
                    
                } else {
                
                    tmpACPrice = (productPassAdjustment / 12) * 1.2;
                    subTotalAmount = (productPassAdjustment * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    totalFAmount = productPassAdjustment * 1.2;
    
                }
                
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                totalFAmount = totalFAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                
                subAmount = tmpACPrice * quantityPass;
                if(productDescription == 'Advisory'){ System.debug('makeLineItems tmpACPrice: '+tmpACPrice); }

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
                if(useBundlePricing() && defaultItems.contains(productName)){
                    coqLIPass.Bundle_Name__c = bundleName;
                }
                
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
                    subAmount = (tmpACPrice / 2).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    
                    OLIPayInstall = '2-Pay';
                    
                } else if (billingTimePass == '3pay') {
                
                    financeAmount = (tmpACPrice / 3);
                    subAmount = (tmpACPrice / 3).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    
                    OLIPayInstall = '3-Pay';
                    
                } else if (billingTimePass == '4pay') {
                
                    financeAmount = (tmpACPrice / 4);
                    subAmount = (tmpACPrice / 4).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    
                    OLIPayInstall = '4-Pay';
                    
                } else if (billingTimePass == '6pay') {
                    
                    financeAmount = (tmpACPrice / 6);
                    subAmount = (tmpACPrice / 6).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    
                    OLIPayInstall = '6-Pay';
                    
                } else {
                
                    financeAmount = tmpACPrice;
                    subAmount = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
    
                    if (oneTimePass == true) {
                        OLIPayInstall = 'One-Time';
                    } else {
                        OLIPayInstall = 'Yearly';
                    }
                    
                }
                
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                //subAmount = subAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                financeAmount = financeAmount.setScale(0, RoundingMode.CEILING).setScale(2);
                
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
                    if(useBundlePricing() && defaultItems.contains(productName)){
                        coqLIPass.Bundle_Name__c = bundleName;
                    }
                    
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
                    if(useBundlePricing() && defaultItems.contains(productName)){
                        coqLIPass.Bundle_Name__c = bundleName;
                    }
                    
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

    public Boolean useBundlePricing(){
        Boolean btp = hasActiveBTP || doBusinessReturn;
        Boolean ptp = hasActivePTP || doPersonalReturn;
        Boolean advisory = hasActiveAdvisory || doAdvisory;
        Boolean nonProfit = hasActiveNPTP || doNonProfitReturn;
        if(getEligibleBundle() == 'Core Accounting Package (Non-Profit)'){
            return nonProfit && advisory;
        }
        return btp && ptp && advisory;
    }
    
    public Decimal getVIPAmount(Decimal productPassAdjustment, List<offerProductWrapperClass> offerProductListPass, String calcIdPass, String bundlePass, String productDescription, String opportunityIdPass, String pricebookEntryIdPass, String productIdPass, Integer quantityPass, String timePass, String timeDefPass, String billingTimePass, String quoteIdPass, String coQuoteIdPass, String coQuoteIdMonthPass, String coQuoteIdOneTimePass, String sowDescPass, String sowDescPassHTML, String accountIdPass, Decimal sortPass, Boolean doFeePass, Decimal feeAmountPass, String feeDesc, Boolean oneTimePass, Boolean noSplitPass, String numberOfTransactionsInputPass, String numberOfEmployeesInputPass)
    {
        
        // default variables declared here
        Decimal subTotalAmount = 0.00;
        Decimal tmpACPrice = 0.00;
 
        // check for bundle price
        for(offerProductWrapperClass opwItem : offerProductListPass){
            
            if (opwItem.calcId == calcIdPass && bundlePass == opwItem.offerId && opwItem.usePricebook == false) {
                
                productPassAdjustment = opwItem.amount;
                
            } 
            
        }
    
        // now we do something different depending on the timeframe for billing selected
        if (timePass == 'Monthly') {
            
            subTotalAmount = productPassAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
        
        } else {
        
            if (noSplitPass == true) {
                billingTimePass = 'yrl';
            }
            
            if (billingTimePass == 'mon') { 
                if (timeDefPass == 'Monthly') {
                
                    subTotalAmount = productPassAdjustment.setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
                    
                } else {
                
                    subTotalAmount = (productPassAdjustment * 1.2).setScale(0, RoundingMode.CEILING).setScale(2) * quantityPass;
    
                } 
            } else {
                
                if (timeDefPass == 'Monthly') {
                    
                    tmpACPrice = productPassAdjustment * 11;
                    
                } else {
                
                    tmpACPrice = productPassAdjustment;
                
                } 
                tmpACPrice = tmpACPrice.setScale(0, RoundingMode.CEILING).setScale(2);
                
                subTotalAmount = tmpACPrice * quantityPass; 
            }
            
        }
        
        // return vip amount
        //subTotalAmount = subTotalAmount.setScale(0, RoundingMode.CEILING).setScale(2);
        return subTotalAmount; 
    }
    
    public Decimal getDynamicAmount(String productNamePass, String entityTypeInputPass, String industryTypeInputPass, String numberOfEmployeesInputPass, String numberOfOwnersInputPass, String numberOfRentalPropertiesInputPass, String personalIncomeInputPass, String projectedFirstYearProfitInputPass, String projectedFirstYearRevenueInputPass, String stateOfIncorporationInputPass, String totalStartupCostInputPass, String numberOfTransactionsInputPass, String filingStatusInputPass, String businessMilesInputPass, String officeSqFtInputPass, String foreignStateInputPass) 
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
            
            if (dropItem.Form_Field__c == 'Industry Type') {
                tempValue = industryTypeInputPass;
            }
            
            if (dropItem.Form_Field__c == 'Number of Employees') {
                tempValue = numberOfEmployeesInputPass;
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
            
            if (dropItem.Form_Field__c == 'Total Startup Cost') {
                tempValue = totalStartupCostInputPass;
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
            if (tempValue == dropItem.Dropdown_Value__c) {
                adjustAmount = adjustAmount + dropItem.Price_Adjustment__c;
            }
        
        }
        
        return adjustAmount;
        
    }
    
}