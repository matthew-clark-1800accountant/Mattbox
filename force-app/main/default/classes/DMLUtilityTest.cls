/**
 * Created by SReyes on 8/3/2020.
 */
@IsTest
public with sharing class DMLUtilityTest
{

    private static Account[] accountMaker()
    {
        Account[] actList = new Account[0];

        for(Integer i = 0; i < 8; i++)
        {
            actList.add(new Account(Name='test'+i));
        }

        return actList;
    }

    @TestSetup
    private static void testDMLUtility()
    {
        insert accountMaker();
    }

    @IsTest
    private static void testInsert()
    {
        System.debug('testing account insert');
        Account[] actList = accountMaker();
        Test.startTest();
            new DMLUtility(actList, DMLUtility.DMLType.INSERTS, 'insertTest').execute(null);
        Test.stopTest();
    }

    @IsTest
    private static void testUpdate()
    {
        Account[] actList = [SELECT Id FROM Account];
        for(Account act : actList){ act.Phone = '909-090-9090'; }
        Test.startTest();
        new DMLUtility(actList, DMLUtility.DMLType.UPDATES, 'insertTest').execute(null);
        Test.stopTest();
    }

    @IsTest
    private static void testDelete()
    {
        Account[] actList = [SELECT Id FROM Account];
        Id[] ids = new Id[0];
        for(Account act : actList){ ids.add(act.Id); }

        Test.startTest();
        new DMLUtility(ids,'insertTest').execute(null);
        Test.stopTest();
    }
}