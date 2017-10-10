public class SolicitudPagoController {
    public SolicitudPago__c solicitudPago {get;set;}
    public List<WrapSolicitud> solicitudesPago {get;set;}
    public User usuario {get;set;}
    public class WrapGasto{
        public boolean selected {get;set;}
        public Gasto__c gasto {get;set;}
        public WrapGasto(){
            selected = false;
            gasto = new Gasto__c();
        }
    }
    public class WrapSolicitud{
        public boolean selected {get;set;}
        public SolicitudPago__c solicitud {get;set;}
        public List<WrapGasto> gastos {get;set;}
        public WrapSolicitud(){
            gastos = new List<WrapGasto>();
        }
    }
    
    public SolicitudPagoController(ApexPages.StandardController controller){
        solicitudPago = [SELECT id,Name,Datos_bancarios__c, ImporteFinal__c  FROM SolicitudPago__c WHERE Id =: controller.getId()];
        usuario = [SELECT Id,Name, PermisoGasto__c FROM User WHERE id =:  UserInfo.getUserId()];
        cargarSolicitudesExistentes();
    }
    
    public void cargarSolicitudesExistentes(){
        solicitudesPago = new list<WrapSolicitud>();
        set<Id>idSolicitudes = new set<Id>();
        list<SolicitudPago__c> solicitudExistentes = new list<SolicitudPago__c>();
        
        list<Gasto__c> gastosConSolicitud = [SELECT id,Name, ErrorDuplicado__c, ImporteFinal__c,AplicarIVA__c ,Account__c,EnviarCxP__c,Importe__c,Rechazado__c, 
                                             Tipo__c,SolicitudPago__c,Comentario__c,Oferta__c,Concepto__c,MensajeError1__c,MensajeError2__c,MensajeError3__c,
                                             Process__c, GLA__c, Pagado__c FROM Gasto__c WHERE SolicitudPago__c =: solicitudPago.Id];
      
        WrapSolicitud ws = new WrapSolicitud();
        ws.solicitud = solicitudPago;
        for(Gasto__c gasto:gastosConSolicitud){
                WrapGasto wg = new WrapGasto();
            wg.gasto = gasto;
            ws.gastos.add(wg);
        }
                solicitudesPago.add(ws);
    }
    
     public void desagruparGasto(){
        list<Gasto__c> gastos = new list<Gasto__c>();
        for(WrapSolicitud ws:solicitudesPago){
            for(WrapGasto wg:ws.gastos){
                if(wg.selected){
                    gastos.add(wg.gasto);
                }
            }
        }
        
        for(Gasto__c gasto:gastos){
            gasto.SolicitudPago__c = null;
        }
        
        try{
            update gastos;
            cargarSolicitudesExistentes();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , 'Datos guardos correctamente'));
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , e.getMessage()));
        }
    }
    
    public void saveSolicitudes(){
        list<SolicitudPago__c> solicitudUpdate = new list<SolicitudPago__c>();
        list<Gasto__c> gastoUpdate = new list<Gasto__c>();
        for(WrapSolicitud ws :  solicitudesPago){
            solicitudUpdate.add(ws.solicitud);
            for(WrapGasto wg:ws.gastos){
                gastoUpdate.add(wg.gasto);
            }
        }
        try{
            update solicitudUpdate;
            update gastoUpdate;
            cargarSolicitudesExistentes();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , 'Datos guardados correctamente'));
        }catch(Exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , e.getMessage()));
        
        }
    }
}