@isTest
 
   private class TestConsola_Compras_Controller{
       
       
      @isTest
      static void test_method_one() {
      
      String etapa = 'Antecedentes';
      
      PageReference pagina = Page.Consola_Compras;
      Test.setCurrentPage(pagina);
      Consola_Compras_Controller ctrdesa = new Consola_Compras_Controller();
      ctrdesa.cobertura();
      ctrdesa.cobertura2();
      ctrdesa.consultaRecordatorios();
      ctrdesa.guardar();
      ctrdesa.cargaLista(); 
      ctrdesa.getUser(); 
      ctrdesa.getFolios(); 
      ctrdesa.getDocsList(); 
      ctrdesa.espera(); 
      ctrdesa.llenaLista(); 
      ctrdesa.limpiar();  
      ctrdesa.queryDocumentos(etapa); 
      ctrdesa.queryIdAsignados();
      ctrdesa.queryDocsAsignados(); 
      ctrdesa.queryBitacoraDocs(); 
      
      
      ctrdesa.queryVistaSimple(); 
      ctrdesa.queryEtapas(); 
      
      
  }
       
 
 }