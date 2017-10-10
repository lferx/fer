@isTest(SeeAllData = true)
private class testTriggerAccount 
{
  


    @isTest static void CreateLeadOnUpdateMethod() 
    {
        /* Insert Preca */
        Account promotor = new Account();
        promotor.Name = 'Juan Loyola';
        promotor.Plaza__c = 'Dif-Mex';
        promotor.Beneficiario__c = 'Dif-Mex';
        promotor.CLABE__c = '000989897761222';
        promotor.Cuenta_bancaria__c = '000989897761222';
        promotor.Banco__c = 'Dif-Mex';
        promotor.Type='Lead';
        insert promotor;
        /* Update Preca */
        promotor.Name = 'Juan Loyola';
        promotor.Transforma_en_cliente__c = true;
        
        update promotor;

       
    }

}