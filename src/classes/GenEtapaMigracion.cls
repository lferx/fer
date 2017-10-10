public with sharing class GenEtapaMigracion {
       public Decimal iNumEtapa {get;set;}
       public String ofta {get;set;}
       public String sNumEtapa {get;set;}
       public boolean bDes {get; set;}
       public list<Documento__c> lofertasdup {get; set;}
       public GenEtapaMigracion()
       {
       	 User oUsuario = [SELECT Id, name FROM User WHERE Id =: UserInfo.getUserId()]; 
       	 if (oUsuario.name == 'Solcom') 
       	 {
       	 	bDes = true;
       	 }else
       	 {
       	 	bDes = false;
       	 }
       	     
       	   
       }
       
       public void abredes()
       {
       	Documento__c doc10 = new Documento__c();
    	list<Documento__c> ldoc101 = new list<Documento__c>();
    	Oferta__c oferta = new Oferta__c();
    	if (Test.isRunningTest())
        {
        	//doc10 = [Select id, Cerrado__c, Iniciado__c From Documento__c Where Oferta__c =: IdOferta AND EtapaOferta__r.Etapa__r.NumEtapa__c =:10 AND DocumentoEtapa__r.Orden__c =: 1 Limit 1];
        	//EtapaOferta__c etofaux = new EtapaOferta__c();
            //etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: 10.1 Limit 1];
        	Oferta__c ofaux  = new Oferta__c();
            ofaux = [Select id, name From Oferta__c Limit 1];
            ofta = ofaux.name;
            //oferta = [Select id, name From Oferta__c Where name =: ofta];
        	ldoc101 = null;
        }
	    oferta = [Select id, name From Oferta__c Where name =: ofta];
	    ldoc101 = [Select id, Cerrado__c, Iniciado__c From Documento__c Where Oferta__c =: oferta.id AND EtapaOferta__r.Etapa__r.NumEtapa__c =:10.1 AND DocumentoEtapa__r.Orden__c =: 11 Limit 1];
        
    	Documento__c doc101 = new Documento__c();
    	
    	if (ldoc101.size() > 0) doc101 = ldoc101[0];
        
    	if (ldoc101.size() == 0 && oferta != null)
    	{
    	        system.debug('Entre al proceso');
		        list<Documento__c> docIns = new list<Documento__c>();
		    	docIns = [Select id, name From Documento__c Where Oferta__c =: oferta.id AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1];
		    	if (docIns.size()>0)
		    	{
		    		delete docIns;
		    		docIns.clear();
		    	}
		    	list<EtapaOferta__c> etofIns = new list<EtapaOferta__c>();
		    	etofIns = [Select Id, Name From EtapaOferta__c Where Oferta__c =: oferta.id AND Etapa__r.NumEtapa__c =: 10.1];
		    	if (etofIns.size()>0)
		    	{
		    		delete etofIns;
		    		etofIns.clear();
		    	}
		    	Etapa__c et = new Etapa__c();
		    	et = [SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE NumEtapa__c =: 10.1];
		    	
		    	EtapaOferta__c etofNew = new EtapaOferta__c();
		    	etofNew.Oferta__c = oferta.id;
		    	etofNew.Etapa__c = et.id;
		    	
		    		
		    	
		    	upsert etofNew;
		    	
		        for (DocumentoEtapa__c doce :[SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Etapa_Paso_Anterior__c, Paso_Anterior__c, Etapa_Doc_a_Iniciar__c, Doc_a_Iniciar__c, Inicia_Proceso_Venta__c, Tiempo_Proceso__c, Ruta_Critica__c, Tipo__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__r.NumEtapa__c =: 10.1 ORDER BY Orden__c ])
		    	{
		    		if(doce.Activo__c == true)
		    		{
		    			Documento__c docNew = new Documento__c();
		    			docNew.Oferta__c = oferta.id;
					    docNew.EtapaOferta__c = etofNew.Id;
						docNew.DocumentoEtapa__c = doce.Id;
						docNew.Name = doce.Name;
						docNew.Tipo__c = doce.Tipo__c;
						docIns.add(docNew);
		    		}
		    	}
		    	
		    	upsert docIns;
		    	
		    	map<Id, Documento__c> mDocOferta = new map<Id, Documento__c>();
		    	
		    	for (Documento__c doc :[SELECT DocumentoEtapa__c, EtapaOferta__c, Fecha_Compromiso_Plan__c, Fecha_Inicio__c, Fecha_Inicio_Plan__c, Fecha_Compromiso__c, Fecha_Com_Controller__c, Iniciado__c, Oferta__c FROM Documento__c WHERE Oferta__c =: oferta.id AND EtapaOferta__r.Etapa__r.NumEtapa__c =: 10.1])
		    	{
		    		mDocOferta.put(doc.DocumentoEtapa__c, doc);
		    	}
		    	DateTime dFrom = DateTime.now();
		    	map <String, DateTime> mobj = new map<String,DateTime>();
		    	for (Etapa__c etapa :[SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE NumEtapa__c =: 10.1])
		        {             
		            DateTime dto = dFrom;
		            DateTime dFromE = dFrom;
		            DateTime dToE = dFrom;
		            for (DocumentoEtapa__c detapa :[SELECT Id, Name, Activo__c, Etapa__c, Obligatorio__c, Orden__c, Etapa_Paso_Anterior__c, Paso_Anterior__c, Etapa_Doc_a_Iniciar__c, Doc_a_Iniciar__c, Inicia_Proceso_Venta__c, Tiempo_Proceso__c, Ruta_Critica__c FROM DocumentoEtapa__c WHERE Activo__c =: true AND Etapa__c =: etapa.Id ORDER BY Orden__c ])
		            {
		            	if (detapa.Etapa_Paso_Anterior__c == 0) 
		                {
		                   Documento__c docof = new Documento__c();
		                   docof = mDocOferta.get(detapa.Id);
		                   docof.Fecha_Inicio_Plan__c = dFromE;	
		                   docof.Fecha_Inicio__c = dFromE;
		                   dto = wsUtility.addBusinessDays(dFromE, detapa.Tiempo_Proceso__c);
		                   docof.Fecha_Compromiso_Plan__c = dto;
		                   docof.Fecha_Compromiso__c = dto;
		                   docof.Fecha_Com_Controller__c = dto;
		                   docof.Iniciado__c = true;
		                   mDocOferta.put(detapa.Id, docof);
		                   string etdoc;
		                   etdoc = string.valueOf(etapa.NumEtapa__c.intValue()) + string.valueOf(detapa.Orden__c);
		                   mobj.put(etdoc, dto);
		                   
		                   
		                } else
		                {
		                   string etdocget;
		                   etdocget = string.valueOf(detapa.Etapa_Paso_Anterior__c) + string.valueOf(detapa.Paso_Anterior__c);
		                   DateTime dfromTask;
		                   dFromTask = mobj.get(etdocget); 
		                   Documento__c docof = new Documento__c();
		                   docof = mDocOferta.get(detapa.Id);
		                   docof.Fecha_Inicio__c = dFromTask;
		                   docof.Fecha_Inicio_Plan__c = dFromTask;
		                   dto = wsUtility.addBusinessDays(dFromTask, detapa.Tiempo_Proceso__c);
		                   docof.Fecha_Compromiso__c = dto;
		                   docof.Fecha_Compromiso_Plan__c = dto;
		                   docof.Fecha_Com_Controller__c = dto;
		                   mDocOferta.put(detapa.Id, docof);
		                   string etdoc;
		                   etdoc = string.valueOf(etapa.NumEtapa__c.intValue()) + string.valueOf(detapa.Orden__c);
		                   mobj.put(etdoc, dto); 
		                }
		            }            
		        }
		        update mDocOferta.values();
		        
    	}
       }
       public void procesa()
       {
       	    
       	 
       	    list<Documento__c> ldocs = new list<Documento__c>();
			Datetime dFrom = Datetime.now();
			Oferta__c oferta = new Oferta__c();
			if (Test.isRunningTest())
            {
            	sNumEtapa = '9';
            	EtapaOferta__c etofaux = new EtapaOferta__c();
            	etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: iNumEtapa Limit 1];
            	Oferta__c ofaux  = new Oferta__c();
            	ofaux = [Select id, name From Oferta__c Where id =: etofaux.Oferta__c];
            	ofta = ofaux.name;
            }
			if(sNumEtapa != null && ofta != null)
			{
			   iNumEtapa = Decimal.valueOf(sNumEtapa);
			
				oferta = [Select id, name From Oferta__c Where name =: ofta];
	            
				EtapaOferta__c etapaoferta = new EtapaOferta__c();
				etapaoferta = [Select id, name from EtapaOferta__c Where Oferta__c =: oferta.id and NumEtapa__c =: iNumEtapa];
				if(etapaOferta != null)
				{
					list<Documento__c> ldocumentos = new list<Documento__c>();
					ldocumentos = [Select id, name, DocumentoEtapa__c From Documento__c Where EtapaOferta__r.NumEtapa__c =: iNumEtapa and Oferta__c =:oferta.id];
					map<Id, Documento__c> mDocumentos = new map<Id, Documento__c>();
					for (Documento__c doc :lDocumentos)
					{
						mDocumentos.put(doc.DocumentoEtapa__c, doc);
					}
					for(DocumentoEtapa__c detapa :[Select id, Name, Tipo__c, Tiempo_Proceso__c, Etapa__r.NumEtapa__c, Orden__c
					                               From DocumentoEtapa__c Where Etapa__r.NumEtapa__c =: iNumEtapa])
					{
						  
						    if ( mDocumentos.get(detapa.id) == null)
						    {
							    Documento__c dinsert = new Documento__c();
							    dinsert.Oferta__c = oferta.id;
							    dinsert.EtapaOferta__c = etapaoferta.id;
							    dinsert.DocumentoEtapa__c = detapa.id;
							    dinsert.Name = detapa.Name;
							    dinsert.Tipo__c = detapa.Tipo__c;
							    dinsert.Fecha_Inicio__c = dFrom;
							    dinsert.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
							    dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
							    dinsert.Iniciado__c = true;
							    ldocs.add(dinsert);
						    }
					}
					
					etapaoferta.Estatus__c = 'Abierta';
					update etapaoferta;
					if (ldocs.size() > 0)
					    upsert ldocs;                               
				}
			}
       }
       public void checkboxI()
       {
       	    
			Oferta__c oferta = new Oferta__c();
			if (Test.isRunningTest())
            {
            	sNumEtapa = '9';
            	EtapaOferta__c etofaux = new EtapaOferta__c();
            	etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: iNumEtapa Limit 1];
            	Oferta__c ofaux  = new Oferta__c();
            	ofaux = [Select id, name From Oferta__c Where id =: etofaux.Oferta__c];
            	ofta = ofaux.name;
            }
            if(ofta != null)
			{
				oferta = [Select id, name From Oferta__c Where name =: ofta];
	            oferta.Invadida__c = true;
	            update oferta;
			}
       }
       public void creaPasos()
       {
       	    
       	 
       	    list<Documento__c> ldocs = new list<Documento__c>();
			Datetime dFrom = Datetime.now();
			Oferta__c oferta = new Oferta__c();
			if (Test.isRunningTest())
            {
            	sNumEtapa = '9';
            	EtapaOferta__c etofaux = new EtapaOferta__c();
            	etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: iNumEtapa Limit 1];
            	Oferta__c ofaux  = new Oferta__c();
            	ofaux = [Select id, name From Oferta__c Where id =: etofaux.Oferta__c];
            	ofta = ofaux.name;
            }
			if(sNumEtapa != null && ofta != null)
			{
			   iNumEtapa = Decimal.valueOf(sNumEtapa);
			
				oferta = [Select id, name From Oferta__c Where name =: ofta];
	            
				EtapaOferta__c etapaoferta = new EtapaOferta__c();
				etapaoferta = [Select id, name from EtapaOferta__c Where Oferta__c =: oferta.id and Etapa__r.NumEtapa__c =: iNumEtapa];
				if(etapaOferta != null)
				{
					list<Documento__c> ldocumentos = new list<Documento__c>();
					ldocumentos = [Select id, name, DocumentoEtapa__c From Documento__c Where EtapaOferta__r.NumEtapa__c =: iNumEtapa and Oferta__c =:oferta.id];
					map<Id, Documento__c> mDocumentos = new map<Id, Documento__c>();
					for (Documento__c doc :lDocumentos)
					{
						mDocumentos.put(doc.DocumentoEtapa__c, doc);
					}
					for(DocumentoEtapa__c detapa :[Select id, Name, Tipo__c, Tiempo_Proceso__c, Etapa__r.NumEtapa__c, Orden__c
					                               From DocumentoEtapa__c Where Etapa__r.NumEtapa__c =: iNumEtapa])
					{
						  
						    if ( mDocumentos.get(detapa.id) == null)
						    {
							    Documento__c dinsert = new Documento__c();
							    dinsert.Oferta__c = oferta.id;
							    dinsert.EtapaOferta__c = etapaoferta.id;
							    dinsert.DocumentoEtapa__c = detapa.id;
							    dinsert.Name = detapa.Name;
							    dinsert.Tipo__c = detapa.Tipo__c;
							    dinsert.Fecha_Inicio__c = dFrom;
							    dinsert.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
							    dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
							    //dinsert.Iniciado__c = true;
							    ldocs.add(dinsert);
						    }
					}
					
					etapaoferta.Estatus__c = 'Abierta';
					update etapaoferta;
					if (ldocs.size() > 0)
					    upsert ldocs;                               
				}
			}
       }
       public void cierraproceso()
       {
       	    
       	    
			Oferta__c oferta = new Oferta__c();
			if (Test.isRunningTest())
            {
            	sNumEtapa = '9';
            	EtapaOferta__c etofaux = new EtapaOferta__c();
            	etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: iNumEtapa Limit 1];
            	Oferta__c ofaux  = new Oferta__c();
            	ofaux = [Select id, name From Oferta__c Where id =: etofaux.Oferta__c];
            	ofta = ofaux.name;
            }
            if(sNumEtapa != null && ofta != null)
            {
				iNumEtapa = Decimal.valueOf(sNumEtapa);
				oferta = [Select id, name From Oferta__c Where name =: ofta];
	            
				EtapaOferta__c etapaoferta = new EtapaOferta__c();
				etapaoferta = [Select id, name from EtapaOferta__c Where Oferta__c =: oferta.id and NumEtapa__c =: iNumEtapa];
				if(etapaoferta != null)
				{
					etapaoferta.Estatus__c = 'Cerrada';
					update etapaoferta;
				}
            }
			                               
       	   
       }
    public void EtapasInv()
    {
    	set<string> ofertasinv = new set<string>();
		ofertasinv.add('IF-2502117539');
		ofertasinv.add('SHF-609784004000229');
		ofertasinv.add('SHF-609784004000344');
		ofertasinv.add('AD-37029');
		ofertasinv.add('AA-50786');
		ofertasinv.add('BM-34674');
		ofertasinv.add('SHF-609440190000834');
		ofertasinv.add('SHF-609440190000909');
		ofertasinv.add('SHF-609440190000537');
		ofertasinv.add('SHF-609440190001170');
		ofertasinv.add('SHF-609529001000924');
		ofertasinv.add('BM-39839');
		ofertasinv.add('SHF-609201601010428');
		ofertasinv.add('SHF-603233041');
		ofertasinv.add('SHF-603245900');
		ofertasinv.add('SHF-603252045');
		ofertasinv.add('SHF-603246223');
		ofertasinv.add('BM-34177');
		ofertasinv.add('SHF-609244002000036');
		ofertasinv.add('SHF-603228185');
		ofertasinv.add('BM-29012');
		ofertasinv.add('SHF-609221003000082');
		ofertasinv.add('AD-35216');
		ofertasinv.add('BM-41996');
		ofertasinv.add('SHF-609102022001337');
		ofertasinv.add('BM-18183');
		ofertasinv.add('SHF-609529001001716');
		ofertasinv.add('SHF-609102022001170');
		ofertasinv.add('SHF-609529001002730');
		ofertasinv.add('SHF-609529001002482');
		ofertasinv.add('AD-33873');
		ofertasinv.add('SHF-603225956');
		ofertasinv.add('SHF-609529001002268');
		ofertasinv.add('SHF-609529001002417');
		ofertasinv.add('SHF-603225439');
		ofertasinv.add('SHF-609529001002128');
		ofertasinv.add('AC-91119');
		ofertasinv.add('SHF-609107500100014');
		ofertasinv.add('SHF-603212709');
		ofertasinv.add('SHF-603269005');
		ofertasinv.add('IF-2605040617');
		ofertasinv.add('IF-2604083427');
		ofertasinv.add('BM-29039');
		ofertasinv.add('IF-2605057269');
		ofertasinv.add('IF-2607198144');
		ofertasinv.add('IF-2605064125');
		ofertasinv.add('IF-2603141040');
		ofertasinv.add('IF-2601034697');
		ofertasinv.add('IF-2604096171');
		ofertasinv.add('BM-45034');
		ofertasinv.add('BM-32439');
		ofertasinv.add('BM-26836');
		ofertasinv.add('AD-22080');
		ofertasinv.add('BM-35288');
		ofertasinv.add('BM-37112');
		ofertasinv.add('SHF-609201297010021');
		ofertasinv.add('SHF-609201555013139');
		ofertasinv.add('SHF-603237850');
		ofertasinv.add('BM-22692');
		ofertasinv.add('BM-24590');
		ofertasinv.add('SHF-609201555012495');
		ofertasinv.add('SHF-609201555011802');
		ofertasinv.add('SHF-603238106');
		ofertasinv.add('BM-21229');
		ofertasinv.add('BM-23294');
		ofertasinv.add('BM-24365');
		ofertasinv.add('BM-21130');
		ofertasinv.add('BM-20756');
		ofertasinv.add('BM-21022');
		ofertasinv.add('BM-20846');
		ofertasinv.add('BM-17154');
		ofertasinv.add('BM-22459');
		ofertasinv.add('BM-20978');
		ofertasinv.add('BM-19448');
		ofertasinv.add('IF-507255239');
		ofertasinv.add('BM-33863');
		ofertasinv.add('IF-507316406');
		ofertasinv.add('IF-501004573');
		ofertasinv.add('IF-510112132');
		ofertasinv.add('IF-504147833');
		ofertasinv.add('BM-15738');
		ofertasinv.add('IF-505208113');
		ofertasinv.add('IF-509267123');
		ofertasinv.add('IF-509206036');
		ofertasinv.add('IF-509238122');
		ofertasinv.add('IF-500067119');
		ofertasinv.add('IF-509018544');
		ofertasinv.add('BM-46800');
		ofertasinv.add('IF-506149296');
		ofertasinv.add('IF-510188888');
		ofertasinv.add('IF-506122895');
		ofertasinv.add('IF-2602061682');
		ofertasinv.add('IF-2602072293');
		ofertasinv.add('IF-2502117539');
		system.debug('Total de ofertas invadidas..' + ofertasinv.size());
      if (Test.isRunningTest())
      {
      	ofta = 'ggs001';
      }	
      if(ofta == 'ggs001')
      {	
    	
		list<Documento__c> ldoc = new list<Documento__c>();
		list<EtapaOferta__c> letofertas = new list<EtapaOferta__c>();
		ldoc = [SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, 
		        Oferta__r.Name, Tiempo_Restante__c,  
		        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, 
		        DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
		        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
		        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true 
		        AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 
		        AND Oferta__r.Estatus__c !=: 'Finalizada' 
		        AND Oferta__r.Estatus__c !=: 'Descartada'AND Iniciado__c =: false
		        AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Invadida__c =: true
		        AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' 
		        AND Oferta__r.FechaCobro__c =: null AND Oferta__r.name IN: ofertasInv
		        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c]; 
		system.debug('Total de Ofertas invadidas con documento 1 etapa 10' + ldoc.size());
		letofertas = [Select Oferta__c, Oferta__r.name, Oferta__r.Propiedad__r.Plaza__c 
		              From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10 
					  and Oferta__r.FechaCobro__c =: null and Oferta__r.Estatus__c !=: 'Finalizada' 
					  and Oferta__r.Invadida__c =: true and Oferta__r.Estatus__c !=: 'Descartada'
					  and Oferta__r.TipoOferta__c !=: 'Contado' and Oferta__r.name IN: ofertasInv
					  Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c]; 
		system.debug('Total de Ofertas invadidas con etapa oferta 10 Abierta...' + letofertas.size());
		
		delete letofertas;
		map<String, Id> midof = new map<String, Id>();
		for (Oferta__c oftaf :[Select id, name From Oferta__c Where name IN: ofertasInv])
		{
		    midof.put(oftaf.name, oftaf.id);
		}
		Etapa__c etapa10 = new Etapa__c();
		etapa10 = [SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE NumEtapa__c =: 10];
		list<EtapaOferta__c> etofIns = new list<EtapaOferta__c>();
		
		for(String oftaf :ofertasInv)
		{
		    
		        EtapaOferta__c etofNew = new EtapaOferta__c();
				etofNew.Oferta__c = midof.get(oftaf);
				etofNew.Etapa__c = etapa10.id;
		        etofNew.HoraInicial__c = Datetime.now();
		        etofNew.Estatus__c = 'Abierta';
				etofIns.add(etofNew);
		        
		}
		if(etofIns.size() > 0) insert etofIns;
		map<string,Documento__c> mdocs = new map<string, Documento__c>(); 
		for(Documento__c doc :[SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, 
		        Oferta__r.Name, Tiempo_Restante__c,  
		        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, 
		        DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
		        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
		        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true 
		        AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 
		        AND Oferta__r.Estatus__c !=: 'Finalizada' 
		        AND Oferta__r.Estatus__c !=: 'Descartada'
		        AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Invadida__c =: true
		        AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' 
		        AND Oferta__r.FechaCobro__c =: null AND Oferta__r.name IN: ofertasInv
		        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c])
		{
		     mdocs.put(doc.Oferta__r.name, doc);   	
		}
		map<string, EtapaOferta__c> metofertas = new map<string, EtapaOferta__c>();
		metofertas.clear();
		for (EtapaOferta__c etof :[Select Oferta__c, Oferta__r.name, Oferta__r.Propiedad__r.Plaza__c 
		              From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10 and Estatus__c =: 'Abierta' 
					  and Oferta__r.FechaCobro__c =: null and Oferta__r.Estatus__c !=: 'Finalizada' 
					  and Oferta__r.Invadida__c =: true and Oferta__r.Estatus__c !=: 'Descartada'
					  and Oferta__r.TipoOferta__c !=: 'Contado' and Oferta__r.name IN: ofertasInv
					  Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c])
		{
		    metofertas.put(etof.Oferta__r.name, etof);
		}
		DocumentoEtapa__c detapa = new DocumentoEtapa__c();
		detapa = [Select id, name, Tipo__c, Tiempo_Proceso__c From DocumentoEtapa__c Where Etapa__r.NumEtapa__c =: 10 and Orden__c =: 1];
    	DateTime dFrom = DateTime.now();
    	list<Documento__c> ldocsi = new list<Documento__c>();
    	for(string oftaf :ofertasInv)
    	{
    		if(mdocs.get(oftaf) == null && metofertas.get(oftaf) != null)
    		{
    			Documento__c dinsert = new Documento__c();
			    dinsert.Oferta__c = midof.get(oftaf);
			    dinsert.EtapaOferta__c = metofertas.get(oftaf).id;
				dinsert.DocumentoEtapa__c = detapa.id;
				dinsert.Name = detapa.Name;
				dinsert.Tipo__c = detapa.Tipo__c;
				dinsert.Fecha_Inicio__c = dFrom;
				dinsert.Fecha_Compromiso__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
			    dinsert.Fecha_Com_Controller__c = wsUtility.addBusinessDays(dFrom, detapa.Tiempo_Proceso__c);
				//dinsert.Iniciado__c = true;
				ldocsi.add(dinsert);
    		}
    	}
    	if(ldocsi.size() > 0) insert ldocsi;
    	metofertas.clear();
		for (EtapaOferta__c etof :[Select Oferta__c, Oferta__r.name, Oferta__r.Propiedad__r.Plaza__c 
		              From EtapaOferta__c Where Etapa__r.NumEtapa__c =: 10.1  
					  and Oferta__r.FechaCobro__c =: null and Oferta__r.Estatus__c !=: 'Finalizada' 
					  and Oferta__r.Invadida__c =: true and Oferta__r.Estatus__c !=: 'Descartada'
					  and Oferta__r.TipoOferta__c !=: 'Contado' and Oferta__r.name IN: ofertasInv
					  Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c])
		{
		    metofertas.put(etof.Oferta__r.name, etof);
		}
		Etapa__c etapa101 = new Etapa__c();
		etapa101 = [SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE NumEtapa__c =: 10.1];
		list<EtapaOferta__c> etofIns1 = new list<EtapaOferta__c>();
		
		for(String oftaf :ofertasInv)
		{
		    if(metofertas.get(oftaf) == null)
		    {
		        EtapaOferta__c etofNew = new EtapaOferta__c();
				etofNew.Oferta__c = midof.get(oftaf);
				etofNew.Etapa__c = etapa101.id;
		        
				etofIns1.add(etofNew);
		    }    
		}
		if(etofIns1.size() > 0) insert etofIns1;
      }
      if (Test.isRunningTest())
      {
      	ofta = 'ggs002';
      }	
      if(ofta == 'ggs002')
      {	
      	
      	list<Documento__c> ldocupdate = new list<Documento__c>();
      	for(Documento__c doc :[SELECT id, Oferta__c, Name, Owner.Name, Oferta__r.Propiedad__r.Plaza__c, 
		        Oferta__r.Name, Tiempo_Restante__c,  
		        Fecha_Com_Controller__c, Fecha_Cierre__c, DocumentoEtapa__c, 
		        DocumentoEtapa__r.Name, Iniciado__c, Cerrado__c,  
		        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
		        FROM Documento__c WHERE DocumentoEtapa__r.Obligatorio__c =:true 
		        AND DocumentoEtapa__r.Etapa__r.NumEtapa__c =: 10 
		        AND Oferta__r.Estatus__c !=: 'Finalizada' 
		        AND Oferta__r.Estatus__c !=: 'Descartada' and Cerrado__c =: false
		        AND EtapaOferta__r.Estatus__c =: 'Abierta' AND Oferta__r.Invadida__c =: true
		        AND DocumentoEtapa__r.Orden__c =: 1 AND Oferta__r.TipoOferta__c !=: 'Contado' 
		        AND Oferta__r.FechaCobro__c =: null AND Oferta__r.name IN: ofertasInv
		        Order by Oferta__r.OwnerId, Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c])
		{
		     doc.Iniciado__c = false;
		     ldocupdate.add(doc); 	
		}
		if(ldocupdate.size() > 0 ) update ldocupdate;
      }
      if (Test.isRunningTest())
      {
      	ofta = 'ggs003';
      }	
      if(ofta == 'ggs003')
      {	
      	
      	set<string> oftasduplicadas = new set<string>();
      	oftasduplicadas.add('BM-34674');
      	oftasduplicadas.add('SHF-609201601010428');
      	oftasduplicadas.add('BM-34177');
      	oftasduplicadas.add('BM-41996');
      	oftasduplicadas.add('IF-2605057269');
      	oftasduplicadas.add('BM-45034');
      	oftasduplicadas.add('BM-26836');
      	oftasduplicadas.add('BM-22692');
      	oftasduplicadas.add('BM-24590');
      	oftasduplicadas.add('BM-23294');
      	oftasduplicadas.add('BM-21130');
      	oftasduplicadas.add('BM-19448');
      	oftasduplicadas.add('BM-15738');
      	oftasduplicadas.add('IF-509267123');
      	oftasduplicadas.add('IF-509238122');
      	oftasduplicadas.add('BM-46800');
      	for (string oftad :oftasduplicadas)
      	{
      		list<EtapaOferta__c> etofdel = new list<EtapaOferta__c>();
      		etofdel = [Select id, name From EtapaOferta__c Where Oferta__r.name =: oftad AND Etapa__r.NumEtapa__c =:10 ];
      		delete etofdel;
      	}
      	map<String, Id> midof = new map<String, Id>();
		for (Oferta__c oftaf :[Select id, name From Oferta__c Where name IN: oftasduplicadas])
		{
		    midof.put(oftaf.name, oftaf.id);
		}
		Etapa__c etapa10 = new Etapa__c();
		etapa10 = [SELECT Id,NumEtapa__c, EstatusOferta__c, Name FROM Etapa__c WHERE NumEtapa__c =: 10];
		list<EtapaOferta__c> etofIns = new list<EtapaOferta__c>();
		
		for(String oftaf :ofertasInv)
		{
		    
		        EtapaOferta__c etofNew = new EtapaOferta__c();
				etofNew.Oferta__c = midof.get(oftaf);
				etofNew.Etapa__c = etapa10.id;
		        etofNew.HoraInicial__c = Datetime.now();
		        etofNew.Estatus__c = 'Abierta';
				etofIns.add(etofNew);
		}
		insert etofIns;    
      }
    	
    }
       public void sininiciar()
       {
       	    
       	    
			Oferta__c oferta = new Oferta__c();
			if (Test.isRunningTest())
            {
            	sNumEtapa = '9';
            	EtapaOferta__c etofaux = new EtapaOferta__c();
            	etofaux = [Select Oferta__c, id From EtapaOferta__c Where NumEtapa__c =: iNumEtapa Limit 1];
            	Oferta__c ofaux  = new Oferta__c();
            	ofaux = [Select id, name From Oferta__c Where id =: etofaux.Oferta__c];
            	ofta = ofaux.name;
            }
            if(sNumEtapa != null && ofta != null)
            {
				iNumEtapa = Decimal.valueOf(sNumEtapa);
				oferta = [Select id, name From Oferta__c Where name =: ofta];
	            
				EtapaOferta__c etapaoferta = new EtapaOferta__c();
				etapaoferta = [Select id, name from EtapaOferta__c Where Oferta__c =: oferta.id and Etapa__r.NumEtapa__c =: iNumEtapa];
				if(etapaoferta != null)
				{
					etapaoferta.Estatus__c = null;
					update etapaoferta;
				}
            }
			                               
       	   
       }
       
}