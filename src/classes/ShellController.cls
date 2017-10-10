global with sharing class ShellController{

public List<Attachment>fotos{get;set;}
public Boolean Mamaso{get;set;}
private final Shell_pueba__c propiedad;

public ShellController(ApexPages.StandardController Controller)
{
      this.propiedad =[Select id,Name from Shell_pueba__c where id=: Controller.getRecord().id];
      fotos=[select id,Name from attachment where parentid =:this.propiedad.id];
      Mamaso= false;
}
}