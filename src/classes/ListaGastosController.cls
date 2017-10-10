public class ListaGastosController {
    public Gasto__c gasto {get;set;}
    public Oferta__c oferta {get;set;}
    public map<Gasto__c,WrapGasto> mapGasto {get;set;}
	public list<WrapGasto> gastos {get;set;}
    
    public class WrapGasto{
        public boolean selected {get;set;}
        public boolean priceEdit {get;set;}
        public boolean isNew {get;set;}
        public Gasto__c gasto {get;set;}
        public WrapGasto(){
            priceEdit = true;
            selected = false;
            isNew = true;
            gasto = new Gasto__c();
        }
    }
    public ListaGastosController(ApexPages.StandardController stdController) {
     	 gasto = (Gasto__c)stdController.getRecord();
         String ido = ApexPages.currentPage().getParameters().get('ido'); //id oferta
         mapGasto = new map<Gasto__c,WrapGasto>();
         try{
           if(ido != null && ido != ''){
               oferta = [SELECT id,name FROM Oferta__c WHERE Id =: ido];
               gasto.Oferta__c = oferta.id;
           }else{
               oferta = [SELECT id,name FROM Oferta__c WHERE Id =: gasto.Oferta__c];
           }
        }catch(exception e){
        
        }
        loadInfo();
     }
    public void loadInfo(){
        if(oferta != null){
            gastos = new list<WrapGasto>();
            list<Gasto__c> gastosExistentes  = new list<Gasto__c>();
            String sQuery = 'SELECT  Id,EnviarCxP__c, PayableInvoice__c, Cancelado__c ,EtapaOferta__c,Name,MensajeError1__c, MensajeError2__c,MensajeError3__c,Oferta__c, Concepto__c,Concepto__r.Name,Concepto__r.CampoImporteOrigen__c, Account__c, Fecha__c,' +
                            'GLA__c, FolioFactura__c, Importe__c,Estatus__c,EtapaOferta__r.Etapa__r.Name,Comentario__c,SolicitudPago__c  ' + 
                            'FROM Gasto__c ';
            String sWhere = 'WHERE Oferta__c = \''+ oferta.Id +'\'' ;
            String sOrder = ' ORDER BY CreatedDate ASC,Oferta__r.Inversor__c,Oferta__r.Inversor__r.Alias__c, Oferta__r.Plaza__c,Gasto__c.Account__c,Concepto__r.Categoria__c';
            
            sQuery = sQuery + sWhere + sOrder;
            try{
                 gastosExistentes = Database.query(sQuery);
                 for(Gasto__c gastoExistente: gastosExistentes){
                    WrapGasto wg = new WrapGasto();
                    wg.isNew = false;
                    wg.gasto = gastoExistente;
                    gastos.add(wg);
                    if(!mapGasto.containskey(gastoExistente)){
                        mapGasto.put(gastoExistente, wg);
                    }
            	}
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
            }
        }
    }
    
    public PageReference administrarGastos(){
        PageReference pageRef = new PageReference ('/apex/Gastos?ido=' + oferta.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}