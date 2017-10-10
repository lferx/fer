public with sharing class CockpitOfertasController {
   public String filterst {get;set;}
   public String filterzone {get;set;}
   public String filtergte {get;set;}
   
   private static map<id, Documento__c> mdocofer = new map<id, Documento__c>();
   public map<id, Documento__c> mdocmap = new map<id, Documento__c>();
   
   public integer offset{get;set;} // First register in the actual set
   public integer iLimit; //Number of registers to show
   public Integer numHojas{get;set;} 
   public Integer hojasActual{get;set;} 
   public Integer iofertasTotal{get;set;}
   public Integer ofertasXhoja{get;set;}
   public String idLnSelect {get;set;}
   private final map<String, list<Documento__c>> mdocs = new map<String, list<Documento__c>>();
   private final map<Integer, list<Id>> metdocs = new map<Integer, list<Id>>();
   public list<Documento__c> ldocids {get; set;}
   public CockpitOfertasController()
   {
   	  String deid = '';
   	  //list<Documento__c> ldocids = new list<Documento__c>();
   	  for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
	   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
	   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
	   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' Order by DocumentoEtapa__c])
	   	  {	   	  	   	   	  	   
	   	  	   ldocids.add(dc);
	   	  }
	   	  mdocs.put(dce.id, ldocids);
   	  }
   	  
   	  system.debug('Este es el mdocs... ' + mdocs);
   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
   	  {
	   	  list<Id> ldoceids = new list<Id>();
	   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
	   	  {
	   	 	  ldoceids.add(deaux.id); 
	   	  }
	   	  
	   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
   	  }
   	  
   	  system.debug('Este el metdocs....' + metdocs);
   }
   public void Recarga()
   {
   	  String deid = '';
   	  if (mdocs != null) mdocs.clear();
   	  if ( metdocs != null) metdocs.clear();
   	  //list<Documento__c> ldocids = new list<Documento__c>();
   	  for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
	   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
	   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
	   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' Order by DocumentoEtapa__c])
	   	  {	   	  	   	   	  	   
	   	  	   ldocids.add(dc);
	   	  }
	   	  mdocs.put(dce.id, ldocids);
   	  }
   	  
   	  system.debug('Este es el mdocs... ' + mdocs);
   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
   	  {
	   	  list<Id> ldoceids = new list<Id>();
	   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
	   	  {
	   	 	  ldoceids.add(deaux.id); 
	   	  }
	   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
   	  }
   	  
   	  system.debug('Este el metdocs....' + metdocs);
   }
   public void loadInfo()
   {
   	  String deid = '';
   	  if (filterst == null) filterst = 'Todos';
   	  if (filterzone == null) filterzone = 'Todas';
   	  if (filtergte == null) filtergte = 'Todos';
   	  if (mdocs.size() > 0) mdocs.clear();
   	  if (metdocs.size() > 0) metdocs.clear();
   	  if ( filterst == 'Todos' && filterzone == 'Todas' && filtergte == 'Todos')
   	  {
   	    
   	     for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  }else if(filterst != 'Todos' && filterzone != 'Todas' && filtergte != 'Todos')
   	  {
   	  	// Filtro para un estatus y una plaza especifica
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.Estatus__c =: filterst AND Oferta__r.Plaza__c =: filterzone 
		   	                            AND Oferta__r.OwnerId =: filtergte
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  }else if(filterst == 'Todos' && filterzone != 'Todas' && filtergte != 'Todos')
   	  {
   	  	// Filtro para todos los estatus y una plaza específica
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.Plaza__c =: filterzone 
		   	                            AND Oferta__r.OwnerId =: filtergte
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  }else if(filterst != 'Todos' && filterzone == 'Todas' && filtergte != 'Todos')
   	  {
   	  	//filtro para todas las plazas y un estatus específico
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.Estatus__c =: filterst  
		   	                            AND Oferta__r.OwnerId =: filtergte
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  	
   	  }else if(filterst != 'Todos' && filterzone != 'Todas' && filtergte == 'Todos')
   	  {
   	  	//filtro para todas las plazas y un estatus específico
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.Estatus__c =: filterst  
		   	                            AND Oferta__r.Plaza__c =: filterzone
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  	
   	  }else if(filterst != 'Todos' && filterzone == 'Todas' && filtergte == 'Todos')
   	  {
   	  	//filtro para todas las plazas y un estatus específico
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.Estatus__c =: filterst  		   	                            
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  	
   	  }else if(filterst == 'Todos' && filterzone != 'Todas' && filtergte == 'Todos')
   	  {
   	  	//filtro para todas las plazas y un estatus específico
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada'  
		   	                            AND Oferta__r.Plaza__c =: filterzone
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  	
   	  }else if(filterst == 'Todos' && filterzone == 'Todas' && filtergte != 'Todos')
   	  {
   	  	//filtro para todas las plazas y un estatus específico
   	  	for (DocumentoEtapa__c dce :[SELECT id, Name, Tiempo_Proceso__c FROM DocumentoEtapa__c WHERE Obligatorio__c =: true AND (Etapa__r.EstatusOferta__c =: 'Compra' OR 
   	                              Etapa__r.EstatusOferta__c =: 'Venta') Order by id ])
	   	  {   list<Documento__c> ldocids = new list<Documento__c>();                         
		   	  for (Documento__c dc :[SELECT id, Oferta__c, Name, Oferta__r.Name, Tiempo_Restante__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c 
		   	                            FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: dce.id AND 
		   	                            Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' AND Oferta__r.OwnerId =: filtergte
		   	                            Order by DocumentoEtapa__c])
		   	  {	   	  	   	   	  	   
		   	  	   ldocids.add(dc);
		   	  }
		   	  mdocs.put(dce.id, ldocids);
	   	  }
	   	  
	   	  system.debug('Este es el mdocs... ' + mdocs);
	   	  for(Etapa__c etpa :[SELECT id, Name, NumEtapa__c FROM Etapa__c Where Activa__c =: true AND 
	   	                     (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta' OR NumEtapa__c =: 10.1) Order by NumEtapa__c])
	   	  {
		   	  list<Id> ldoceids = new list<Id>();
		   	  for(DocumentoEtapa__c deaux :[SELECT id, Name, Etapa__r.NumEtapa__c From DocumentoEtapa__c Where Etapa__c =: etpa.id AND Obligatorio__c =: true])
		   	  {
		   	 	  ldoceids.add(deaux.id); 
		   	  }
		   	  metdocs.put((etpa.NumEtapa__c * 10).intValue(), ldoceids);
	   	  }
   	  	
   	  	
   	  	
   	  }
   	  //list<Documento__c> ldocids = new list<Documento__c>();
   	  
   	  
   }
   public void cerrar()
   {
   	
   }
   public List<SelectOption> getlistviewoptions() {
            Schema.DescribeFieldResult statusof = Oferta__c.Estatus__c.getDescribe();

            List<Schema.PicklistEntry> statusofValues = statusof.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Estatus --', '-- Selecciona Estatus --')); 
            options.add(new SelectOption('Todos','Todos'));
            if (statusofValues != null && statusofValues[0] != null) {
	            for (Schema.PicklistEntry p : statusofValues)
	            { 
	               options.add(new SelectOption(p.getValue(),p.getValue())); 
	     
	            } 
            }
            return options;
     }
     public List<SelectOption> getlistzoneoptions() {
            Schema.DescribeFieldResult plazas = Propiedad__c.Plaza__c.getDescribe();

            List<Schema.PicklistEntry> plazaValues = plazas.getPicklistValues();
            
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Plaza --', '-- Selecciona Plaza --'));
            options.add(new SelectOption('Todas','Todas'));
            if (plazaValues != null && plazaValues[0] != null) {
	            for (Schema.PicklistEntry p : plazaValues)
	            { 
	               options.add(new SelectOption(p.getValue(),p.getValue())); 
	     
	            } 
            }
            
            return options;
     }
     public List<SelectOption> getlistgteoptions() {
            
            set<String> sUsers = new set<String>();
            For (Oferta__c o :[Select OwnerId, Owner.Name From Oferta__c Where Estatus__c !=: 'Finalizada' AND Estatus__c !=: 'Descartada'])
            {
            	sUsers.add(o.OwnerId);
            }
            List<SelectOption> options = new List<SelectOption>();
            //options.add(new SelectOption('-- Selecciona Gerente --', '-- Selecciona Gerente --'));
            options.add(new SelectOption('Todos','Todos'));
            
	        for (User p : [Select Id,Name From User Where Id IN :sUsers])
	        { 
	            options.add(new SelectOption(p.Id,p.Name)); 
	     
	        } 
            
            
            return options;
     }
   public list<wrapdocs> getldoc1()
   {  	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(10) != null)
   	 {
   	 	
	   	 for (Id docetaid :metdocs.get(10))
	   	 {
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es el wrapdocs....' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	 }
	   	 return ldocaux;
   	 }else
   	   return null;
   }
   public list<wrapdocs> getldoc2()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(20) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(20))
	   	 {
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
	   	 
   	 }else
        return null;
   }
   public list<wrapdocs> getldoc3()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(30) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(30))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 3.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc4()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(40) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(40))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc5()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(50) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(50))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc6()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(60) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(60))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc7()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(70) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(70))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc8()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(80) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(80))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc9()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(90) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(90))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc10()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(100) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(100))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc101()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(101) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(101))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 10.1.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc11()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(110) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(110))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc12()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(120) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(120))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public list<wrapdocs> getldoc13()
   {
   	   	
   	 
   	 list<wrapdocs> ldocaux = new list<wrapdocs>();
   	 if (metdocs.get(130) != null)
   	 {
	   	 for (Id docetaid :metdocs.get(130))
	   	 {
	   	 	
	   	 	Integer ired = 0;
	   	 	Integer iyellow = 0;
	   	 	Integer igreen = 0;
	   	 	String sName = '';
	   	 	system.debug('Este es el documento 4.....' + mdocs.get(docetaid));
	   	 	if (mdocs.get(docetaid) != null)
	   	 	{
		   	 	for (Documento__c docid :mdocs.get(docetaid))
		   	 	{
		   	 		if (sName == '') sName = docid.DocumentoEtapa__r.Name;
		   	 		if (docid.Semaforo__c == 'Rojo') ired ++;
		   	 		if (docid.Semaforo__c == 'Amarillo') iyellow++;
		   	 		if (docid.Semaforo__c == 'Verde') igreen++;
		   	 		system.debug('Esta es la oferta....' + docid.Oferta__r.Name);
		   	 	}
		   	 	wrapdocs docaux = new wrapdocs(docetaid, sName, ired, iyellow, igreen);
		   	 	system.debug('Este es le docaux......' + docaux);
			   	ldocaux.add(docaux);
	   	 	}
	   	  } 
	   	                            
		   	
	   	 
	   	 return ldocaux;
   	 }else
   	     return null;
   }
   public Pagereference AdminOfertas()
    {
        return new PageReference('/apex/SupervisionOfertas?retURL=%2F&sfdc.override=1');
    }  
   public class wrapdocs
   {
       public id docid {get;set;}
   	   public string nombre {get;set;}
   	   public integer iRojos {get;set;}
   	   public integer iAmarillos {get;set;}
   	   public integer iVerdes {get;set;}
   	   public Decimal pctjeRojos {get;set;}
   	   public Decimal pctjeAmarillos {get;set;}
   	   public Decimal  pctjeVerdes {get;set;}
   	   public Double tot {get;set;}
   	   
   	   public wrapdocs(id did, string n, integer ir, integer ia, integer iv)
   	   {
   	   	    docid = did;
   	   	    nombre = n;
   	   	    iRojos = ir;
   	   	    iAmarillos = ia;
   	   	    iVerdes = iv;
   	   	    
   	   	    tot = ir + ia + iv;
   	   	    if(tot>0)
   	   	    {
   	   	    pctjeRojos = (ir/tot*100);
   	   	    pctjeAmarillos = (ia/tot*100);
   	   	    pctjeVerdes = (iv/tot*100);
   	   	    pctjeRojos = pctjeRojos.setScale(2);
   	   	    pctjeAmarillos = pctjeAmarillos.setScale(2);
   	   	    pctjeVerdes = pctjeVerdes.setScale(2);
   	   	    }
   	   	   
   	   }
   }
  
}