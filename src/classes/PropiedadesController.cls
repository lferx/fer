global with sharing class PropiedadesController {
    public String estadoSeleccionado {get;set;}
    public List<Attachment> fotos {get;set;}
    public Map<String,String> mapaFotos {get;set;}

    public PropiedadesController(){
        estadoSeleccionado = '';
    }
    public PropiedadesController(MapaBusquedaController controller) {
        estadoSeleccionado = '';
    }
    
    public void refresh(){
        
    }

    public Integer countProp{
        get{
            return [select count() from Propiedad__c WHERE Name<>'' and (Geolocalizada__c='' or Geolocalizada__c='No')];
        }
        set;
    }
    
    public Integer countProp2{
        get{
            return [select count() from Propiedad__c WHERE Name<>''];
        }
        set;
    }
    
    public Integer countPropAll{
        get{
            
            return [select count() from Propiedad__c];
        }
        set;
    }
    
    public String txtPlaza{get; set;}

    @RemoteAction 
    global static List<Propiedad__c> buscar(integer listSize, integer pagina, String parametros){
        Map<String, Object> mapParametros = (Map<String, Object>) JSON.deserializeUntyped(parametros);
        Set <String> setParametros = new Set<String>();
        setParametros = mapParametros.keySet();
        String sQuery ='';
        //String sWhere = 'Name<>\'\' and Geolocalizada__c=\''+mapParametros.get('Geolocalizada__c')+'\'' ;
        String sWhere = 'Name<>\'\' ' ;
        
        Propiedad__c[] propiedades = null;


        Integer offset = listSize*(pagina-1);
        
        //sQuery = 'SELECT Id, Name, Punto__Latitude__s, Punto__Longitude__s, Calle__c, Colonia__c, Municipio__c, Estado__c, CP__c, Direccion__c, DireccionCorta__c, Geolocalizada__c, DirMaps__c FROM Propiedad__c WHERE ' + sWhere +' LIMIT '+listSize+' OFFSET '+offset;
        sQuery = 'SELECT Id, Name, Punto__Latitude__s, Punto__Longitude__s, Calle__c, Colonia__c, Municipio__c, Estado__c, CP__c, Geolocalizada__c FROM Propiedad__c WHERE ' + sWhere +' LIMIT '+listSize+' OFFSET '+offset;
        try{
            propiedades = Database.query(sQuery);
        }catch(QueryException e){
            sQuery = e.getMessage() + ' sQuery:' + sQuery;
            propiedades = new List<Propiedad__c>();
        }
        return propiedades;
    }

    @RemoteAction 
    global static Integer buscarAllCount(String parametros){
        system.debug(parametros);
        Map<String, Object> mapParametros = (Map<String, Object>) JSON.deserializeUntyped(parametros);
        Set <String> setParametros = new Set<String>();
        setParametros = mapParametros.keySet();
        String sQuery ='';
        String sWhere = 'Geolocalizada__c=\'Si\' and Name<>\'\' AND ';
        
        for(String key:setParametros){
            if(mapParametros.get(key) != ('Todos')){
                sWhere =  sWhere + key + ' = \'' + mapParametros.get(key) + '\'' + ' AND ';
            }
        }
        sWhere = sWhere.substring(0,sWhere.length() - 5);
        
        Propiedad__c[] propiedades = null;

        sQuery = 'SELECT COUNT() FROM Propiedad__c WHERE ' + sWhere;
        system.debug(sQuery);
        Integer totalRegistro = 0;
        try{
            totalRegistro = Database.countQuery(sQuery);
        }catch(QueryException e){
            sQuery = e.getMessage() + ' sQuery:' + sQuery;
            totalRegistro = 0;
        }
        system.debug(totalRegistro);
        return totalRegistro;
    }

    @RemoteAction 
    global static List<Propiedad__c> buscarAll(integer listSize, integer pagina, String parametros){
        Map<String, Object> mapParametros = (Map<String, Object>) JSON.deserializeUntyped(parametros);
        Set <String> setParametros = new Set<String>();
        setParametros = mapParametros.keySet();
        String sQuery ='';
        String sWhere = 'Geolocalizada__c=\'Si\' and Name<>\'\' AND ';
        
        for(String key:setParametros){
            if(mapParametros.get(key) != ('Todos')){
                sWhere =  sWhere + key + ' = \'' + mapParametros.get(key) + '\'' + ' AND ';
            }
        }
        sWhere = sWhere.substring(0,sWhere.length() - 5);
        
        Propiedad__c[] propiedades = null;


        Integer offset = listSize*(pagina-1);
        
        //sQuery = 'SELECT Id, Name, Punto__Latitude__s, Punto__Longitude__s, Calle__c, Colonia__c, Municipio__c, Estado__c, CP__c, Direccion__c, DireccionCorta__c, Geolocalizada__c, DirMaps__c FROM Propiedad__c WHERE ' + sWhere +' LIMIT '+listSize+' OFFSET '+offset;
        sQuery = 'SELECT Id, Name, Punto__Latitude__s, Punto__Longitude__s, Calle__c, Colonia__c, Municipio__c, Estado__c, CP__c, Geolocalizada__c FROM Propiedad__c WHERE ' + sWhere +' LIMIT '+listSize+' OFFSET '+offset;
        system.debug(sQuery);
        try{
            propiedades = Database.query(sQuery);
        }catch(QueryException e){
            sQuery = e.getMessage() + ' sQuery:' + sQuery;
            propiedades = new List<Propiedad__c>();
        }
        return propiedades;
    }
    
    
    @RemoteAction
    global static String guardarPuntoEncontrado(String idPropiedad, String lat, String lng, String direccion){
        try{
            Propiedad__c updProp = new Propiedad__c(
                Id=idPropiedad, 
                Punto__Latitude__s=Double.valueOf(lat), 
                Punto__Longitude__s=Double.valueOf(lng),
                Geolocalizada__c='Si',
                DirMaps__c=direccion
            );
            if(direccion==''){
                updProp.Geolocalizada__c='No';
            }
            update updProp;
            return 'OK';
        }catch(Exception e){
            return 'ERROR '+e;
        }
        
    }
    
    public List<String> plazas{
        get{
            List<String> plazas = new List<String>();
            for(AggregateResult ar : [select Count(Id), Plaza__c from Propiedad__c group by Plaza__c]){
                String plaza = (String)ar.get('Plaza__c');
                Integer registros = (Integer)ar.get('expr0');
                plazas.add(plaza);
            }
            plazas.sort();
            return plazas;
        }
        set;
    }
    
    public List<String> tipos{
        get{
            tipos = new List<String>();
            Schema.DescribeFieldResult picklistTipos = Propiedad__c.Tipo__c.getDescribe();
            for (Schema.PicklistEntry tipo : picklistTipos.getPicklistValues()) {
                tipos.add(tipo.getValue());
            }
            tipos.sort();
            return tipos;
        }
        set;
    }
    
    public List<String> estados{
        get{
            List<String> estados = new List<String>{'Aguascalientes','Baja California','Baja California Sur','Campeche',
                                                    'Coahuila','Colima','Chiapas','Chihuahua',
                                                    'Distrito Federal','Durango','Guanajuato','Guerrero',
                                                    'Hidalgo','Jalisco','México','Michoacán',
                                                    'Morelos','Nayarit','Nuevo León','Oaxaca',
                                                    'Puebla','Querétaro','Quintana Roo','San Luis Potosí',
                                                    'Sinaloa','Sonora','Tabasco','Tamaulipas',
                                                    'Tlaxcala','Veracruz','Yucatán','Zacatecas'};
            return estados;
        }
        set;
    }
    
    
    //Para buscar con campo Estado__C
    public map<String,String> mapEstados{
        get{
              map<String,String> mapEstados = new map<String,String>();
              mapEstados.put('Todos','Estado');
              mapEstados.put('AGS','Aguascalientes');
              mapEstados.put('BCN','Baja California');
              mapEstados.put('BCS','Baja California Sur');
              mapEstados.put('CAM','Campeche');
              mapEstados.put('CHI','Chihuahua');
              mapEstados.put('CHP','Chiapas');
              mapEstados.put('COA','Coahuila de Zaragoza');
              mapEstados.put('COL','Colima');
              mapEstados.put('DIF','Distrito Federal');
              mapEstados.put('DUR','Durango');
              mapEstados.put('GRO','Guerrero');
              mapEstados.put('GTO','Guanajuato');
              mapEstados.put('HGO','Hidalgo');
              mapEstados.put('JAL','Jalisco');
              mapEstados.put('MEX','México');
              mapEstados.put('MIC','Michoacán');
              mapEstados.put('MOR','Morelos');
              mapEstados.put('NAY','Nayarit');
              mapEstados.put('NLE','Nuevo León');
              mapEstados.put('OAX','Oaxaca');
              mapEstados.put('PUE','Puebla');
              mapEstados.put('QRO','Querétaro');
              mapEstados.put('ROO','Quintana Roo');
              mapEstados.put('SIN','Sinaloa');
              mapEstados.put('SLP','San Luis Potosí');
              mapEstados.put('SON','Sonora');
              mapEstados.put('TAB','Tabasco');
              mapEstados.put('TAM','Tamaulipas');
              mapEstados.put('TLX','Tlaxcala');
              mapEstados.put('VER','Veracruz');
              mapEstados.put('YUC','Yucatán');
              mapEstados.put('ZAC','Zacatecas');
              return mapEstados;
        }set;
    }
    
    /*Para buscar con Esado3__c
    public map<String,String> mapEstados{
        get{
              map<String,String> mapEstados = new map<String,String>();
              mapEstados.put('Todos','Estado');
              mapEstados.put('Aguascalientes','Aguascalientes');
              mapEstados.put('Baja California','Baja California');
              mapEstados.put('Baja California Sur','Baja California Sur');
              mapEstados.put('Campeche','Campeche');
              mapEstados.put('Chihuahua','Chihuahua');
              mapEstados.put('Chiapas','Chiapas');
              mapEstados.put('Coahuila','Coahuila de Zaragoza');
              mapEstados.put('Colima','Colima');
              mapEstados.put('Federal District','Distrito Federal');
              mapEstados.put('Durango','Durango');
              mapEstados.put('Guerrero','Guerrero');
              mapEstados.put('Guanajuato','Guanajuato');
              mapEstados.put('Hidalgo','Hidalgo');
              mapEstados.put('Jalisco','Jalisco');
              mapEstados.put('State of Mexico','México');
              mapEstados.put('Michoacán','Michoacán');
              mapEstados.put('Morelos','Morelos');
              mapEstados.put('Nayarit','Nayarit');
              mapEstados.put('Nuevo Leon','Nuevo León');
              mapEstados.put('Oaxaca','Oaxaca');
              mapEstados.put('Puebla','Puebla');
              mapEstados.put('Querétaro','Querétaro');
              mapEstados.put('Quintana Roo','Quintana Roo');
              mapEstados.put('Sinaloa','Sinaloa');
              mapEstados.put('San Luis Potosi','San Luis Potosí');
              mapEstados.put('Sonora','Sonora');
              mapEstados.put('Tabasco','Tabasco');
              mapEstados.put('Tamaulipas','Tamaulipas');
              mapEstados.put('Tlaxcala','Tlaxcala');
              mapEstados.put('Veracruz','Veracruz');
              mapEstados.put('Yucatán','Yucatán');
              mapEstados.put('Zacatecas','Zacatecas');
              return mapEstados;
        }set;
    }*/
    public List<SelectOption> estadosItems{
        //Solo se muestran los que tienen propiedad
        get{
             List<SelectOption> estadosItems = new List<SelectOption>();
              estadosItems.add(new SelectOption('Todos','Estado'));
              AggregateResult[] groupedResults = [SELECT Estado__c FROM Propiedad__c WHERE (Punto__Latitude__s != null and Estado__c != null) group by Estado__c Order by Estado__c ASC];
              //AggregateResult[] groupedResults = [SELECT Estado3__c FROM Propiedad__c WHERE (Punto__Latitude__s != null and Estado3__c != null) group by Estado3__c Order by Estado3__c ASC ];
              for(AggregateResult ar:groupedResults){
                    //String key = ''+ar.get('Estado__c');
                    String key = ''+ar.get('Estado__c');
                    if(mapEstados.containsKey(key)){
                       estadosItems.add(new SelectOption(key,mapEstados.get(key)));
                    }
              }
              
           return estadosItems;
        }
        set;
    }
    
    public map<String,list<String>> mapEstadoCiudad{
        get{
            mapEstadoCiudad = new map<String,list<String>>();
            map<String,set<String>> mapEstadoCiudadAux = new map<String,set<String>>();

            AggregateResult[] groupedResults = [SELECT Estado__c,Municipio__c FROM Propiedad__c WHERE (Punto__Latitude__s != null and Estado__c != null) group by Estado__c,Municipio__c  LIMIT 10000];
            //AggregateResult[] groupedResults3 = [SELECT Estado__c,Municipio__c,Municipio3__c FROM Propiedad__c WHERE (Punto__Latitude__s != null and Estado__c != null) group by Estado__c,Municipio__c,Municipio3__c ];
            //AggregateResult[] groupedResults3 = [SELECT Estado3__c,Municipio3__c FROM Propiedad__c WHERE (Punto__Latitude__s != null and Estado3__c != null) group by Estado3__c,Municipio3__c ];
            mapEstadoCiudad.put('',new list<String>{'Todos'});
            for (AggregateResult ar : groupedResults)  {
                String key = ''+ar.get('Estado__c');
                String municipio = ''+ar.get('Municipio__c');
                municipio = municipioFormato(municipio);

                if(municipio == '' || municipio == null || municipio == 'Null'){
                    municipio = 'S/M';
                }
                if(!mapEstadoCiudad.containsKey(key)){
                    mapEstadoCiudad.put(key,new list<String>());
                    mapEstadoCiudadAux.put(key,new set<String>());
                }
                mapEstadoCiudadAux.get(key).add(municipio);
                //mapEstadoCiudad.get(key).add(municipio);
            }

            for(String key : mapEstadoCiudadAux.keySet()){
                mapEstadoCiudad.get(key).addAll(mapEstadoCiudadAux.get(key));
            }
            return mapEstadoCiudad;
        }
        set;
    }

    public List<Propiedad__c> propiedades
    {
        get
        {
            List<Propiedad__c> propiedades = new List<Propiedad__c>();
            try {
                propiedades = [SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,
                                 ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, 
                                 FechaPublicacionWeb__c, Construccion_m2__c, EstatusVenta2__c, FolioWeb__c, Views__c, EstatusWeb__c, PrecioVenta__c FROM Propiedad__c WHERE EstatusWeb__c = 'Publicada' and EstatusVenta2__c = 'En venta' and Plaza__c !='Distrito Federal' and Plaza__c !='Estado de Mexico' ORDER BY Views__c DESC  LIMIT 8];
                Set<String> ids = new Set<String>();
                for (Propiedad__c propiedad : propiedades) {
                    ids.add(propiedad.Id);
                }
                fotos = [SELECT Id,Name,ParentId FROM Attachment WHERE ParentId IN :ids];
                mapaFotos = new Map<String,String>();
                for (Attachment foto : fotos) {
                    mapaFotos.put(foto.ParentId ,foto.Id);
                }
                for (String id : ids) {
                    if (!mapaFotos.containsKey(id)) {
                        mapaFotos.put(id ,'-');
                    }
                }
                System.debug('Fotos: ' + mapaFotos);
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
            return propiedades;
        }
        set;
        
    }
    
    private String municipioFormato(String municipio){
        if(municipio != null){
            municipio = municipio.toLowerCase().capitalize();
        }
        return municipio;
    }
}