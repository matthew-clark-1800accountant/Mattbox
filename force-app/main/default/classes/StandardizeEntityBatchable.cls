public with sharing class StandardizeEntityBatchable implements Database.Batchable<sObject>{
    public final String Query;
    public final String Type;
    public final Date Boundary;

    public List<String> C_Corporation = new List<String>{
        'EIN Filing - Corporation',
        'C',
        'Cor',
        'C Corp',
        'Corp',
        'C-Corp',
        'inc',
        'Incorporation',
        'Profit Corporation',
        'CORPORATION',
        'PERSONAL_SERVICE_CORPORATION',
        'LLC taxed as C Corp',
        'EIN - Corporation',
        'State - Corporation',
        'State Filing - Corporation',
        'State Filing - Personal Service Corporation',
        'DOM_CORP',
        'State and EIN - Corporation',
        'CORP',
        'FRGN_CORP'
    };

    public List<String> DBA_Sole_Proprietorship = new List<String>{
        'EIN Filing - Sole Proprietor',
        'DBA',
        'DBA/Sole Proprietorship',
        'Sole Proprietorship',
        'SoleProprietor',
        'EIN - SoleProprietor',
        'EIN - Sole Proprietor',
        'SoleProprietorship',
        'EIN Filing - Sole Proprietor'
    };

    public List<String> LLC = new List<String>{
        'EIN and State Filing - LLC',
        'EIN Filing - LLC',
        'LLC - Single Member',
        'LLC - Partnership',
        'LLC – Single Member',
        'PLLC',
        'LLC electing S Corp status',
        'EIN - LLC',
        'State - LLC',
        'State Filing - LLC',
        'State Filing and EIN - LLC',
        'State and EIN - LLC',
        'State and EIN Filing - LLC',
        'Limited Liability Company (LLC)',
        'EIN and State Filing - LLC',
        'DOM_LLC',
        'Corporation/LLC',
        'FRGN_LLC',
        'PRFSNL_LLC'
    };

    public List<String> Non_Profit = new List<String>{
        'EIN Filing - Non Profit',
        'EIN Filing - NonProfit',
        'EIN Filing - Non Profit',
        'NON',
        'Nonprofit',
        'Non Profit',
        'NON_PROFIT_ORGANIZATION',
        'CHURCH_CONTROLLED_ORGANIZATION',
        'EIN -NonProfit',
        'Express Gold Nonprofit Corporation',
        'EIN - NonProfit',
        'EIN - Church',
        'EIN - Non-Profit Organization',
        'Non-profit Corporation',
        'EIN - Non Profit',
        'EIN - Church Controlled',
        'EIN - Non Profit Organization',
        'EIN Filing - NonProfit'
    };

    public List<String> Partnership = new List<String>{
        'LLC – Partnership',
        'LLC - Partnership',
        'EIN - Partnership',
        'General Partnership',
        'PTNRSHP',
        'LLP',
        'EIN Filing - Partnership',
        'EIN Filing - Estate',
        'FRGN_LP',
        'DOM_LLLP',
        'DOM_LLP',
        'FRGN_LLP',
        'LLLP',
        'LP',
        'PRFSNL_LLP'
    };

    public List<String> S_Corporation = new List<String>{
        'EIN Filing - Scorporation',
        'Environmental S',
        'S-Corporation',
        'scorp',
        'S',
        'S Corp',
        'S-Corp',
        'EIN -S Corporation',
        'EIN - SCorporation',
        'State and EIN Filing - SCorporation',
        'State Filing - SCorporation',
        'EIN and State Filing - Scorporation'
    };

    public List<String> Undetermined = new List<String>{
        'EIN Filing - Trust',
        'Public',
        'Pick Classification',
        'I Don’t Know',
        'ds',
        'TRUST',
        'ESTATE_DECEASED_INDIVIDUAL',
        'EstateOfDeceasedIndividual',
        'Other',
        'EIN -Estate',
        'EIN -Trust',
        'EIN - Trust',
        'EIN - Estate',
        'Professional Co',
        'undefined',
        'NA',
        'RVSD_NAME',
        'FRGN_CORP',
        'LP',
        'OTH',
        'PRFSNL_ASSTN',
        'REGD_NAME',
        'EIN Filing - Estate',
        'NULL',
        'EIN Filing - Trust',
        'REGD_NAME',
        'TM',
        'TRST'
    };


 
    public StandardizeEntityBatchable(Date boundary, String type){
        System.debug('constructor');
        System.debug(boundary);
        System.debug(type);
        this.Boundary = boundary;
        this.Type = type;
        if(type == 'Lead'){
            this.Query = 'SELECT Id, Entity_Type__c, Entity_Tax_Classification__c FROM Lead WHERE IsConverted = false AND CreatedDate >= :bound AND Entity_Tax_Classification__c != null';
        } else if(type == 'Account'){
            this.Query = 'SELECT Id, Entity_Type__c, Entity_Tax_Classification__c FROM Account WHERE CreatedDate >= :bound AND Entity_Tax_Classification__c != null';
        }              
    }
 
    public Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('start');
        Date bound = this.Boundary;
        System.debug(bound);
       return Database.getQueryLocator(this.Query);
    }
 
    public void execute(Database.BatchableContext BC, List<sObject> scope){       
        System.debug('type: '+this.Type);
        if(this.Type == 'Lead'){
            standardizeLeadEntities((List<Lead>)scope);
        } else if(this.Type == 'Account') {
            standardizeAccountEntities((List<Account>)scope);
        }
         
    }
 
    public void finish(Database.BatchableContext BC){
 
    }

    public void standardizeLeadEntities(List<Lead> leadList){  
        for(Lead l : leadList){
            
           if(C_Corporation.contains(l.Entity_Tax_Classification__c) || C_Corporation.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'C Corporation';
           }else if(DBA_Sole_Proprietorship.contains(l.Entity_Tax_Classification__c) || DBA_Sole_Proprietorship.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'DBA/Sole Proprietorship';
           }else if(LLC.contains(l.Entity_Tax_Classification__c) || LLC.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'LLC';
           }else if(Non_Profit.contains(l.Entity_Tax_Classification__c) || Non_Profit.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'Non-Profit';
           }else if(Partnership.contains(l.Entity_Tax_Classification__c) || Partnership.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'Partnership';
           }else if(S_Corporation.contains(l.Entity_Tax_Classification__c) || S_Corporation.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'S Corporation';
           }else if(Undetermined.contains(l.Entity_Tax_Classification__c) || Undetermined.contains(l.Entity_Type__c)){
                l.Entity_Tax_Classification__c = 'Undetermined';
           }
        }
        update leadList;
    }

    public void standardizeAccountEntities(List<Account> accountList){  
        for(Account a : accountList){
            System.debug('old: '+a.Entity_Tax_Classification__c);
            if(C_Corporation.contains(a.Entity_Tax_Classification__c) || C_Corporation.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'C Corporation';
           }else if(DBA_Sole_Proprietorship.contains(a.Entity_Tax_Classification__c) || DBA_Sole_Proprietorship.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'DBA';
           }else if(LLC.contains(a.Entity_Tax_Classification__c) || LLC.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'LLC';
           }else if(Non_Profit.contains(a.Entity_Tax_Classification__c) || Non_Profit.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'Non-Profit';
           }else if(Partnership.contains(a.Entity_Tax_Classification__c) || Partnership.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'Partnership';
           }else if(S_Corporation.contains(a.Entity_Tax_Classification__c) || S_Corporation.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'S Corporation';
           }else if(Undetermined.contains(a.Entity_Tax_Classification__c) || Undetermined.contains(a.Entity_Type__c)){
                a.Entity_Tax_Classification__c = 'Undetermined';
           }

           System.debug('new: '+a.Entity_Tax_Classification__c);
        }
        update accountList;
    }
 
 }