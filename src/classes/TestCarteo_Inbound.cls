@isTest
 
   private class TestCarteo_Inbound{
       
       
      @isTest(SeeAllData=true)
      static void test_method_one() {
      
          PageReference pagina = Page.Carteo_Inbound;
          Test.setCurrentPage(pagina);
          Carteo_Inbound_Controller controllerCarteoInbound = new Carteo_Inbound_Controller();
          
          Oferta__c oferta = new Oferta__c();
          oferta.name = 'IF-12345678';
          oferta.ValorReferencia__c = 150000;
          INSERT oferta;
          
          controllerCarteoInbound.folio = 'IF-12345';
      
          controllerCarteoInbound.llenaLista();
          controllerCarteoInbound.limpiaLista();
          controllerCarteoInbound.eliminar();
          controllerCarteoInbound.pdf1();
          controllerCarteoInbound.pdf2();
          controllerCarteoInbound.pdf3();
          
      }
      
      
  }