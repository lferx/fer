@isTest
private class TestInformesShell{

 public static TestMethod void test(){
    Developer__c Developer = new Developer__c();
    PageReference pagina = Page.InformesShell; 
    Test.setCurrentPage(pagina);
 
    InformesShellController controller = new InformesShellController(new ApexPages.StandardController(Developer));
    controller.Cobertura();
    
 }
}