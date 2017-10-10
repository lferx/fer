@isTest
 
   private class TestConsola_Pendientes_Controller{
       
       
      @isTest
      static void test_method_one() {
      
      String etapa = 'Cierre oferta';
      
      PageReference pagina = Page.Consola_Pendientes;
      Test.setCurrentPage(pagina);
      Consola_Pendientes_Controller ctrdesa = new Consola_Pendientes_Controller();
      ctrdesa.cobertura();
      ctrdesa.cobertura2();
      ctrdesa.consultaRecordatorios();
      ctrdesa.guardar();
      ctrdesa.cargaLista(); 
      ctrdesa.getUser(); 
      ctrdesa.getFolios(); 
      ctrdesa.getDocsList(); 
      //ctrdesa.panelAdmin(); 
      //ctrdesa.completaBitacora(); 
      ctrdesa.espera(); 
      ctrdesa.llenaLista(); 
      ctrdesa.limpiar(); 
      ctrdesa.queryDocumentosEspera(); 
      ctrdesa.queryDocumentos(etapa); 
      ctrdesa.queryIdAsignados();
      ctrdesa.queryDocsAsignados(); 
      ctrdesa.queryBitacoraDocs(); 
      
      
      //ctrdesa.queryVistaSimple(); 
      //ctrdesa.queryEtapas(); 
      
      
  }
       
 
 }