public with sharing class ColoniaImagesController 
{
    public List<Attachment> fotos {get;set;}
    public Boolean bRedirect {get;set;}
    private final Colonia__c Colonia;

    public ColoniaImagesController(ApexPages.StandardController stdController) 
    {
        this.Colonia = [SELECT Id,Name FROM Colonia__c WHERE id =: stdController.getRecord().id];
        fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :this.Colonia.Id];
        bRedirect = false;
    }
}