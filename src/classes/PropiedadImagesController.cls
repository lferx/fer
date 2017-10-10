public with sharing class PropiedadImagesController 
{
    public List<Attachment> fotos {get;set;}
    public Boolean bRedirect {get;set;}
    private final Propiedad__c propiedad;

    public PropiedadImagesController(ApexPages.StandardController stdController) 
    {
        this.propiedad = [SELECT Id,Name FROM Propiedad__c WHERE id =: stdController.getRecord().id];
        fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :this.propiedad.Id];
        bRedirect = false;
    }
}