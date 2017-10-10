@isTest
private class TEST_RetrivePasswordController 
{
	
	@isTest static void test_method_one() 
    {
		Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Email__c = 'testrevi@gmail.com';
        acc.Password__c = '12345';
        acc.Type = 'Cliente';
        insert acc;

        Lead le = new Lead();
        le.FirstName = 'Revi';
        le.LastName  = 'Mex';
        le.Company   = 'Revimex Web';
        le.Email    = 'testrevi2@gmail.com';
        le.Password__c    = '11223344556';
        insert le;

        Sorteo__c sorteo = new Sorteo__c();
        sorteo.Fecha_de_inicio__c = System.today();
        sorteo.Fecha_de_fin__c = Date.today().addDays(90);
        insert sorteo;

        Preca_Web__c pre = new Preca_Web__c();
        pre.Nombre__c       = 'Joan';
        pre.Apellido__c     = 'Vidal';
        pre.Fecha_Nacimiento__c = '1980/11/20';
        pre.Email__c          = 'testrevi3@gmail.com';
        pre.Password__c     = '22334455667';
        insert pre;

        RetrivePasswordController  controlador = new RetrivePasswordController();

        PageReference pageRef = Page.RecoverPassword;
        Test.setCurrentPage(pageRef);

        controlador.emailAddress = '';
        PageReference p1 = controlador.SendRetrivePasswordMail();
        controlador.emailAddress = '1';
        PageReference p2 = controlador.SendRetrivePasswordMail();
        controlador.emailAddress = 'testrevi@gmail.com';
        PageReference p3 = controlador.SendRetrivePasswordMail();
        controlador.emailAddress = 'testrevi2@gmail.com';
        PageReference p4 = controlador.SendRetrivePasswordMail();
        controlador.emailAddress = 'testrevi3@gmail.com';
        PageReference p5 = controlador.SendRetrivePasswordMail();

        Account pro = new Account();
        pro.Name = 'promotor';
        pro.Usuario__c = 'promotor123';
        pro.Email__c = 'testrevi0@gmail.com';
        pro.Password__c = '12345';
        pro.Type = 'Promotor';
        upsert pro;

        controlador.usuario = '';
        PageReference s1 = controlador.SendRetrivePasswordMailPromotor();
        controlador.usuario = pro.Usuario__c;
        PageReference s2 = controlador.SendRetrivePasswordMailPromotor();
        controlador.usuario = '1';
        PageReference s3 = controlador.SendRetrivePasswordMailPromotor();
	}
	
}