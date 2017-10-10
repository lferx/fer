@isTest
private class TEST_RTAFController {

    @isTest static void test_method_one() 
    {

        Sorteo__c sorteo = new Sorteo__c();
        sorteo.Fecha_de_inicio__c = System.today();
        sorteo.Fecha_de_fin__c = Date.today().addDays(90);
        insert sorteo;

        Preca_Web__c acc = new Preca_Web__c();
        acc.Password__c = '12345';
        acc.Email__c = 'test@gmail.com';
        acc.NSS__C = '12345678901';
        acc.Nombre__c = 'Revimex';
        acc.Apellido__c = 'Web';
        acc.Fecha_Nacimiento__c = '1980/01/10';
        insert acc;

        PageReference pageRef = Page.RTAF;
        RTAFController controller = new RTAFController();
        controller.emailAddress = 'test2@gmail.com';
        PageReference pr1 = controller.SendReferAFriendEmail();

        //name, value, path, maxAge, isSecure
        Cookie cookie = new Cookie('logged', acc.Email__c, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[]{cookie});
        pageRef.setCookies(new Cookie[]{cookie});
        PageReference pr2 = controller.SendReferAFriendEmail();
    }

}