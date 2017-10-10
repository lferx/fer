@isTest(SeeAllData=true)
private class TestwsUtility {

    static testMethod void wsUtilityTest() {
        Etapa__c etapa = new Etapa__c();
        etapa = [Select id From Etapa__c Where NumEtapa__c =: 1];
        
		Etapa__c etapaVenta = new Etapa__c();
		etapaVenta = [Select id From Etapa__c Where NumEtapa__c =: 13];
		
		DocumentoEtapa__c de = new DocumentoEtapa__c();
        de = [Select id, name From DocumentoEtapa__c Where Etapa__c =: etapa.id and Orden__c =: 1 ];
        Propiedad__c p = new Propiedad__c();
	    p.Name = 'PTEST999';
		p.GeneraOferta__c = true;
		insert p;
		
		Oferta__c oferta = [Select Id, Name, Propiedad__c From Oferta__c Where Propiedad__c =: p.Id];
		/*map<integer, EtapaOferta__c> etofaux = new map<integer,EtapaOferta__c>();
		integer i = 0;
		for (EtapaOferta__c eto :[SELECT id, Oferta__c, NumEtapa__c, Name, Etapa__c FROM EtapaOferta__c Where Oferta__c =: oferta.id])
		{
		    etofaux.put(i,eto);
		    i++;
		}*/
		EtapaOferta__c etoft = new EtapaOferta__c();
		etoft.Oferta__c = oferta.id;
		etoft.Etapa__c = etapa.id;
		insert etoft;
		/*
		Documento__c doc = new Documento__c();
		doc.Tipo__c = 'Documento';
		doc.Oferta__c = oferta.Id;
		doc.Name = 'IFE';
		doc.EtapaOferta__c = etoft.Id;
		doc.DocumentoEtapa__c = de.Id;
		
		doc.Cerrado__c = false; 
		doc.Iniciado__c = true;   
		doc.Fecha_Cierre__c = null;
		insert doc;*/
		boolean ret2;
		list<Decimal> lde = new list<Decimal>();
		lde = wsUtility.CriticalPath(etapaVenta.id);
		ret2 = wsUtility.CrearPasoMigracion(etoft);
		list<Documento__c> docreg = new list<Documento__c>();
		test.startTest();
		GeneraFechasC(oferta.id);
		docreg = [Select id, name, Oferta__c,
			      EtapaOferta__c,
				  DocumentoEtapa__c,				
				  Tipo__c,
				  Iniciado__c,
				  Cerrado__c From Documento__c Where Oferta__c =: oferta.id];
		
		
		
		for (Documento__c doc :docreg)
		{
		   
		        ret2 = wsUtility.ConcluyePaso(doc);
		    
		}
		boolean cober=wsUtility.cobertura();
		test.stopTest();
    }
    static private void GeneraFechasC(Id OfertaId)
    {
    	list<Documento__c> lDocOfertaDel = new list<Documento__c>();
        lDocOfertaDel = [SELECT DocumentoEtapa__c, EtapaOferta__c, Fecha_Compromiso_Plan__c, Fecha_Inicio__c, Fecha_Inicio_Plan__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Cerrado__c, Iniciado__c, Oferta__c FROM Documento__c WHERE Oferta__c =: OfertaId];
		if (lDocOfertaDel.size()>0)
		{
		    Delete lDocOfertaDel;
		}
    	map<Id,list<DocumentoEtapa__c>> mDocEtapa = new map<Id, list<DocumentoEtapa__c>>();
    	list<Id> lEtapaIds = new list<Id>();
    	for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra') AND NumEtapa__c <: 2 ORDER BY NumEtapa__c])
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
				docNew.Iniciado__c = true;
				docNew.Cerrado__c = false;
				docIns.add(docNew);
    		  }
    		}
    	}
    	upsert docIns;
    	boolean ret;
    	ret = wsUtility.GenerateComDates(OfertaId);
    	
    	
    }
}