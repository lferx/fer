public with sharing class PropiedadDragDropControllerOferta 
{
    public Decimal lat {get;set;}
    public Decimal lng {get;set;}
    public Decimal plat {get;set;}
    public Decimal plng {get;set;}
    public String redirectUrl {get;set;}
    public Boolean bRedirect {get;set;}
    private final Oferta__c propiedad;
    public PropiedadDragDropControllerOferta(ApexPages.StandardController stdController) {
        this.propiedad = [SELECT Id,Name,Punto__Latitude__s, Punto__Longitude__s FROM Oferta__c WHERE id =: stdController.getRecord().id];
        bRedirect = false;
        try{
            if (this.propiedad.Punto__Latitude__s != NULL && this.propiedad.Punto__Longitude__s != NULL) {
                plat = this.propiedad.Punto__Latitude__s;
                plng = this.propiedad.Punto__Longitude__s;
            } else {
                //Zocalo del DF
                
                
                plat = 19.432632;
                plng = -99.133298;
            }
            redirectUrl = '/' + propiedad.Id;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
        }
    }
    public PageReference refreshLL(){
        try{
            this.propiedad.Punto__Latitude__s = (Decimal)lat;
            this.propiedad.Punto__Longitude__s = (Decimal)lng;
            update this.propiedad;
            bRedirect = true;
        }catch(Exception ex){
            System.debug('EXCEPTION: ' + ex);
        }
       
      return null;  
    }
}