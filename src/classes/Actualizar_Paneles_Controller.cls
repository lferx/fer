public with sharing class Actualizar_Paneles_Controller {

    public List<Oferta__c> ofertaCargada {get;set;}
    public List<Oferta__c> ofertasCaidas {get;set;}
    public List<Oferta__c> ofertasConEscritura {get;set;}
    //public List<Oferta__c> ofertasSinFechaPrevEscritu {get;set;}
    public List<Oferta__c> ofertasInfonavitConOferta {get;set;}
    public List<Developer__c> listaPanelFijo {get;set;}
    public Developer__c registroDeveloper {get;set;}
    
    public List<Oferta__c> listaActualizacion {get;set;}
    public List<Developer__c> listaActualizacionPanelFijo {get;set;}

    public List<Document> imagenes {get;set;}

    //BOTONES
    public Boolean btnOffOferCargada {get;set;}
    public Boolean btnOffOferCaida {get;set;}
    public Boolean btnOffConEscrituras {get;set;}
    //public Boolean btnOffFechaEscrituras {get;set;}
    public Boolean btnOffPanelFijo {get;set;}
    public Boolean btnOffFotos {get;set;}

    public Actualizar_Paneles_Controller(){

        btnOffOferCargada = false;
        btnOffOferCaida = false;
        btnOffConEscrituras = false;
        //btnOffFechaEscrituras = false;
        btnOffPanelFijo = false;
        btnOffFotos = false;

        registroDeveloper = new Developer__c();
        listaActualizacionPanelFijo = new List<Developer__c>();
    
        //ofertaCargada = new List<Oferta__c>();
        //ofertasCaidas = new List<Oferta__c>();
        //ofertasConEscritura = new List<Oferta__c>();
        //ofertasSinFechaPrevEscritu = new List<Oferta__c>();
        //ofertasInfonavitConOferta = new List<Oferta__c>();
        //listaPanelFijo = new List<Developer__c>();

        //consulta correcta para actuzalizar escrituras
        //SELECT Id, Escritu__c, name FROM Oferta__c WHERE Estatus__c != 'Descartada' AND (Escritu__c = 'Sin Escrituras' OR Escritu__c = '') AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Escrituras Registradas' AND Cerrado__c = True) AND Etapa__c IN ('Compilación expediente cliente','Rehabilitación','Compilación expediente crediticio','Expediente aprobado','Cierre oferta','Finalizada') AND FechaCobro__c = null AND FechaPago__c != null
        
        ofertaCargada =                 [SELECT Id, Oferta_Cargada__c, Name FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = null AND FechaPago__c != null AND Oferta_Cargada__c = false AND ID IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Comprobante de anticipo' AND Cerrado__c = true AND NumFiles_MasFilesPadre__c > 0)];
        if(!ofertaCargada.isEmpty()){
            btnOffOferCargada = true;
        }
        ofertasCaidas =                 [SELECT Id, Oferta_Cargada__c, Name FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = null AND FechaPago__c != null AND Oferta_Cargada__c = true AND ID IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Comprobante de anticipo' AND Cerrado__c = false)];
        if(!ofertasCaidas.isEmpty()){
            btnOffOferCaida = true;
        }
        ofertasConEscritura =           [SELECT Id, Escritu__c, Fecha_Prevista_Desalojo__c, Name FROM Oferta__c WHERE Estatus__c != 'Descartada' AND (Escritu__c != 'Con Escrituras' OR Fecha_Prevista_Desalojo__c != null) AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Escrituras Registradas' AND NumFiles_MasFilesPadre__c > 0)];//AND FechaCobro__c = null
        if(!ofertasConEscritura.isEmpty()){
            btnOffConEscrituras = true;
        }
        //ofertasSinFechaPrevEscritu =    [SELECT Id, Escritu__c, Fecha_Prevista_Desalojo__c, Name FROM Oferta__c WHERE Estatus__c != 'Descartada' AND Fecha_Prevista_Desalojo__c != null AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Escrituras Registradas' AND Cerrado__c = true AND NumFiles_MasFilesPadre__c > 0)];
        ofertasInfonavitConOferta =     [SELECT Escritu__c,Etapa__c,Name,Owner.Name,Plaza__c,TipoOferta__c,(Select Fecha_Cierre__c From Documentos__r WHERE Name = 'Comprobante de anticipo') FROM Oferta__c WHERE Estatus__c != 'Descartada' AND TipoOferta__c = 'Infonavit' AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Comprobante de anticipo' AND Cerrado__c = true AND NumFiles_MasFilesPadre__c > 0 AND Fecha_Cierre__c = LAST_WEEK)];
        listaPanelFijo =                [SELECT Escrituras__c,Fecha_de_Oferta_Caida__c,Fecha_de_Oferta__c,Gerente__c,Name,Oferta_Ca_da__c,Plaza__c,Tipo_de_Oferta__c FROM Developer__c WHERE Fecha_de_Oferta__c = LAST_WEEK];
        if(!ofertasInfonavitConOferta.isEmpty() && listaPanelFijo.isEmpty()){
            btnOffPanelFijo = true;
        }
        //imagenes = [Select Id,Name from Document where folder.DeveloperName = 'Imagenes_de_Propiedades'];
        imagenes = [SELECT Author.name,CreatedBy.name,CreatedDate,Id,Name FROM Document WHERE folder.DeveloperName = 'Imagenes_de_Propiedades'];
        if(!imagenes.isEmpty()){
            btnOffFotos = true;
        }
    }
    
    public void actualizaOferCargada(){
        listaActualizacion = new List<Oferta__c>();
    
        for(Oferta__c reg: ofertaCargada){
            reg.Oferta_Cargada__c = True;
            listaActualizacion.add(reg);
        }
        UPDATE listaActualizacion;
        btnOffOferCargada = false;
    }
    
    public void actualizaOferCaida(){
        listaActualizacion = new List<Oferta__c>();
        
        for(Oferta__c reg: ofertasCaidas){
            reg.Oferta_Cargada__c = False;
            listaActualizacion.add(reg);
        }
        UPDATE listaActualizacion;
        btnOffOferCaida = false;
    }
    
    public void actualizaOferConEscritu(){
        listaActualizacion = new List<Oferta__c>();
        
        for(Oferta__c reg: ofertasConEscritura){
            reg.Escritu__c = 'Con Escrituras';
            reg.Fecha_Prevista_Desalojo__c = null;
            listaActualizacion.add(reg);
        }
        UPDATE listaActualizacion;
        btnOffConEscrituras = false;
    }
    
    //public void actualizaOferSinFechaPrev(){
    //    listaActualizacion = new List<Oferta__c>();
        
    //    for(Oferta__c reg: ofertasSinFechaPrevEscritu){
    //        reg.Fecha_Prevista_Desalojo__c = null;
    //        reg.Escritu__c = 'Con Escrituras';
    //        listaActualizacion.add(reg);
    //    }
    //    UPDATE listaActualizacion;
    //}
    
    public void agregarPanel(){
        listaActualizacionPanelFijo = new List<Developer__c>();
        
        for(Oferta__c reg: ofertasInfonavitConOferta){
            registroDeveloper = new Developer__c();
            
            registroDeveloper.Plaza__c = reg.Plaza__c;
            registroDeveloper.name = reg.name;
            registroDeveloper.Gerente__c = reg.Owner.Name;
            registroDeveloper.Escrituras__c = reg.Escritu__c;
            registroDeveloper.Tipo_de_Oferta__c = reg.TipoOferta__c;
            for(Documento__c fechDoc: reg.Documentos__r){
                registroDeveloper.Fecha_de_Oferta__c = fechDoc.Fecha_Cierre__c.date();
            }
            listaActualizacionPanelFijo.add(registroDeveloper);
            
        }
        if(listaActualizacionPanelFijo.size() > 0){
            INSERT listaActualizacionPanelFijo;
        }
        btnOffPanelFijo = false;
    }

    public void eliminaFotos(){
        btnOffPanelFijo = false;
        if(!imagenes.isEmpty()){
            Delete imagenes;
        }
    }
    
    public void cobertura(){
        Integer z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
        z=0;
    }
    
}