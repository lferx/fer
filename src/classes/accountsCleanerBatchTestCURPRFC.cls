@isTest

    public class accountsCleanerBatchTestCURPRFC

    {

        static testMethod void testMethod1()

        {

            List<Account> lstAccount= new List<Account>();

            for(Integer i=10 ;i <20;i++)

            {

                Account acc = new Account();

                acc.Name ='Name'+i;
                acc.Numero_de_Seguro_Social__c ='123456789'+i;
                acc.RFC__c ='MOLH88011'+i;
                acc.CURP__c ='MOLH880113HDFRPC0'+i;

                lstAccount.add(acc);

                Account acc2 = new Account();

                acc2.Name ='Name'+i;
                acc2.Numero_de_Seguro_Social__c ='123456789'+i;
                acc2.RFC__c ='MOLH88011'+i;
                acc2.CURP__c ='MOLH880113HDFRPC0'+i;

                lstAccount.add(acc2);

            }
                Account acc3 = new Account();

                acc3.Name ='Name';
                acc3.Numero_de_Seguro_Social__c ='12345678930';
                acc3.RFC__c ='MOLH880133';
                acc3.CURP__c ='MOLH880113HDFRPC30';

                lstAccount.add(acc3);

            insert lstAccount;

            Test.startTest();
                accountsCleanerBatchCURP objCURP = new accountsCleanerBatchCURP();
                DataBase.executeBatch(objCURP,100);
                accountsCleanerBatchRFC objRFC = new accountsCleanerBatchRFC();
                DataBase.executeBatch(objRFC,100);
            Test.stopTest();
        }
    }