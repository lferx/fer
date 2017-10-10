@isTest
private class TestPrecaRegisterController {
    
    @isTest
    static void test_method_one() {
        
        Sorteo__c sorteo = new Sorteo__c();
        sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
        sorteo.Fecha_de_fin__c = System.today().addDays(10);
        sorteo.Name='La casa de tus sueños';
        
        insert sorteo;
        
        Preca_Web__c preca = new Preca_Web__c();
        
        preca.NSS__c = '12345678923';
        preca.Plaza__c = 'Dif-Mex';
        preca.Nombre__c = 'Juan';
        preca.Estado__c = 'Oaxaca';
        preca.Fecha_Nacimiento__c = system.today().format();
        preca.Apellido__c = 'juan';
        preca.Phone__c = '5555555555';
        preca.Registrado__c = false;
                
        insert preca;

        Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Email__c = 'test2@gmail.com';
        acc.Password__c = '12345';
        acc.Registrado__c = false;
        insert acc;
        
        
        ApexPages.StandardController sc = new ApexPages.standardController(preca);
        PrecaRegisterController precaClass = new PrecaRegisterController (sc);
        
        precaClass.strcalle = 'domino';
        precaClass.strcodigoPostal = '15510';
        precaClass.strcolonia = 'loma';
        precaClass.strestado = 'oaxaca';
        precaClass.strexterior = '1';
        precaClass.strinterior = '2';
        precaClass.stremail = 'test1@gmail.com';
        precaClass.strnss = '28765414561';
        precaClass.strNombre = 'pedro';
        precaClass.strPassword = '22222';
        precaClass.strPasswordReapet = '2222';
        precaClass.strplaza = 'Dif-Mex';
        precaClass.strtelefono = 'Dif-5543459557';
        precaClass.strtelefonoCasa = 'Dif-5543459557';
        precaClass.fechaNacimiento = System.today().addYears(-18);
        
        precaClass.upsertPreca();

        precaClass.strPasswordReapet = '22222';
        precaClass.upsertPreca();

        precaClass.stremail = 'test2@gmail.com';
        precaClass.upsertPreca();

        precaClass.stremail = 'test1@gmail.com';
        precaClass.upsertPreca();

        precaClass.stremail = 'test2@gmail.com';
        precaClass.upsertPreca();

        precaClass.stremail = 'test1@gmail.com';
        precaClass.upsertPreca();

        
        preca.Califica__c = true;
        update preca;
    }
    

}