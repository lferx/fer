public with sharing class AAAAMaestroController {

public List<Contact> contacts {get;set;}
public String searchString {get;set;}
public List<Oferta__c> contacts2 {get;set;}


public AAAAMaestroController()
{
   searchString ='';
   doQuery();
   contacts2 = [select id,name,Escritu__c from Oferta__c limit 10];
}

 public void doQuery()
 {
    String queryString = '';
    if(searchString != null)
       queryString= '%'+searchString+'%';
       
       contacts = [select id,name,email,phone from Contact where lastname like :queryString limit 10];
 
 }
   public void save()
   {
     update contacts2;
   }
}