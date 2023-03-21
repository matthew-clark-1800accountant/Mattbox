/*
@Name            : C62SubscriptionRenewer
@Author          : Rich Burke (rburke@huronconsultinggroup.com)
@Date            : July 11, 2016
@Description     : One-time script to renew Subscriptions that missed being renewed automatically
*/

public class C62SubscriptionRenewer{
    public static void renewSubscriptions(Set<String> subIDs, Boolean allowPastLines){
        List<Bill62__Subscription__c> subList = [SELECT ID, Bill62__End_Date__c, Bill62__Billing_Schedule__c, Bill62__Last_Subscription_Line_End_Date__c,
        Bill62__Product__c
        FROM Bill62__Subscription__c WHERE ID IN :subIDs]; //add conditions from report
        
        //stop if there are no subs
        if(subList.size() == 0) return;
        
        //get the billing schedules for renewal
       Set<String> productIDs = new Set<String>();
       Set<String> billingScheduleIDs = new Set<String>();
       for(Bill62__Subscription__c sub : subList ){
           if(sub.Bill62__Billing_Schedule__c != null) billingScheduleIDs.add(sub.Bill62__Billing_Schedule__c);
           productIDs.add(sub.Bill62__Product__c);
       }
       //system.debug('The List: ' + msLst);
       Map<String, Bill62__Billing_Schedule__c> prodToDefaultMap = new Map<String, Bill62__Billing_Schedule__c>();
       Map<Id, Bill62__Billing_Schedule__c> bsMap = new Map<Id, Bill62__Billing_Schedule__c>([SELECT ID,
           Bill62__Renewal_Schedule__c FROM Bill62__Billing_Schedule__c WHERE ID IN :billingScheduleIDs]);
       List<Bill62__Billing_Schedule__c> bsList = [SELECT ID, Bill62__Renewal_Schedule__c, Bill62__Product__c
           FROM Bill62__Billing_Schedule__c WHERE Bill62__Product__c IN :productIDs AND Bill62__Default__c = true];
       for(Bill62__Billing_Schedule__c bs: bsList){
           prodToDefaultMap.put(bs.Bill62__Product__c, bs);
       }
        
        for(Bill62__Subscription__c subsc : subList ){
            if(subsc.Bill62__Billing_Schedule__c == null){
              subsc.Bill62__Billing_Schedule__c = prodTodefaultmap.get(subsc.Bill62__Product__c).Id;
            } else {
              if(bsMap.containsKey(subsc.Bill62__Billing_Schedule__c)){
                Bill62__Billing_Schedule__c temp = bsMap.get(subsc.Bill62__Billing_Schedule__c);
                if(temp.Bill62__Renewal_Schedule__c != null){
                  //system.debug(temp.Bill62__Renewal_Schedule__c);
                  subsc.Bill62__Billing_Schedule__c = temp.Bill62__Renewal_Schedule__c;
                }
              }
            }
            //newSubs.add(subsc);
            //system.debug(subsc.Bill62__Billing_Schedule__c);
          }
          update subList;
          
          List<Bill62__Subscription_Line__c> subLineList = generateLines(subList,allowPastLines);
          insert subLineList;
    }
    
    public static Integer maximumNumberOfMonths {
        get{
            if(maximumNumberOfMonths != null) return maximumNumberOfMonths;
            Bill62__C62Billing_Config__c billSettings = Bill62__C62Billing_Config__c.getOrgDefaults();
            
            //don't run if the custom setting isn't set
            if(billSettings.Bill62__Payment_Terms__c == null){
                maximumNumberOfMonths = 0;
            } else {
                //max months in a single generation of sub lines = 
                maximumNumberOfMonths = Integer.valueOf(billSettings.Bill62__Payment_Terms__c);
            }  
            return maximumNumberOfMonths;
        }set;
    }
    
