@isTest
private class RecomendadorBaseControllerTest {
    
    @isTest
    static void test_method_one() {
       Account cuentaM = new Account();
          List<Account> lstAccount = new List<Account>();
          List<Lead> lstLead  = new List<Lead>();
          List<Preca_Web__c>lstPreca =new List<Preca_Web__c>();
          Account ejemplo1 = new Account();
          Lead ejemplo2 = new Lead();
          Preca_Web__c ejemplo3 = new Preca_Web__c();
          
          ejemplo1.Plaza__c='Puebla';
          ejemplo2.Plaza__c='Puebla';
          ejemplo3.Plaza__c='Puebla';
          ejemplo1.Name='Juan';
          ejemplo1.Email__c='Juan@revi.com';
          ejemplo3.Email__c='Juan@revi.com';
              lstAccount.add(ejemplo1);
              lstLead.add(ejemplo2);
              lstPreca.add(ejemplo3);
              
              
    List<Boleto__c> listTemp= new  List<Boleto__c>();
    Boleto__c boleta1 = new Boleto__c();
      List<Boleto__c>lstBoletosAux=new   List<Boleto__c>();
      Boleto__c boleta2 = new Boleto__c();
    List<List<Boleto__c>> lstBoletos=new List<List<Boleto__c>>();
    listTemp.add(boleta2);
    lstBoletosAux.add(boleta2);
    lstBoletos.add(lstBoletosAux);
            
 
       cuentaM.Email__c='tast@gmail.com';
       cuentaM.Usuario__c='tast@gmail.com';
       cuentaM.Type='Promotor';
       cuentaM.Tipo_promotor__c='Recomendador';
       cuentaM.Estatus__c='Activo';
       cuentaM.Phone='5543459557';
       cuentaM.Name='ya ya ya';
       cuentaM.CLABE__c='5543459557';
       cuentaM.Banco__c= 'Santander';
       cuentaM.Beneficiario__c= 'Juan';
       cuentaM.Plaza__c='Dif-Mex';
       cuentaM.Cuenta_bancaria__c='5543459557';
       insert cuentaM;
        
        ApexPages.StandardController sc = new ApexPages.standardController(cuentaM);
        RecomendadorBaseController baseClass = new RecomendadorBaseController (sc);
       
        baseClass.strNombre='Prueba';
        baseClass.strApellido='Prueba';
        baseClass.stremail='Prueba@prueba.com';
        baseClass.strplaza='Puebla';
        baseClass.strnss='123123112';
        baseClass.strtelefono='21312312313';
        baseClass.strpago='Infonavit';
        baseClass.intmonto=1231123;
        baseClass.lstAccount=lstAccount;
        baseClass.lstLead=lstLead;
        baseClass.lstPreca=lstPreca;
        baseClass.IngresaRecomendado();
        baseClass.listTemp=listTemp;
        baseClass.lstBoletosAux=lstBoletosAux;
        baseClass.lstBoletos=lstBoletos;
        baseClass.CheckIfLogged();
        baseClass.Datos();
        baseClass.logout();
    }
   
    @isTest
    static void test_method_two() {
       Account cuentaM = new Account();
    
            
 
    
        RecomendadorBaseController baseClass = new RecomendadorBaseController ();

        baseClass.strNombre=null;
        baseClass.strApellido=null;
        baseClass.stremail=null;
        baseClass.strplaza=null;
        baseClass.strnss=null;
        baseClass.strtelefono=null;
        baseClass.strpago=null;
        baseClass.intmonto=null;
        baseClass.lstAccount=null;
        baseClass.lstLead=null;
        baseClass.lstPreca=null;
     
        baseClass.listTemp=null;
        baseClass.lstBoletosAux=null;
        baseClass.lstBoletos=null;
        baseClass.strEmail=null;
        baseClass.id=null;

        baseClass.logout();
        baseClass.Datos();
        baseClass.IngresaRecomendado();
        baseClass.CheckIfLogged();
        baseClass.Datos();
        baseClass.getAccounts();
        baseClass.getOfertas();
        baseClass.CheckIfLogged();
    }
   
   
    }