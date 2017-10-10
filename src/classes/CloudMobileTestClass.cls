@isTest(SeeAllData = true)
private class CloudMobileTestClass 
{
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';


    @isTest static void CreateLeadOnUpdateMethod() 
    {   
		Sorteo__c sorteo = new Sorteo__c();
		sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
		sorteo.Fecha_de_fin__c = System.today().addDays(10);
		sorteo.Name ='La casa de tus sueños';
		
		insert sorteo;



        Lead lead = new Lead();
        lead.firstName = 'test';
        lead.LastName = 'test';
        lead.Company = 'test';
        lead.email = 'emoran@cloudmobile.com.mx';
        insert lead;

        lead.lastname = 'other';
        update lead;
        /* Insert Preca */
        Preca_Web__c p = new Preca_Web__c();
        p.Phone__c = '5555555555';
        p.Nombre__c = 'Alejo';
        p.Apellido__c = 'Perez';
        p.Plaza__c = 'Cancun';
        p.Credito__c = 500000;
        p.Fecha_Nacimiento__c = '1980/11/20';
        p.NSS__c = '12341618907';
        p.Email__c = 'test0005@revimex.com';

        insert p;


        /* Update Preca */
        p.Califica__c = true;
        update p;

        Lead l = [SELECT Plaza__c FROM Lead WHERE NSS__c = '12341618907'];
        System.assertEquals('Cancun', l.Plaza__c);


        PrecaWebController pwc = new PrecaWebController();

        pwc.precaId = p.Id;
        pwc.precs = new List<Preca_Web__c>();

        
        //Inject url parameter
        ApexPages.currentPage().getParameters().put('precaId',p.Id);
       
        System.debug('### URL parameter: '+ApexPages.currentPage().getParameters().get('precaId'));

        PageReference set_Id = pwc.setId();
        pwc.search();
        pwc.precs.add(p);
        PageReference up = pwc.updatePreca();
        pwc.clear();
        PageReference create_preca = pwc.createPreca();
        List<SelectOption> op = pwc.getPlazaOptions();
        
         l.Plaza__c = 'Dif-Mex';
        update l;

    }

    @isTest static void LeadWebTriggerMethod() 
    {
         
		Sorteo__c sorteo = new Sorteo__c();
		sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
		sorteo.Fecha_de_fin__c = System.today().addDays(10);
		sorteo.Name='La casa de tus sueños';
		
		insert sorteo;
		
        /* Insert Preca */
        Preca_Web__c p = new Preca_Web__c();
        p.Phone__c = '5555555555';
        p.Nombre__c = 'Alejo';
        p.Apellido__c = 'Perez';
        p.Plaza__c = 'Cancun';
        p.Credito__c = 500000;
        p.Fecha_Nacimiento__c = '26/05/1970';
        p.NSS__c = '12341618909';
        p.Email__c = 'test0004@revimex.com';

        insert p;

        Lead lead = new Lead();
        lead.firstName = 'test';
        lead.LastName = 'test';
        lead.Company = 'test';
        lead.email = 'emoran@cloudmobile.com.mx';
        lead.NSS__c = '12341618901';
        lead.Plaza__c = 'Cancun';
        insert lead;
       

        /* Update Preca */
        p.Califica__c = true;
        update p;

        Lead l = [SELECT Plaza__c FROM Lead WHERE NSS__c = '12341618909'];
        //System.assertEquals('Cancun', l.Plaza__c);
        l.Estatus_Llamada__c = 'Contestada Exitosamente';
        update l;

    }


    /*@isTest static void testSC() 
    {
        Lead l = new Lead();
        l.FirstName = 'Adrian';
        l.LastName = 'Perez';
        l.Plaza__c = 'Dif-Mex';
        l.Credito__c = 3000000;
        l.NSS__c = '12345678901';
        l.Fecha_Nacimiento__c = '1980-20-02';
        l.Company = 'Revimex Web';
        l.Email = 'adrian.perez@revimex.com';
        l.Estatus_Llamada__c = 'Seguimiento';
        insert l;
        Test.startTest();
        MailerController mc = new MailerController();
        mc.sendSeguimientoEmail();
        l.Email = '';
        update l;
        mc.sendSeguimientoEmail();
        Test.stopTest();
   }*/

