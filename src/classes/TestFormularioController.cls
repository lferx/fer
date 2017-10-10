@isTest
private class TestFormularioController {

    static testMethod void myUnitTest() {
      Account acc = new Account();
        acc.Name = 't12387est';
        acc.Usuario__c = 'tes1239t';
        acc.Email__c = 'test1232@gmail.com';
        acc.Password__c = '12345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioController FormularioR = new FormularioController(sc);
        FormularioR.stremail = 'test123451@gmail.com';
        FormularioR.strnss = '28765414561';
        FormularioR.strNombre = 'pe12356dro';
        FormularioR.strApellidoPaterno = 'ped12317ro';
        FormularioR.strApellidoMaterno = 'pe12319dro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest2() {
      Account acc = new Account();
        acc.Name = 'te1231st';
        acc.Usuario__c = 'tes1231t';
        acc.Email__c = 'te123st2@gmail.com';
        acc.Password__c = '12321345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioControllerbaratasRemates FormularioR = new FormularioControllerbaratasRemates(sc);
        FormularioR.stremail = 'test1@gmail.com';
        FormularioR.strnss = '2876231235414561';
        FormularioR.strNombre = 'pe43dro';
        FormularioR.strApellidoPaterno = 'pedr123o';
        FormularioR.strApellidoMaterno = 'ped123ro';
        FormularioR.strplaza = 'Dif-Mex';
        FormularioR.strtelefono = 'Dif-5543459557';
        FormularioR.strtelefonoCasa = 'Dif-5543459557';
        FormularioR.fechaNacimiento = System.today().addYears(-18);
        FormularioR.InsertarLead();
        
    }
    static testMethod void myUnitTest3() {
      Account acc = new Account();
        acc.Name = 't12334est';
        acc.Usuario__c = 't123est';
        acc.Email__c = 'tes123t2@gmail.com';
        acc.Password__c = '12312345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioControllerbaratas FormularioR = new FormularioControllerbaratas(sc);
        FormularioR.stremail = 'test1231@gmail.com';
        FormularioR.strnss = '28765412314561';
        FormularioR.strNombre = 'ped123ro';
        FormularioR.strApellidoPaterno = 'ped123ro';
        FormularioR.strApellidoMaterno = 'p123edro';
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
        FormularioControllerbaratasAdjudicadas FormularioR = new FormularioControllerbaratasAdjudicadas(sc);
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
        FormularioControllerFacebook FormularioR = new FormularioControllerFacebook(sc);
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
        FormularioCuestionarioController FormularioR = new FormularioCuestionarioController(sc);
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
    
    static testMethod void myUnitTest7() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioEmpresa FormularioR = new FormularioEmpresa(sc);
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
    
    static testMethod void myUnitTest8() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioDesalojadores FormularioR = new FormularioDesalojadores(sc);
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
    static testMethod void myUnitTest9() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioVacaciones FormularioR = new FormularioVacaciones(sc);
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
        static testMethod void myUnitTest10() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioInversionistas FormularioR = new FormularioInversionistas(sc);
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
    static testMethod void myUnitTest11() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioDesalojadores1 FormularioR = new FormularioDesalojadores1(sc);
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
    static testMethod void myUnitTest12() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioVacaciones1 FormularioR = new FormularioVacaciones1(sc);
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
        static testMethod void myUnitTest13() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioInversionistas1 FormularioR = new FormularioInversionistas1(sc);
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
     static testMethod void myUnitTest14() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        Formularioinversion FormularioR = new Formularioinversion(sc);
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
    
    static testMethod void myUnitTest15() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioAprovecha FormularioR = new FormularioAprovecha(sc);
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
    
     static testMethod void myUnitTest16() {
      Account acc = new Account();
        acc.Name = 'te23st';
        acc.Usuario__c = 'te1st';
        acc.Email__c = 'te1st2@gmail.com';
        acc.Password__c = '121345';
        acc.Registrado__c = false;
        insert acc;
        ApexPages.StandardController sc = new ApexPages.standardController(acc);
        FormularioAprovecha1 FormularioR = new FormularioAprovecha1(sc);
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