    public static List<Bill62__Subscription_Line__c> generateLines(List<Bill62__Subscription__c> startscope, Boolean allowPastLines){
        Set<String> subIDs = new Set<String>();
        for(Bill62__Subscription__c sub: startscope){
            subIDs.add(sub.Id);
        }
        List<Bill62__Subscription__c> scope = [SELECT ID,Bill62__Billing_Schedule__c,Bill62__Product__c,Bill62__Start_Date__c,Bill62__End_Date__c,
        Bill62__Discount__c,Bill62__Discount__r.Bill62__Flat_Discount__c,Bill62__Discount__r.Bill62__Percent_Discount__c,
        Bill62__Flat_Discount_Used__c, Bill62__Last_Subscription_Line_End_Date__c,
        Bill62__Order__c,Bill62__Order__r.Bill62__Discount__c,Bill62__Order__r.Bill62__Discount__r.Bill62__Percent_Discount__c
        FROM Bill62__Subscription__c WHERE ID IN :subIDs];
        
        List<Bill62__Subscription_Line__c> retList = new  List<Bill62__Subscription_Line__c>();
        //system.debug('generating subscription lines');
        
        //collect products
        Set<Id> productIds = new Set<Id>();
        Set<Id> specificProductIds = new Set<Id>();
        for(Bill62__Subscription__c s : scope){  
            if(s.Bill62__Billing_Schedule__c <> null){
                specificProductIds.add(s.Bill62__Product__c);
            } else {
                productIds.add(s.Bill62__Product__c);
            }
        }
        
        //post-facto null remove
        productIds.remove(null);
        specificProductIds.remove(null);

        Map<Id, Bill62__Billing_Schedule__c> billingScheduleMap = new Map<Id,Bill62__Billing_Schedule__c>();
        Map<Id, Bill62__Billing_Schedule__c> specificBillingScheduleMap = new Map<Id,Bill62__Billing_Schedule__c>();
        
        for(Bill62__Billing_Schedule__c bs : [select Bill62__Product__c,Bill62__Has_One_Time__c, Bill62__Has_Recurring__c,
            (select Id,Bill62__Charge_Amount__c,Bill62__Charge_Month__c,Bill62__One_Time_Fee__c,Bill62__Type__c,Bill62__Days_Adjustment__c  
            FROM Bill62__Billing_Schedule_Lines__r) 
        FROM Bill62__Billing_Schedule__c WHERE Bill62__Active__c = true AND Bill62__Approved__c = true AND Bill62__Default__c = true and Bill62__Product__c in :productIds]){                                                  
            billingScheduleMap.put(bs.Bill62__Product__c, bs);
        }
        for(Bill62__Billing_Schedule__c bs : [select Id, Bill62__Product__c,Bill62__Has_One_Time__c, Bill62__Has_Recurring__c,
            (select Id,Bill62__Charge_Amount__c,Bill62__Charge_Month__c,Bill62__One_Time_Fee__c,Bill62__Type__c,Bill62__Days_Adjustment__c  
            FROM Bill62__Billing_Schedule_Lines__r) 
        FROM Bill62__Billing_Schedule__c WHERE Bill62__Active__c = true AND Bill62__Approved__c = true and Bill62__Product__c in :specificProductIds]){                                                  
            specificBillingScheduleMap.put(bs.Id, bs);
        }
        
        for(Bill62__Subscription__c s : scope){
            if(s.Bill62__Billing_Schedule__c <> null){
                if(specificBillingScheduleMap.get(s.Bill62__Billing_Schedule__c ) != null){
                    system.debug(specificBillingScheduleMap);
                    retList.addAll(makeSubscriptionLines(s, specificBillingScheduleMap.get(s.Bill62__Billing_Schedule__c ), specificBillingScheduleMap.get(s.Bill62__Billing_Schedule__c ).Bill62__Billing_Schedule_Lines__r,allowPastLines));    
                    system.debug(retList);
                }
            } else {
                if(billingScheduleMap.get(s.Bill62__Product__c) != null){
                    retList.addAll(makeSubscriptionLines(s, billingScheduleMap.get(s.Bill62__Product__c), billingScheduleMap.get(s.Bill62__Product__c).Bill62__Billing_Schedule_Lines__r,allowPastLines));    
                }
            }
        }
        
        return retList;
    }
    
