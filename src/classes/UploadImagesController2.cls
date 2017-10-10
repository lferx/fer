public class UploadImagesController2 
{
    public Transient Blob fileBlob {get;set;}
    public Integer fileSize {get;set;}
    public String fileName {get;set;}
    public Propiedad__c propiedad {get;set;}
    public List<Attachment> fotos {get;set;}

   
  public UploadImagesController2() 
    {
     
  }

    public PageReference setId()
    {
       
        String propiedadId = null;
        propiedadId = ApexPages.currentPage().getParameters().get('propiedadId');
        if (propiedadId != null) {
            propiedad = [SELECT Id,Name,Punto__Latitude__s, Punto__Longitude__s FROM Propiedad__c WHERE Id =:propiedadId];
            System.debug('propiedad: ' + propiedad);
            fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :propiedad.Id];
            System.debug('Fotos: ' + fotos);
        }
        return null;
    }

    public PageReference syncFilesystemDoc()
    {
        PageReference pageRef = new PageReference('/apex/UploadImages2?propiedadId='+propiedad.Id);
        pageRef.setRedirect(true);
        try{
            Attachment attachment = new Attachment();
            attachment.Body = fileBlob;
            attachment.Name = String.valueOf(fileName);
            attachment.ParentId = propiedad.Id;
            insert attachment;
            System.debug('attachment: ' + attachment);
            fotos = [SELECT Id,Name FROM Attachment WHERE ParentId = :propiedad.Id];
            System.debug('Fotos: ' + fotos);
        } catch(Exception ex) {
            System.debug('EXCEPTION: ' + ex);
        }
       
        return pageRef;  
    }
    
}