@isTest
private class RecomendadorControllerTest {
    
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
                
        insert preca;
        
        ApexPages.StandardController sc = new ApexPages.standardController(preca);
        RecomendadorController precaClass = new RecomendadorController (sc);
        
        precaClass.lstPrec = preca;
        precaClass.strcalle = 'domino';
        precaClass.strcodigoPostal = '15510';
        precaClass.strcolonia = 'loma';
        precaClass.strestado = 'oaxaca';
        precaClass.strexterior = '1';
        precaClass.strinterior = '2';
        precaClass.stremail = 'tast@gmail.com';
        precaClass.strnss = '28765414561';
        precaClass.strNombre = 'pedro';
        precaClass.strPassword = '22222';
        precaClass.strPasswordReapet = '22222';
        precaClass.strplaza = 'Dif-Mex';
        precaClass.strtelefono = '5543459557';
        precaClass.strtelefonoCasa = '5543459557';
        precaClass.fechaNacimiento = System.today().addYears(-18);
        precaClass.labelRecomendador='va';
        precaClass.labelPromotor='va';
        precaClass.labelActivo='va';
        precaClass.strCuenta='65264';
        precaClass.strBanco='bancomer';
        precaClass.intmonto=2536735;
        precaClass.strApellido='j';
        precaClass.lada='0';
        precaClass.upsertPreca();
       