    public static List<Bill62__Subscription_Line__c> makeSubscriptionLines(Bill62__Subscription__c subscription, Bill62__Billing_Schedule__c theBS, List<Bill62__Billing_Schedule_Line__c> theLines, Boolean allowPastLines){
        List<Bill62__Subscription_Line__c> retList = new List<Bill62__Subscription_Line__c>();
        //system.debug('generating subscription lines');
        system.debug(subscription);
        system.debug(theBS);
        system.debug(theLines);
        Date startDate;
        if(subscription.Bill62__Last_Subscription_Line_End_Date__c  != null ){
            if(theBS.Bill62__Has_One_Time__c && !theBS.Bill62__Has_Recurring__c){
                //this is a special case, since one-time lines have a 1 day term, so it's possible that the LSL End is a day after the start date
                startDate = subscription.Bill62__Last_Subscription_Line_End_Date__c.addMonths(maximumNumberOfMonths);//*2);
                
                //extra: it's possible that some one-times have lines that stretch an entire year.  Try to account for that
                if(subscription.Bill62__Last_Subscription_Line_End_Date__c == subscription.Bill62__End_Date__c){
                    startDate = subscription.Bill62__Last_Subscription_Line_End_Date__c.adddays(1);
                }    
            }else{
                startDate = subscription.Bill62__Last_Subscription_Line_End_Date__c.addDays(1);
            }
            system.debug('LSL end for startDate: '+startDate);
        } else { 
            startDate = subscription.Bill62__Start_Date__c;
            //system.debug('start date startDate: '+startDate);
        }
        
        Decimal flatDiscount = 0.0,percentDiscount = 0.0;          
        if(subscription.Bill62__Order__c != null){
            if(subscription.Bill62__Order__r.Bill62__Discount__c != null){
                if(subscription.Bill62__Order__r.Bill62__Discount__r.Bill62__Percent_Discount__c != null){
                    percentDiscount = subscription.Bill62__Order__r.Bill62__Discount__r.Bill62__Percent_Discount__c*0.01;
                }
            }
        }
        
        //override discounting from Subscription if set
        if(subscription.Bill62__Discount__c != null){
            if(subscription.Bill62__Discount__r.Bill62__Flat_Discount__c != null){
                flatDiscount = subscription.Bill62__Discount__r.Bill62__Flat_Discount__c;
                if(subscription.Bill62__Flat_Discount_Used__c != null){
                    flatDiscount -= subscription.Bill62__Flat_Discount_Used__c;
                }
            }
            if(subscription.Bill62__Discount__r.Bill62__Percent_Discount__c != null){
                percentDiscount = subscription.Bill62__Discount__r.Bill62__Percent_Discount__c*0.01;
            }
        }
        
        for(Bill62__Billing_Schedule_Line__c bsl : theLines){
            if(bsl.Bill62__One_Time_Fee__c){
                //make one line
                Bill62__Subscription_Line__c myLine = new Bill62__Subscription_Line__c();
                
                //do discounts if needed
                myLine.Bill62__Full_Cycle_Amount__c = bsl.Bill62__Charge_Amount__c;
                Decimal amountDiscount = 0.0;
                if(flatDiscount > 0.0){
                    if(flatDiscount >= myLine.Bill62__Full_Cycle_Amount__c){
                        amountDiscount = myLine.Bill62__Full_Cycle_Amount__c;
                        flatDiscount -= amountDiscount;
                    }else{
                        amountDiscount += flatDiscount;
                        flatDiscount = 0.0;
                    }
                }
                //system.debug('OT amountDiscount after flat: '+amountDiscount);
                if(percentDiscount > 0.0){
                    if(myLine.Bill62__Full_Cycle_Amount__c > 0.0){
                        if(myLine.Bill62__Full_Cycle_Amount__c == amountDiscount){
                            //do nothing
                        }else{
                            Decimal discountedAmount = myLine.Bill62__Full_Cycle_Amount__c - amountDiscount;
                            discountedAmount = discountedAmount*percentDiscount;
                            amountDiscount += discountedAmount;
                        }
                        
                    }
                }
                //system.debug('OT amountDiscount after percent: '+amountDiscount);
                myLine.Bill62__Amount_Discounted__c = amountDiscount;
                
                myLine.Bill62__Subscription__c = subscription.Id;
                myLine.Bill62__Billing_Frequency__c  = 'Recurring';//'One-Time';
                myLine.Bill62__Cycle_Start_Date__c = startDate.addMonths(Integer.valueOf(bsl.Bill62__Charge_Month__c));
                if(bsl.Bill62__Days_Adjustment__c != null){
                    myLine.Bill62__Cycle_Start_Date__c = myLine.Bill62__Cycle_Start_Date__c.addDays(Integer.valueOf(bsl.Bill62__Days_Adjustment__c));
                }
                myLine.Bill62__Cycle_End_Date__c = myLine.Bill62__Cycle_Start_Date__c.addDays(1);//addMonths(Integer.valueOf(bsl.Bill62__Charge_Month__c)).addDays(-1);
                
                myLine.Name = myLine.Bill62__Billing_Frequency__c + ' ' + myLine.Bill62__Cycle_Start_Date__c.format() +' - ' + myLine.Bill62__Cycle_End_Date__c.format();

                /*if(subscription.Bill62__End_Date__c != null && myLine.Bill62__Cycle_End_Date__c >= subscription.Bill62__End_Date__c){
                    //do not add the line
                    system.debug('skipping one time because its beyond end date');
                    continue;
                }*/
                if(myLine.Bill62__Cycle_Start_Date__c >= System.Date.TODAY() || allowPastLines){
                    retList.add(myLine);
                }else{
                    system.debug('one-time lines in the past, retry');
					myLine.Bill62__Cycle_Start_Date__c = myLine.Bill62__Cycle_Start_Date__c.addMonths(maximumNumberOfMonths);
					myLine.Bill62__Cycle_End_Date__c = myLine.Bill62__Cycle_Start_Date__c.addDays(1);
					if(myLine.Bill62__Cycle_Start_Date__c >= System.Date.TODAY()){
						retList.add(myLine);
					}else{
						system.debug('one-time lines in the past, skip');
					}
				}
            }
        }
        for(Bill62__Billing_Schedule_Line__c bsl : theLines){
            if(!bsl.Bill62__One_Time_Fee__c){
                Date incrementedDate = startDate;
                //system.debug('startDate '+startDate);
                //system.debug(maximumNumberOfMonths);
                //system.debug(bsl.Bill62__Charge_Month__c);
                for(Integer i = 0; i < maximumNumberOfMonths; i += Integer.valueOf(bsl.Bill62__Charge_Month__c)){
                    //system.debug(i);
                    if(i == 0){
                        //do nothing
                    }else{
                        incrementedDate = incrementedDate.addMonths(Integer.valueOf(bsl.Bill62__Charge_Month__c));
                    }
                    //system.debug('incrementedDate: '+incrementedDate);
                    
                    Bill62__Subscription_Line__c myLine = new Bill62__Subscription_Line__c();
                    
                    //do discounts if needed
                    myLine.Bill62__Full_Cycle_Amount__c = bsl.Bill62__Charge_Amount__c;
                    Decimal amountDiscount = 0.0;
                    if(flatDiscount > 0.0){
                        if(flatDiscount >= myLine.Bill62__Full_Cycle_Amount__c){
                            amountDiscount = myLine.Bill62__Full_Cycle_Amount__c;
                            flatDiscount -= amountDiscount;
                        }else{
                            amountDiscount += flatDiscount;
                            flatDiscount = 0.0;
                        }
                    }
                    //system.debug('amountDiscount after flat: '+amountDiscount);
                    if(percentDiscount > 0.0){
                        if(myLine.Bill62__Full_Cycle_Amount__c > 0.0){
                            if(myLine.Bill62__Full_Cycle_Amount__c == amountDiscount){
                                //do nothing
                            }else{
                                Decimal discountedAmount = myLine.Bill62__Full_Cycle_Amount__c - amountDiscount;
                                discountedAmount = discountedAmount*percentDiscount;
                                amountDiscount += discountedAmount;
                            }
                            
                        }
                    }
                    //system.debug('amountDiscount after percent: '+amountDiscount);
                    myLine.Bill62__Amount_Discounted__c = amountDiscount;
                    
                    myLine.Bill62__Subscription__c = subscription.Id;
                    myLine.Bill62__Billing_Frequency__c  = 'Recurring';
                    myLine.Bill62__Cycle_Start_Date__c = incrementedDate;
                    //system.debug('cycle start '+myLine.Bill62__Cycle_Start_Date__c);
                    if(bsl.Bill62__Days_Adjustment__c != null){
                        myLine.Bill62__Cycle_Start_Date__c = myLine.Bill62__Cycle_Start_Date__c.addDays(Integer.valueOf(bsl.Bill62__Days_Adjustment__c));
                        incrementedDate = incrementedDate.addDays(Integer.valueOf(bsl.Bill62__Days_Adjustment__c));
                    }
                    myLine.Bill62__Cycle_End_Date__c = incrementedDate.addMonths(Integer.valueOf(bsl.Bill62__Charge_Month__c)).addDays(-1);
                    //system.debug('cycle end '+myLine.Bill62__Cycle_End_Date__c);
                    myLine.Name = myLine.Bill62__Billing_Frequency__c + ' ' + myLine.Bill62__Cycle_Start_Date__c.format() +' - ' + myLine.Bill62__Cycle_End_Date__c.format();
                    
                    /*if(subscription.Bill62__End_Date__c != null && myLine.Bill62__Cycle_End_Date__c >= subscription.Bill62__End_Date__c){
                        //do not add the line
                        system.debug('skipping recurring because its beyond end date');
                        continue;
                    }*/
                
                    if(myLine.Bill62__Cycle_Start_Date__c >= System.Date.TODAY() || allowPastLines){
                        retList.add(myLine);
                    }else{
                        system.debug('lines in the past, skip');
                    }
                }
            }            
        }
        
        return retList;
    }
    
    
}