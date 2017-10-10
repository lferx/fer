public with sharing class PropiedadImagesControllerOferta 
{
    public List<Attachment> fotos {get;set;}
    public Boolean bRedirect {get;set;}
    private final Oferta__c propiedad;

    public PropiedadImagesControllerOferta(ApexPages.StandardController stdController) 
    {
        this.propiedad = [SELECT Id,Name FROM Oferta__c WHERE id =: stdController.getRecord().id];
        fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :this.propiedad.Id];
        bRedirect = false;
    }
}