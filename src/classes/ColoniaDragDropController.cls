public with sharing class ColoniaDragDropController 
{
    public Decimal lat {get;set;}
    public Decimal lng {get;set;}
    public Decimal plat {get;set;}
    public Decimal plng {get;set;}
    public String redirectUrl {get;set;}
    public Boolean bRedirect {get;set;}
    private final Colonia__c Colonia;
    public ColoniaDragDropController(ApexPages.StandardController stdController) {
        this.Colonia = [SELECT Id,Name,Ubicacion__Latitude__s, Ubicacion__Longitude__s FROM Colonia__c WHERE id =: stdController.getRecord().id];
        bRedirect = false;
        try{
            if (this.Colonia.Ubicacion__Latitude__s != NULL && this.Colonia.Ubicacion__Longitude__s != NULL) {
                plat = this.Colonia.Ubicacion__Latitude__s;
                plng = this.Colonia.Ubicacion__Longitude__s;
            } else {
                //Zocalo del DF
                plat = 19.432632;
                plng = -99.133298;
            }
            redirectUrl = '/' + Colonia.Id;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
    }
    public PageReference refreshLL(){
        try{
            this.Colonia.Ubicacion__Latitude__s = (Decimal)lat;
            this.Colonia.Ubicacion__Longitude__s = (Decimal)lng;
            update this.Colonia;
            bRedirect = true;
        }catch(Exception ex){
            System.debug('EXCEPTION: ' + ex);
        }
       
      return null;  
    }
}