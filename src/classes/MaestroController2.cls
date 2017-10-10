public with sharing class MaestroController2{

public List<Contact> contacts {get;set;}
public String searchString {get;set;}

public MaestroController2()
{
   searchString ='';
   doQuery();
}

 public void doQuery()
 {
    String queryString = '';
    if(searchString != null)
       queryString= '%'+searchString+'%';
       
       contacts = [select id,name from Contact where lastname like :queryString limit 10];
 
 }
   public void save()
   {
     update contacts;
   }



}