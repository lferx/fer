@isTest
private class TestSchedulerConvertLeadToAccount { 
    
    @isTest
    static void test_method_one() {
        
        Test.startTest();
        
        Sorteo__c sorteo = new Sorteo__c();
        sorteo.Fecha_de_inicio__c = System.today().addDays(-10);
        sorteo.Fecha_de_fin__c = System.today().addDays(10);
        sorteo.Name ='La casa de tus sueños';
        
        insert sorteo;
        
        Profile perfilGerenteVentas = [SELECT Id FROM Profile WHERE Name = 'Gerente de Ventas' LIMIT 1];
        
        User u = new User(Alias = 'standtst', Email='standardusertst@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = perfilGerenteVentas.Id, 
            Plaza__c = 'Dif-Mex',
            TimeZoneSidKey='America/Los_Angeles', UserName='standardusertst@testorg.com');
            
        insert u;
        
        Id devRecordTypeIdCliente  = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Cliente').getRecordTypeId();
            Id devRecordTypeIdPromotor = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
            
            Account promotor = new Account();
            promotor.Name = 'Juan Loyola';
            promotor.RecordTypeId = devRecordTypeIdPromotor;
            promotor.CLABE__c = '2321340012';
            promotor.Cuenta_bancaria__c = '0989797989898';
            promotor.Beneficiario__c = 'Rosalia';
            promotor.Banco__c ='Banamex';
            promotor.Plaza__c = 'Dif-Mex';
            
            insert promotor;
            
            Paquete__c paquete = new Paquete__c();
            paquete.Name='Paquet1';
            paquete.Etapa__c ='Oferta';
            insert paquete;
            
            
            Propiedad__c propiedad = new Propiedad__c();
            propiedad.Name = 'Las maravillas';
            propiedad.ReferenciaBanco__c = 'AA';
            propiedad.Plaza__c = 'Dif-Mex';
            propiedad.GeneraOferta__c = true;
            propiedad.Tipo__c = 'Departamento';
            propiedad.ValorCompra__c = 450000;
            propiedad.ValorReferencia__c = 450000;
            propiedad.PrecioVenta__c = 450000;
            propiedad.PaqueteOrigen__c =paquete.Id;
            propiedad.Terreno_m2__c = 100;
            propiedad.Construccion_m2__c = 80;
            propiedad.Estatus__c = 'Disponible';
            insert propiedad;
            
            Propiedad__c propiedad2 = new Propiedad__c();
            propiedad2.Name = 'Las maravillas 2';
            propiedad2.ReferenciaBanco__c = 'AA';
            propiedad2.Plaza__c = 'Dif-Mex';
            propiedad2.GeneraOferta__c = true;
            propiedad2.Tipo__c = 'Departamento';
            propiedad2.ValorCompra__c = 800000;
            propiedad.PaqueteOrigen__c =paquete.Id;
            propiedad2.ValorReferencia__c = 800000;
            propiedad2.PrecioVenta__c = 800000;
            propiedad2.Terreno_m2__c = 100;
            propiedad2.Construccion_m2__c = 80;
            propiedad2.Estatus__c = 'Disponible';
            insert propiedad2;
            
            Account cliente = new Account();
            cliente.Name = 'Juan Loyola';
            cliente.RecordTypeId = devRecordTypeIdCliente;
            cliente.CLABE__c = '2321340012';
            cliente.Cuenta_bancaria__c = '0989797989898';
            cliente.Beneficiario__c = 'Rosalia';
            cliente.Banco__c ='Banamex';
            cliente.Plaza__c = 'Dif-Mex';
            cliente.Promotor__c = promotor.Id;
            
            insert cliente;
        
        
        Lead lead = new Lead();
        lead.FirstName = 'Juan';
        lead.Credito__c = 500000;
        lead.Plaza__c = 'Dif-Mex';
        lead.LastName = 'Loyola';
        lead.Company ='SNK';
        
        insert lead;
        
        //Mediante este query ontenemos el registro de candidato interesado
        Candidato_Interesado__c canin = [SELECT Id, Interesado__c FROM Candidato_Interesado__c WHERE Lead__c =: lead.Id LIMIT 1];
        
        if(canin != null){
            canin.Interesado__c = true; 
            update canin;   
        }
        
        SchedulerConvertLeadToAccount sh1 = new SchedulerConvertLeadToAccount();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Territory Check', sch, sh1); 
        
        Test.stopTest();
        
    }

}