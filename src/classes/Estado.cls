public class Estado {
    public static void Vendidas (Set <id> EstadoId)
    {
   list<estados__c>a=new list<Estados__c>();
        a=[SELECT id FROM estados__c where  id in:EstadoId];
        for (estados__c o : a)
        {
            o.Vendidas__c=10;
        }
 
    }
}