   @isTest static void TestCheckIn() 
    {
        Propiedad__c p = new Propiedad__c();
        p.Name = '85868483';
        insert p;
        Test.startTest();
        CheckInController c = new CheckInController();
        ApexPages.currentPage().getParameters().put('propiedadId',p.Id);
        PageReference set_Id = c.setId();
        p.Punto__Latitude__s = 19.432632;
        p.Punto__Longitude__s = -99.133298;
        update p;
        PageReference set_Id2 = c.setId();
        c.searchstring = '85868483';
        c.search();
        PageReference up = c.updatePropiedad();
        c.clear();
        Test.stopTest();
   }

    @isTest static void TestLoginAndLogOutImagesUpload() 
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Ventas'];
        Profile p2 = [SELECT Id FROM Profile WHERE Name='Administrador del sistema'];
        User u = new User(Alias = 'ventas', Email='ventas@testorgdxs.com',
            EmailEncodingKey='UTF-8', LastName='Vetnas', LanguageLocaleKey='es',
            LocaleSidKey='es', ProfileId = p.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='ventas@testorgdxs.com');

        User ad = new User(Alias = 'admin2', Email='admin@testorgdxs.com',
            EmailEncodingKey='UTF-8', LastName='Admin2', LanguageLocaleKey='es',
            LocaleSidKey='es', ProfileId = p2.Id,
            TimeZoneSidKey='America/Los_Angeles', UserName='admin@testorgdxs.com');
        Propiedad__c pro = new Propiedad__c();
        pro.Name = '85868483';
        insert pro;
        

         System.runAs(u) {
            Account a = new Account();
            a.TipoPersona__c = 'Física';
            a.Type = 'Promotor';
            a.Phone = '5510110220';
            a.Usuario__c = 'revimex';
            a.Password__c = '123456';
            a.Email__c = 'ventas@testorgdxs.com';
            a.Name = 'Revimex';
            insert a;
            a.Email__c = 'ventas@testorgdxs2.com';
            update a;

            Account a2 = new Account();
            a2.TipoPersona__c = 'Física';
            a2.Type = 'Cliente';
            a2.Phone = '5510110220';
            a2.Email__c = 'persona@testorgdxs.com';
            a2.Name = 'Persona1';
            insert a2;
            Oferta__c oferta = new Oferta__c();
            oferta.Name = 'Oferta-85868483';
            oferta.Propiedad__c = pro.Id;
            oferta.Estatus__c = 'En proceso';
            oferta.Etapa__c = 'Oferta';
            oferta.Proceso__c = 'Compra';
            System.debug('## Oferta: '+oferta);
            System.runAs(ad) {
                insert oferta;
                //Oferta__c ofe = [SELECT Id FROM Oferta__c LIMIT 1];
                ClienteOferta__c co = new ClienteOferta__c();
                co.Cuenta__c = a2.Id;
                co.Oferta__c = oferta.Id;
                insert co;
            }
            System.debug('## Oferta after insert: '+oferta);


            Test.startTest();
            CheckInController c = new CheckInController();
            UploadImagesController uic = new UploadImagesController();
            c.login();
            c.getPromotorAccounts();
            c.CheckIfLogged();
            c.user = 'revimex';
            c.pass = '123456';
            c.login();
            c.getPromotorAccounts();
            Account acc = c.promotor;
            Account acc2 = uic.promotor;
            c.logout();
            ApexPages.currentPage().getParameters().put('propiedadId',pro.Id);
            PageReference set_Id = c.setId();
            PageReference set_Id1 = uic.setId();
            pro.Punto__Latitude__s = 19.432632;
            pro.Punto__Longitude__s = -99.133298;
            update pro;
            PageReference set_Id2 = c.setId();
            PageReference set_Id3 = uic.setId();

            ApexPages.currentPage().getParameters().put('fileName','Test');
            ApexPages.currentPage().getParameters().put('fileSize','100');
            uic.fileName = ApexPages.currentPage().getParameters().get('fileName');
            uic.fileSize = integer.valueof(ApexPages.currentPage().getParameters().get('fileSize'));
            PageReference sync = uic.syncFilesystemDoc();

            //CTC class covering
            Map<String,RecordType> m1 = Constants.MAP_RECORDTYPES_DEVNAME;
            Map<String,Map<String,DocumentoEtapa__c>> m2 = Constants.MAP_DOCUMENTOS_ETAPA;
            delete a;
            undelete a;

            TriggerHandler.bypass('TriggerGastoHandler');
            TriggerHandler.clearBypass('TriggerGastoHandler');
            TriggerHandler.isBypassed('TriggerGastoHandler');
            TriggerHandler.clearAllBypasses();
            TriggerHandler th = new TriggerHandler();
            th.setMaxLoopCount(5);
            th.TestLoopCount(5);
            th.clearMaxLoopCount();
            Test.stopTest();
        }
   }

}