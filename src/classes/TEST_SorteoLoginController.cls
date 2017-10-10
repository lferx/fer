@isTest(SeeAllData=true)
public class TEST_SorteoLoginController {
    
    @isTest static void test_method_one() {

        Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Email__c = 'testrevi@gmail.com';
        acc.Password__c = '12345';
        insert acc;

        Lead le = new Lead();
        le.FirstName = 'Revi';
        le.LastName  = 'Mex';
        le.Company   = 'Revimex Web';
        le.Email    = 'testrevi2@gmail.com';
        le.Password__c    = '11223344556';
        insert le;

        Preca_Web__c pre = new Preca_Web__c();
        pre.Nombre__c       = 'Joan';
        pre.Apellido__c     = 'Vidal';
        pre.Fecha_Nacimiento__c = '1980/11/20';
        pre.Email__c          = 'testrevi3@gmail.com';
        pre.Password__c     = '22334455667';
        insert pre;

        SorteoLoginController controlador = new SorteoLoginController();


        PageReference pageRef = Page.SorteoLogin;
        pageRef.getParameters().put('logged',acc.Id);
        Test.setCurrentPage(pageRef);

        String u                      =controlador.user;
        String pass                   = controlador.pass;

        controlador.user = '1';
        controlador.pass = '1';
        PageReference login1 = controlador.login();

        controlador.user = pre.Email__c;
        controlador.pass = pre.Password__c;
        PageReference login2 = controlador.login();
        
        controlador.user = acc.Email__c;
        controlador.pass = acc.Password__c;
        PageReference login4 = controlador.login();

        controlador.user = le.Email;
        controlador.pass = le.Password__c;
        PageReference login3 = controlador.login();

        PageReference logout = controlador.logout();
    }
}