@isTest
private class TestFormularioControllerNuevo {

 static testMethod void myUnitTest1() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioVacaciones FormularioR = new FormularioCuestionarioVacaciones(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest2() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioInversionistas FormularioR = new FormularioCuestionarioInversionistas(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest3() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioCredito FormularioR = new FormularioCuestionarioCredito(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
   static testMethod void myUnitTest4() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioCredito1 FormularioR = new FormularioCuestionarioCredito1(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest5() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioInversionistas1 FormularioR = new FormularioCuestionarioInversionistas1(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest6() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioCuestionarioVacaciones1 FormularioR = new FormularioCuestionarioVacaciones1(sc);
        FormularioR.stremail = 'test11@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pedro1';
        FormularioR.strApellidoPaterno = 'pedro';
        FormularioR.strApellidoMaterno = 'pedro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
}