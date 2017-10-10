@isTest
 
   private class TestCalculadoraController{
       
       
       @isTest
  static void test_method_two() {
      Calculadora__c Calculadora = new Calculadora__c();
       PageReference pagina = Page.Calculadora;
      Test.setCurrentPage(pagina);
      CalculadoraController ctrdesa = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa.cobertura();
      CalculadoraController ctrdesa2 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa2.Coberturab();
      CalculadoraController ctrdesa3 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa3.Coberturac();
      CalculadoraController ctrdesa4 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa4.Coberturad();
      CalculadoraController ctrdesa5 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa5.limpiavariables();
      CalculadoraController ctrdesa6 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa6.llenaLista();
      CalculadoraController ctrdesa7 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa7.limpiar();
      CalculadoraController ctrdesa8 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa8.exportarPaquete();
      CalculadoraController ctrdesa9 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa9.posicion=1;
      CalculadoraController ctrdesa10 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa10.folio = '';
      CalculadoraController ctrdesa11 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa11.coberturae();
      CalculadoraController ctrdesa12 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa12.coberturaf();
      CalculadoraController ctrdesa13 = new CalculadoraController(new ApexPages.StandardController(Calculadora));
      ctrdesa13.coberturah();
      
              
  }
       
 
 }