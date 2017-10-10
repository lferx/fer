public class TriggerOfertaHandler2 extends TriggerHandler {
	private Map<Id, Oferta__c> newMap;
	private Map<Id, Oferta__c> oldMap;
	private List<Oferta__c> newList;
	private List<Oferta__c> oldList;
 	
	public TriggerOfertaHandler2() {
		this.newMap = (Map<Id, Oferta__c>) trigger.newMap;
		this.oldMap = (Map<Id, Oferta__c>) trigger.oldMap;
		this.newList = (List<Oferta__c>) trigger.new;
		this.oldList = (List<Oferta__c>) trigger.old;
	}
	
	public override void afterInsert(){
		creaDimension1();
		for (Oferta__c ofer :newList)
		{
		    if (!GeneraFechasC(ofer.id))
		       ofer.addError('Se ha producido un error al generar las Fechas Compromiso');
		}    
		
	}
	
	
	public override void afterUpdate(){
		actualizaIndicadoresWeb();
		//actualizaDimensions();
	}
	
	public override void beforeUpdate(){
		actualizaCampos();
	}
	
	private void creaDimension1(){
		List<c2g__codaDimension1__c> newDimensions = new List<c2g__codaDimension1__c>();
		for(Oferta__c oferta : newList){
			c2g__codaDimension1__c dim = new c2g__codaDimension1__c();
			dim.Oferta__c = oferta.Id;
			dim.Name = oferta.Name;
			dim.c2g__ReportingCode__c = oferta.Name;
			newDimensions.add(dim);
		}
		insert newDimensions;
	}
	private boolean GeneraFechasC(Id OfertaId)
    {
    	list<Documento__c> lDocOfertaDel = new list<Documento__c>();
        lDocOfertaDel = [SELECT DocumentoEtapa__c, EtapaOferta__c, Fecha_Compromiso_Plan__c, Fecha_Inicio__c, Fecha_Inicio_Plan__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Cerrado__c, Iniciado__c, Oferta__c FROM Documento__c WHERE Oferta__c =: OfertaId];
		if (lDocOfertaDel.size()>0)
		{
		    Delete lDocOfertaDel;
		}
    	map<Id,list<DocumentoEtapa__c>> mDocEtapa = new map<Id, list<DocumentoEtapa__c>>();
    	list<Id> lEtapaIds = new list<Id>();
    	for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta') ORDER BY NumEtapa__c])
        {
             list<DocumentoEtapa__c> lDocEtapaAux = new list<DocumentoEtapa__c>();
             lDocEtapaAux = [SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Etapa_Paso_Anterior__c, Paso_Anterior__c, Etapa_Doc_a_Iniciar__c, Doc_a_Iniciar__c, Inicia_Proceso_Venta__c, Tiempo_Proceso__c, Ruta_Critica__c, Tipo__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__c =: etapa.Id ORDER BY Orden__c ];
             mDocEtapa.put(etapa.Id, lDocEtapaAux);
             lEtapaIds.add(etapa.Id);
        }
    	list<Documento__c> docIns = new list<Documento__c>();
    	for(EtapaOferta__c etof :[SELECT Etapa__c, Oferta__c FROM EtapaOferta__c WHERE Oferta__c =: OfertaId AND Etapa__c IN :lEtapaIds])
    	{
    		
    		for (DocumentoEtapa__c doce :mDocEtapa.get(etof.Etapa__c))
    		{
    		  if(doce.Activo__c == true)
    		  {
    			Documento__c docNew = new Documento__c();
    			docNew.Oferta__c = OfertaId;
			    docNew.EtapaOferta__c = etof.Id;
				docNew.DocumentoEtapa__c = doce.Id;
				docNew.Name = doce.Name;
				docNew.Tipo__c = doce.Tipo__c;
				docIns.add(docNew);
    		  }
    		}
    	}
    	upsert docIns;
    	boolean ret;
    	ret = wsUtility.GenerateComDates(OfertaId);
    	return ret;
    	
    }
	private void actualizaDimensions(){
		//update [Select Id From c2g__codaDimension2__c Where ConceptoCatalogo__c IN: newList];
	}
	
	private void actualizaIndicadoresWeb(){
		Boolean actualizaIndicadores = false;
		for(Oferta__c oferta : newList){
			if(oferta.Estatus__c != oldMap.get(oferta.Id).Estatus__c || oferta.Etapa__c != oldMap.get(oferta.Id).Etapa__c){
				actualizaIndicadores = true;
				break;
			}
		}
		if(actualizaIndicadores){
			IndicadoresWeb.indicadoresWebUpdateFuture();
		}
	}
	
	private void actualizaCampos(){
		for(Oferta__c item : newList){
			if(item.Inversor__c != null && mapCuentasRelacionadas.get(item.Inversor__c).Company__r.Alias__c != null){
				item.AliasCompanyTxt__c = mapCuentasRelacionadas.get(item.Inversor__c).Company__r.Alias__c;
			}
		}
	}
	
	
	private Map<ID, Account> mapCuentasRelacionadas {
		get{
			if(mapCuentasRelacionadas == null){
				Set<Id> idsParents = new Set<Id>();
				for(Oferta__c line : newList){
					idsParents.add(line.Inversor__c);
				}
				mapCuentasRelacionadas = new Map<Id, Account>([Select Id, Name, Company__r.Alias__c  From Account Where Id IN: idsParents]);
			}
			return mapCuentasRelacionadas;
		}set;
	}
}