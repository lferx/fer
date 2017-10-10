@isTest
 
   private class TestActualizar_Paneles_Controller{
       
       
      @isTest
      static void test_method_one() {
      
      //PageReference pagina = Page.Actualizar_Paneles;
      //Test.setCurrentPage(pagina);
      Actualizar_Paneles_Controller ctrdesa = new Actualizar_Paneles_Controller();
      ctrdesa.actualizaOferCargada();
      ctrdesa.actualizaOferCaida();
      ctrdesa.actualizaOferConEscritu();
      //ctrdesa.actualizaOferSinFechaPrev();
      ctrdesa.agregarPanel(); 
      ctrdesa.cobertura();
  }
       
 
 }