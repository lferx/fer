@isTest(SeeAllData = true)
private class TestUploadImageController2 {
    
     @isTest static void test() {
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
        
                insert oferta;
            
                ClienteOferta__c co = new ClienteOferta__c();
                co.Cuenta__c = a2.Id;
                co.Oferta__c = oferta.Id;
                insert co;
            
            System.debug('## Oferta after insert: '+oferta);
    	
    	Test.startTest();
    	  ApexPages.currentPage().getParameters().put('propiedadId',pro.Id);
    	UploadImagesController2 uic2 = new UploadImagesController2();
    	PageReference set_Id12 = uic2.setId();
    	PageReference sync2 = uic2.syncFilesystemDoc();
    	Test.stopTest();
    }
}