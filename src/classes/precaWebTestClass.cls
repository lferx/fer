@isTest(SeeAllData = true)
private class precaWebTestClass 
{
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';


    @isTest static void CreateLeadOnUpdateMethod() 
    {
        /* Insert Preca */
        Preca_Web__c p = new Preca_Web__c();
        p.Nombre__c = 'Alejo';
        p.Apellido__c = 'Perez';
        p.Plaza__c = 'Cancun';
        p.Credito__c = 500000;
        p.Fecha_Nacimiento__c = '26/05/1970';
        p.NSS__c = '12341618902';
        p.Email__c = 'test0001@revimex.com';

        insert p;

       

        /* Update Preca */
        p.Califica__c = true;
        update p;

       
    }

}