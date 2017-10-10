public with sharing class PropiedadImagesControllerOferta2 
{
    public List<Attachment> fotos {get;set;}
    public Boolean bRedirect {get;set;}
    private final Oferta__c propiedad;

    public PropiedadImagesControllerOferta2(ApexPages.StandardController stdController) 
    {
        this.propiedad = [SELECT Id, Name, Propiedad__c FROM Oferta__c WHERE id =: stdController.getRecord().id limit 1];
        fotos = [SELECT Id,  Name FROM Attachment WHERE ParentId = :this.propiedad.Propiedad__c];
        bRedirect = false;
        
    }
}