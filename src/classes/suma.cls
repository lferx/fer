public with sharing class suma {
    public List<oferta__c>  lista {get;set;}
    public suma(){
        lista = [SELECT AhorradoIndicadorWeb__c, AliasCompanyTxt__c FROM Oferta__c];
    }
}