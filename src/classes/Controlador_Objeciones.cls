public class Controlador_Objeciones{

public Map<String,Objecion__c> objeciones {get;set;}
public Map<String,Script__c> scripts {get;set;}
//public Script__c script {get;set;}
//public Account nuevoLead {get;set;}    
public String pasoName {get;set;}

    //*************controlador de objeciones *********************
    public Controlador_objeciones(){
           Id idRegistro = ApexPages.currentPage().getParameters().get('id');
        
        List<Objecion__c> listaObjeciones = [SELECT  Name, Mensaje__c FROM Objecion__c];
        List<Script__c> listaScripts = [SELECT Name, Mensaje__c FROM Script__c];
        
    objeciones = new Map<String,Objecion__c>();
    scripts = new Map<String, Script__c>();
        for(Objecion__c obj : listaObjeciones){
             objeciones.put(obj.Name, obj);
        }
        for(Script__c scri : listaScripts){
             scripts.put(scri.Name, scri);
        }
    }
    //*******************fin de controlador de objeciones**************************
}