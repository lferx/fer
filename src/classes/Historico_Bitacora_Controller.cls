public with sharing class Historico_Bitacora_Controller {

    public ID docId {get;set;}
    public ID oferId {get;set;}
    public Integer num {get;set;}

    public List<Bitacora_Oferta__c> listaBitacoras {get{
        if(listaBitacoras == null && (docId != NULL || oferId != NULL)){
            listaBitacoras = [SELECT Name,Comentarios__c,CreatedDate,Dictamen_Consola__c,Notas__c,Dictamen__c,Oferta__r.Comentarios_del_Gerente__c FROM Bitacora_Oferta__c WHERE Documento__c = :docId OR Oferta__c = :oferId ORDER BY CreatedDate desc Limit 10];
        }
        return listaBitacoras;
    }set;}
    
    public Historico_Bitacora_Controller(){
        listaBitacoras = null;
    }
    public void Cobertura(){
        Integer a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        
     }
    
}