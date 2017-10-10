public with sharing class BloqueoOfertasController {
   
    public String idLnSelect {get;set;}
    public String filterofta {get;set;}
    public list<Documento__c> ldocup {get;set;}
    public list<Oferta__c> lofertas {get;set;}
    public list<User> lusers = new list<User>();
    map<Oferta__c,list<Documento__c>> mdocs = new map<Oferta__c,list<Documento__c>>();
    map<String, list<Documento__c>> mdocOf = new map<String, list<Documento__c>>();
    public integer offset{get;set;} 
    public integer iLimit; 
    public Integer numHojas{get;set;} 
    public Integer hojasActual{get;set;} 
    public Integer iofertasTotal{get;set;}
    public Integer ofertasXhoja{get;set;}
    public Integer mapsize{get;set;}
    
    public BloqueoOfertasController(){
       
        User oUsuario = [SELECT Id FROM User WHERE Id =: UserInfo.getUserId()]; 
        lusers = [Select Id From User Where ManagerId =: oUsuario.id];
        ofertasXhoja = 50;
        offset = 0;
        ilimit = ofertasXhoja;
        Integer i = 1;
        hojasActual = 1;
        mapsize = 0;
        CargaInfo();
    }
    public void CargaInfo()
    {
        if (mdocOf != null) mdocOf.clear();
        if (filterofta != null)
        {  
            lofertas = [Select id, name, Bloqueada__c, Fecha_Desbloqueo__c, Owner.Name From Oferta__c Where Bloqueada__c =: true and OwnerId IN :lusers];
            ldocup = [SELECT id, Oferta__c, Name, Oferta__r.Bloqueada__c, Oferta__r.Fecha_Desbloqueo__c, Fecha_Inicio__c, 
                      Fecha_Com_Controller__c, Tiempo_Restante__c, DocumentoEtapa__r.Obligatorio__c, Semaforo__c,
                      DocumentoEtapa__r.Tiempo_Proceso__c, EtapaOferta__r.NumEtapa__c, Iniciado__c, Cerrado__c, 
                      DocumentoEtapa__r.Orden__c, Owner.Name
                      FROM Documento__c WHERE Oferta__r.Bloqueada__c =: true AND OwnerId IN :lusers AND Semaforo__c =: 'Rojo' AND
                      DocumentoEtapa__r.Obligatorio__c =: true AND Iniciado__c =: true AND Fecha_Inicio__c !=: null AND Oferta__r.name =: filterofta
                      ORDER BY Oferta__r.name, EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c LIMIT :iLimit OFFSET :offset];
            iofertastotal = [SELECT Count() FROM Documento__c WHERE Oferta__r.Bloqueada__c =: true AND OwnerId IN :lusers AND Semaforo__c =: 'Rojo' AND
                             DocumentoEtapa__r.Obligatorio__c =: true AND Iniciado__c =: true AND Fecha_Inicio__c !=: null AND Oferta__r.name =: filterofta];
            
        }else
        {
            lofertas = [Select id, name, Bloqueada__c, Fecha_Desbloqueo__c, Owner.Name From Oferta__c Where Bloqueada__c =: true and OwnerId IN :lusers];
            ldocup = [SELECT id, Oferta__c, Name, Oferta__r.Bloqueada__c, Oferta__r.Fecha_Desbloqueo__c, Fecha_Inicio__c, 
                      Fecha_Com_Controller__c, Tiempo_Restante__c, DocumentoEtapa__r.Obligatorio__c, Semaforo__c,
                      DocumentoEtapa__r.Tiempo_Proceso__c, EtapaOferta__r.NumEtapa__c, Iniciado__c, Cerrado__c, 
                      DocumentoEtapa__r.Orden__c, Owner.Name
                      FROM Documento__c WHERE Oferta__r.Bloqueada__c =: true AND OwnerId IN :lusers AND Semaforo__c =: 'Rojo' AND
                      DocumentoEtapa__r.Obligatorio__c =: true AND Iniciado__c =: true AND Fecha_Inicio__c !=: null 
                      ORDER BY Oferta__r.name, EtapaOferta__r.NumEtapa__c, DocumentoEtapa__r.Orden__c LIMIT :iLimit OFFSET :offset];
            iofertastotal = [SELECT Count() FROM Documento__c WHERE Oferta__r.Bloqueada__c =: true AND OwnerId IN :lusers AND Semaforo__c =: 'Rojo' AND
                             DocumentoEtapa__r.Obligatorio__c =: true AND Iniciado__c =: true AND Fecha_Inicio__c !=: null];
        }
        numHojas = 0; 
        Double dsizeQ = Double.valueOf(iofertasTotal)/Double.valueOf(ofertasXhoja);
        numHojas = Integer.valueOf(Math.ceil(dsizeQ)); 
        mapsize = 0;
        for (Documento__c doc :ldocup)
        {
            if(mdocOf.get(doc.Oferta__c) == null)
            {
                mdocOf.put(doc.Oferta__c, new list<Documento__c> {doc});
            }else
            {
                mdocOf.get(doc.Oferta__c).add(doc);
            }
            mapsize++;
        }
    }
    public map<Oferta__c,list<Documento__c>> getmdocs()
    {
        if (mdocs != null) mdocs.clear();
        for (Oferta__c ofta :lofertas)
        {
            if(mdocOf.get(ofta.id) != null)
               mdocs.put(ofta,mdocOf.get(ofta.id));
        }
        return mdocs;
    }
    public void Anterior()
    { 
        
        
        offset = offset - ofertasXhoja;
        hojasActual = hojasActual-1;
        CargaInfo();      
    }  
   public void Siguiente()
    { 
        
        offset = offset + ofertasXhoja;
        hojasActual = hojasActual+1;
        CargaInfo();    
    } 
   public void NumPaginaActual()
    { 
        offset = (hojasActual * ofertasXhoja)-ofertasXhoja;
        if (hojasActual>numHojas)
            hojasActual = numHojas;
        if (numHojas==0 || hojasActual == null)
            hojasActual = 1;
        CargaInfo();  
    } 
    public Pagereference Desbloquear()
    {
        return new PageReference('/apex/DesbloqueaOferta?retURL=%2F&sfdc.override=1&id=' + idLnSelect);
        
    }
}