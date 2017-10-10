@isTest(SeeAllData=true)
private class TestDesalojoController {

    static testMethod void DesaTest() {
    
      
        
           Id devRecordTypeIdPromotor = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Promotor').getRecordTypeId();
                
        Account promotor = new Account();
        promotor.Name = 'Juan Loyola';
        promotor.RecordTypeId = devRecordTypeIdPromotor;
        promotor.Plaza__c = 'Dif-Mex';
        promotor.Beneficiario__c = 'Dif-Mex';
        promotor.CLABE__c = '000989897761222';
        promotor.Cuenta_bancaria__c = '000989897761222';
        promotor.Banco__c = 'Dif-Mex';
        insert promotor;

        Account acc = new Account();
        acc.Name = 'test';
        acc.Usuario__c = 'test';
        acc.Password__c = '12345';
        acc.Plaza__c = 'Dif-Mex';
        insert acc;

        Propiedad__c propiedad  = new Propiedad__c();
        propiedad.Name = 'test';
        propiedad.Punto__Latitude__s = 19.3352378054;
        propiedad.Punto__Longitude__s = -99.1600018862;
        propiedad.Plaza__c = 'Dif-Mex';

        insert propiedad;


        Oferta__c oferta = new Oferta__c();
        oferta.Name = 'test';
        oferta.Promotor__c = promotor.Id;
        oferta.Propiedad__c = propiedad.Id;
        insert oferta;



        ClienteOferta__c cof  =new ClienteOferta__c();
        cof.Cuenta__c = acc.Id;
        cof.Oferta__c = oferta.Id;
        insert cof;
        
        Desalojo__c desa = new Desalojo__c();
        desa.Oferta__c = oferta.Id;
        desa.Estatus__c= 'Completado';
        insert desa;
        
        
        test.startTest();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(desa);
        DesalojoController ctrdesa = new DesalojoController(sc);
        
        PageReference pagina = new PageReference('/apex/Desalojo');
        Test.setCurrentPageReference(pagina);
        ctrdesa.cargarDocumentos();
        ctrdesa.cargarDocumentosExtrajudiciales();
        ctrdesa.cargarDocumentosjudiciales();
        ctrdesa.guardar();
        ctrdesa.cobertura();
        
    }
    
   
}