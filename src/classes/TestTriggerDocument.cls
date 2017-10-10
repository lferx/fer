@isTest(SeeAllData = true)

private class TestTriggerDocument {
  
  @isTest 
  static void test_method_one() {
    
    Account cliente = [SELECT Id,Name FROM Account LIMIT 1];
    
    
      
    
    Propiedad__c propiedad = new Propiedad__c();
    propiedad.Name = 'Las maravillas';
    propiedad.ReferenciaBanco__c = 'AA';
    propiedad.Plaza__c = 'Dif-Mex';
    propiedad.GeneraOferta__c = true;
    propiedad.Tipo__c = 'Departamento';
    propiedad.ValorCompra__c = 1000000;
    propiedad.ValorReferencia__c = 1000000;
    propiedad.PrecioVenta__c = 1000000;
    propiedad.Terreno_m2__c = 100;
    propiedad.Construccion_m2__c = 80;
    propiedad.Estatus__c = 'Disponible';
    insert propiedad;
    
    
                        
    Etapa__c etapa1 = new Etapa__c();
    etapa1.Name = 'Eatapa de prueba';
    etapa1.NumEtapa__c = 30;
    etapa1.EstatusOferta__c = 'Venta';
    etapa1.Activa__c = true;
    etapa1.Etapa__c ='Oferta';
    etapa1.Descripcion__c ='Test';
    etapa1.Descripcion2__c = 'Test';
    etapa1.Seriada__c = true;
    
    insert etapa1;
    
    List<Oferta__c> ofertas = [SELECT Id,Name FROM Oferta__c WHERE Propiedad__c =: propiedad.Id];
    
            
    EtapaOferta__c etapaOferta = new EtapaOferta__c();
    etapaOferta.Oferta__c = ofertas[0].Id ;
    etapaOferta.Etapa__c = etapa1.Id ;
    etapaOferta.HoraInicial__c = System.now() ;
    etapaOferta.HoraFinal__c = System.now().addDays(12) ;
    etapaOferta.FechaCierre__c = System.today().addDays(13) ;
    etapaOferta.Estatus__c = 'Abierta';
    
    insert etapaOferta;
    Test.startTest();
    SolicitudPago__c solicitud = new SolicitudPago__c();
    solicitud.Account__c = cliente.Id;
    
    insert solicitud;
    
    DocumentoEtapa__c documentoE =new DocumentoEtapa__c();
    documentoE.Name = 'Comprobante pago';
    documentoE.Etapa__c = etapa1.Id;
    documentoE.Tipo__c = 'Documento';
    insert documentoE;
    
    ConceptoCatalogo__c concepto = new ConceptoCatalogo__c();
    concepto.Name = 'Comprobante pago';
    concepto.ObjetoSuma__c ='Oferta__c';
    concepto.CampoSuma__c ='ComisionComercial__c';
    concepto.DocEtapa_ComprobantePago__c = documentoE.Id;
    
    insert concepto;
    
    Gasto__c gasto = new Gasto__c();
    gasto.Oferta__c = ofertas[0].Id;
    gasto.EtapaOferta__c = etapaOferta.Id;
    gasto.SolicitudPago__c = solicitud.Id;
    gasto.Account__c = cliente.Id;
    gasto.Fecha__c = System.today();
    gasto.Importe__c = 10000;
    gasto.Concepto__c = concepto.Id;
    
    insert gasto;
    
    
    Documento__c documento = new Documento__c();
    documento.SolicitudPago__c = solicitud.Id;
    documento.EtapaOferta__c=etapaOferta.Id;
    documento.Tipo__c='Comprobante pago';
    documento.TipoGasto__c='Comprobante pago';
    documento.Name='Comprobante pago';
    documento.ValorAvaluo__c=10000;
    documento.NumFiles__c=1;
    documento.Gasto__c = gasto.Id;
    documento.Cuenta__c=cliente.Id;
    documento.Oferta__c=ofertas[0].Id;
    documento.DocumentoEtapa__c = documentoE.Id;

    
    insert documento;
    
    
    
    Blob b = Blob.valueOf('Test Data');
    Attachment attachment = new Attachment();
    attachment.ParentId = documento.Id;
    attachment.Name = 'Test Attachment for Parent';
    attachment.Body = b;
    
    insert(attachment);
    Test.stopTest();
    //upsert documento;
    //delete documento;    
    //undelete documento;
  }
  
  @isTest 
  static void test_method_two() {
    
    Documento__c Documuento = [SELECT Id FROM Documento__c LIMIT 1];
    
    Test.startTest();
    upsert Documuento;
    Test.stopTest();
  }
  
  @isTest 
  static void test_method_trhee() {
    
    Documento__c Documuento = [SELECT Id FROM Documento__c LIMIT 1];
    Test.startTest();
    delete Documuento;
    Test.stopTest();
  }
  
  @isTest 
  static void test_method_four() {
    
    Documento__c Documuento = [SELECT Id FROM Documento__c LIMIT 1];
    Test.startTest();
    delete Documuento;
    
    undelete Documuento;
    Test.stopTest();
  }
  

}