        preca.Califica__c = true;
        update preca;
       
       
    }
    @isTest
    static void test_method_three(){
  Preca_Web__c preca = new Preca_Web__c();
     
        ApexPages.StandardController sc = new ApexPages.standardController(preca);
        RecomendadorController precaClass = new RecomendadorController (sc);
        
        precaClass.logout();
         precaClass.ingresaCuentaRecomendador(); 
        
    }
    @isTest
    static void test_method_two() {
        
        
        Preca_Web__c preca = new Preca_Web__c();
        preca.NSS__c = '12345678923';
        preca.Plaza__c = 'Dif-Mex';
        preca.Nombre__c = 'Juan';
        preca.Estado__c = 'Oaxaca';
        preca.Fecha_Nacimiento__c = system.today().format();
        preca.Apellido__c = 'juan';
        preca.Email__c='Ars@gmail.com';
                
    
        ApexPages.StandardController sc = new ApexPages.standardController(preca);
        RecomendadorController precaClass = new RecomendadorController (sc);
        
        precaClass.strcalle = 'domino';
        precaClass.strcodigoPostal = '15510';
        precaClass.strcolonia = 'loma';
        precaClass.strestado = 'oaxaca';
        precaClass.strexterior = '1';
        precaClass.strinterior = '2';
        precaClass.stremail = 'tast@gmail.com';
        precaClass.strnss = '28765414561';
        precaClass.strNombre = 'pedro';
        precaClass.strPassword = '22222';
        precaClass.strPasswordReapet = '2222';
        precaClass.strplaza = 'Dif-Mex';
        precaClass.strtelefono = '5543459557';
        precaClass.strtelefonoCasa = '5543459557';
        precaClass.fechaNacimiento = System.today().addYears(-18);
        precaClass.labelRecomendador='va';
        precaClass.labelPromotor='va';
        precaClass.labelActivo='va';
        precaClass.strCuenta='65264';
        precaClass.strBanco='bancomer';  
        precaClass.intmonto=2536735;   
        precaClass.strApellido='j';
        precaClass.ingresaCuentaRecomendador();   
        precaClass.lada='0';
        precaClass.upsertPreca();
        preca.Califica__c = true;
        
        
        precaClass.cuentaM = new Account();
        precaClass.cuentaM.Email__c ='tast@gmail.com';
        precaClass.cuentaM.Usuario__c ='tast@gmail.com';
        precaClass.cuentaM.Type ='Promotor';
        precaClass.cuentaM.Tipo_promotor__c ='Recomendador';
        precaClass.cuentaM.Estatus__c ='Activo';
        precaClass.cuentaM.Phone ='5543459557';
        precaClass.cuentaM.Name ='ya ya ya';
        precaClass.cuentaM.CLABE__c='5543459557';
        precaClass.cuentaM.Banco__c= 'Santander';
        precaClass.cuentaM.Beneficiario__c= 'Juan';
        precaClass.cuentaM.Numero_de_Seguro_Social__c= '28765414561';
        precaClass.cuentaM.Plaza__c='Dif-Mex';
        precaClass.cuentaM.Cuenta_bancaria__c='5543459557';
        precaClass.ingresaCuentaRecomendador();
        insert precaClass.cuentaM;
    }
     @isTest
    static void test_method_four() {
        
        
    Account lstAccount = new Account();
    
    lstAccount.Name='asdad';
    lstAccount.Email__c='juan@juan.com';
    lstAccount.Numero_de_Seguro_Social__c='234324324';
    lstAccount.Plaza__c='Puebla';
    
    Lead lstLead = new Lead();
    lstLead.FirstName='asdasd';lstLead.Email='asda';lstLead.NSS__c='212312';lstLead.Plaza__c='Puebla'; 
    Account cliente= new Account();
    Propiedad__c propiedad = new Propiedad__c();
    Boleto__c lstBoletos = new Boleto__c();
    
        Preca_Web__c preca = new Preca_Web__c();
        preca.NSS__c = '12345678923';
        preca.Plaza__c = 'Dif-Mex';
        preca.Nombre__c = 'Juan';
        preca.Estado__c = 'Oaxaca';
        preca.Fecha_Nacimiento__c = system.today().format();
        preca.Apellido__c = 'juan';
        preca.Email__c='Ars@gmail.com';
       Preca_Web__c lstPreca = preca;
          
        insert preca;
        List<Account> ejemplo = new List<Account>();
        List<Lead> ejemplo2 = new List<Lead>();
        List<Preca_Web__c> ejemplo3 = new List<Preca_Web__c>();
        ejemplo.add(lstAccount);
        ejemplo2.add(lstLead);
        ejemplo3.add(preca);
        
         ApexPages.StandardController sc = new ApexPages.StandardController(preca);
         
        RecomendadorController precaClass = new RecomendadorController (sc);
        precaClass.lstAccount = ejemplo;
        precaClass.lstLead = ejemplo2;
        precaClass.lstPreca = ejemplo3;
        
        precaClass.Boletos();
       
        
    }
     @isTest
    static void test_method_five() {
        
        
    Account lstAccount = new Account();
    
    lstAccount.Name='asdad';
    lstAccount.Email__c='juan@juan.com';
    lstAccount.Numero_de_Seguro_Social__c='234324324';
    lstAccount.Plaza__c='Puebla';
    
    
    
    
    Lead lstLead = new Lead();
    lstLead.FirstName='asdad';lstLead.Email='asda@asda.com';lstLead.NSS__c='212312';lstLead.Plaza__c='Puebla'; 
    Account cliente= new Account();
    Propiedad__c propiedad = new Propiedad__c();
    Boleto__c lstBoletos = new Boleto__c();
    
        Preca_Web__c preca = new Preca_Web__c();
        preca.NSS__c = '12345678923';
        preca.Plaza__c = 'Dif-Mex';
        preca.Nombre__c = 'Juan';
        preca.Estado__c = 'Oaxaca';
        preca.Fecha_Nacimiento__c = system.today().format();
        preca.Apellido__c = 'juan';
        preca.Email__c = 'Ars@gmail.com';
       Preca_Web__c lstPreca = preca;
          
        insert preca;
        List<Account> ejemplo = new List<Account>();
        List<Lead> ejemplo2 = new List<Lead>();
        List<Preca_Web__c> ejemplo3 = new List<Preca_Web__c>();
        ejemplo.add(lstAccount);
        ejemplo2.add(lstLead);
        ejemplo3.add(preca);
        
         ApexPages.StandardController sc = new ApexPages.standardController(preca);
         
        RecomendadorController precaClass = new RecomendadorController (sc);
        precaClass.lstAccount=ejemplo;
        precaClass.lstLead=ejemplo2;
        precaClass.lstPreca=ejemplo3;
        
        
        precaClass.Boletos();
       
        precaClass.CheckIfLogged();
    }

}