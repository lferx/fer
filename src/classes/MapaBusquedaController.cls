public without sharing class MapaBusquedaController {
  public String plaza {get;set;}
  public String estado {get;set;}
  public String ciudad  {get;set;}
  public String cp  {get;set;}
  public String tipo {get;set;}
  
  public String orderBy { get; set; }
  public String sortOrder { get; set; }
  public Integer pageNumber { get; set; }
  public Integer pageSize { get; set; }
  public Integer resultSize { get; private set; }
  public Integer totalPages { get; private set; }
  public Integer pageStart { get; private set; }
  public Integer pageEnd { get; private set; }
  public list<Integer> listpages {get;set;}
  
  public String priceFrom{get;set;}
  public String priceTo{get;set;}
  
  public String m2From{get;set;}
  public String m2To{get;set;}
  
  public String m2ConstruccionFrom {get;set;}
  public String m2ConstruccionTo {get;set;}
  
  public String estatusVenta {get;set;}
  
  public map<Id,String> mapImagenesMini {get;set;}
  
  public list<Propiedad__c> propiedades{get; set;}
  public list<Propiedad__c> propiedades2{get; set;}
  public String centroPropiedad{get;set;} 
  
  public String idsPropiedades{get; set;}
  
  public class Propiedad{
    public Propiedad__c[] propiedades {get;set;}
    public Propiedad(Propiedad__c[] propiedades){
      this.propiedades = propiedades;
    }
  }
  
  public MapaBusquedaController(){
    estado = (String)ApexPages.CurrentPage().getParameters().get('estado') == null? '': (String)ApexPages.CurrentPage().getParameters().get('estado');
    ciudad = (String)ApexPages.CurrentPage().getParameters().get('ciudad') == null? '': (String)ApexPages.CurrentPage().getParameters().get('ciudad');
    tipo = (String)ApexPages.CurrentPage().getParameters().get('tipo') == null? '': (String)ApexPages.CurrentPage().getParameters().get('tipo');
    plaza = (String)ApexPages.CurrentPage().getParameters().get('plaza')  == null? '': (String)ApexPages.CurrentPage().getParameters().get('plaza');
    centroPropiedad = (String)ApexPages.CurrentPage().getParameters().get('centroPropiedad')  == null? '': (String)ApexPages.CurrentPage().getParameters().get('centroPropiedad');
    propiedades = new list<Propiedad__c>();
    orderBy = 'Name';
    sortOrder = 'ASC';
    pageNumber = 1;
    pageSize = 10;
        totalPages = 0;
    tipo = tipo.equals('Todos') ? '': tipo;
    plaza = plaza.equals('Todos') ? '': plaza;
    estado = estado.equals('Todos') ? '': estado;
    ciudad = ciudad.equals('Todos') ? '': ciudad;
    estatusVenta = '';
    mapImagenesMini =  new map<Id,String>();
    idsPropiedades = '';
    searchPropiedades();
  }

  public List<Propiedad__c> propiedadesbusqueda()
    {
       
      system.debug('Inicio de llamado');
      String sQuery = '';
      String whereGeneral = '';
      String whereArgs = '';
      String wherePrice = '';
      String whereConstruccion = '';
      String whereM2 = '';
      String whereIds  = '';
      String whereVenta = '';
      
      tipo = tipo.equals('Todos') ? '': tipo;
      plaza = plaza.equals('Todos') ? '': plaza;
      estado = estado.equals('Todos') ? '': estado;
      ciudad = ciudad.equals('Todos') ? '': ciudad;
      propiedades = new list<Propiedad__c>();
      Integer estadoStatus = 0;
      Integer ciudadStatus = 0;
      Integer tipoStatus = 0;
      //RJP -> Se retira el campo Control__c
      whereArgs = 'EstatusWeb__c = \'Publicada\' AND Punto__Latitude__s != null ';

      if(!estado.equals('')){
        whereArgs+= 'AND Estado__c LIKE \'%'+ estado + '%\' ';
        //whereArgs+= 'AND Estado3__c = \''+ estado + '\' ';
      }
      if(!plaza.equals('')){
        whereArgs+= 'AND Plaza__c LIKE \'%' + plaza + '%\' ';
      }
      if(!ciudad.equals('')){
        whereArgs+= 'AND Municipio__c LIKE \'%'+  ciudad +'%\' ';
      }
      if(!tipo.equals('')){
        whereArgs+= 'AND Tipo__c LIKE \'%' + tipo +'%\' ';
      }
      
      if(priceFrom  != null && priceTo != null && !priceFrom.equals('')  && !priceTo.equals('')){
        wherePrice = ' AND (ValorReferencia__c >= ' + priceFrom + ' AND ValorReferencia__c <= ' + priceTo.replace(',', '') + ')';
      }else if(priceFrom  != null  && !priceFrom.equals('')){
        wherePrice =  ' AND (ValorReferencia__c >= ' + priceFrom + ')';
      }else if(priceTo != null && !priceTo.equals('')){
        wherePrice = ' AND (ValorReferencia__c <= ' + priceTo + ')';
      }
      
      if(m2From  != null && m2To != null && !m2From.equals('')  && !m2To.equals('')){
        whereM2 = ' AND (Terreno_m2__c >= ' + m2From + ' AND Terreno_m2__c <= ' +m2To.replace(',', '') + ')';
      }else if(m2From  != null  && !m2From.equals('')){
        whereM2 =  ' AND (Terreno_m2__c >= ' + m2From + ')';
      }else if(m2To != null && !m2To.equals('')){
        whereM2 = ' AND (Terreno_m2__c <= ' + m2To + ')';
      }
      
      if(m2ConstruccionFrom  != null && m2ConstruccionTo != null && !m2ConstruccionFrom.equals('')  && !m2ConstruccionTo.equals('')){
        whereConstruccion = ' AND (Construccion_m2__c >= ' + m2ConstruccionFrom + ' AND Construccion_m2__c <= ' +m2ConstruccionTo.replace(',', '') + ')';
      }else if(m2ConstruccionFrom  != null  && !m2ConstruccionFrom.equals('')){
        whereConstruccion =  ' AND (Construccion_m2__c >= ' + m2ConstruccionFrom + ')';
      }else if(m2ConstruccionTo != null && !m2ConstruccionTo.equals('')){
        whereConstruccion = ' AND (Construccion_m2__c<= ' + m2ConstruccionTo + ')';
      }
      
      if(estatusVenta != null){
        list<String> estatusArray = estatusVenta.split(',');
        String estatusfinal = '';
        for(String estatus:estatusArray){
          estatusfinal =  '\'' + estatus + '\',' + estatusfinal;
        }
        estatusfinal = estatusfinal.length() > 1  ? estatusfinal.substring(0,estatusfinal.length() -1) : '';
        whereVenta =  ' AND EstatusVenta2__c NOT IN (\'Descartada\',' + estatusfinal +',\'\') ';
      }
      
      for(String id : idsPropiedades.split(',') ){
        if(id.length() > 0){
          whereIds = whereIds + '\'' + id + '\',';
        }
      }
      
      if( whereIds.length() > 0 ){ 
        whereIds = whereIds.substring(0,whereIds.length() - 1);
        String ids = whereIds;
        whereIds = 'AND id IN (' + whereIds + ') ';
      }
      whereArgs = whereArgs + wherePrice + whereM2 + whereConstruccion + whereVenta + whereIds;
      System.debug('## searchPropiedades : '+whereArgs);
      try {
        resultSize = Database.countQuery('SELECT count() FROM Propiedad__c WHERE '+ whereArgs);
        totalPages = Math.mod(resultSize,pageSize) > 0 ? resultSize/pageSize+1 : resultSize/pageSize;
        /*Paginación*/
        listpages = new list<Integer>();
        Integer tope = 7;
        Integer preMostrar = pageNumber >= tope ? pageNumber + 3 : tope; 
        Integer totalMostrar =  totalPages > tope && pageNumber != totalPages? preMostrar : totalPages;
        Integer comienzo = pageNumber >= tope ? pageNumber -3 : 1;
        for(Integer i = comienzo ; i <= totalMostrar;i++){
          listpages.add(i);
        }
        pageNumber = pageNumber > totalPages ? (totalPages == 0 ? 1 : totalPages) : pageNumber;
        pageStart = pageSize*(pageNumber-1)+1;
        pageEnd = pageSize*pageNumber > resultSize ? resultSize : pageSize*pageNumber;
        Integer offset = pageSize*(pageNumber-1);
        sQuery = 'SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,' +
                 'ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, ' +
                 'FechaPublicacionWeb__c, Construccion_m2__c, EstatusVenta2__c, FolioWeb__c, Estacionamiento__c, N_de_Ba_os__c, N_de_Habitaciones__c, Patios__c, Niveles_Plantas__c '+
             'FROM Propiedad__c ' + 
             'WHERE '+ whereArgs;
        
        if(!centroPropiedad.equals('')){
          Double lat = Double.valueOf(centroPropiedad.split(',')[0]);
          Double lng =  Double.valueOf(centroPropiedad.split(',')[1]);
          String lmt = tipoStatus==1 && estadoStatus==1 && ciudadStatus==1 ? '': ' LIMIT 5000';
          whereGeneral = lmt;
          sQuery = sQuery + whereGeneral;
          for(Propiedad__c prop : Database.query(sQuery)){
            Decimal dist = PropiedadDetalleController.distanciaDos (lat,lng,prop.Punto__Latitude__s,prop.Punto__Longitude__s) * 1000;
            prop.N_de_Ba_os__c= prop.N_de_Ba_os__c.subString(0,3);
        	system.debug('prop.N_de_Ba_os__c'+prop.N_de_Ba_os__c);
          	prop.N_de_Habitaciones__c= prop.N_de_Habitaciones__c.subString(0,3);
         	system.debug('prop.N_de_Habitaciones__c'+prop.N_de_Habitaciones__c);
            if(dist < = 500){
                propiedades2.add(prop);
              }
          }
        }else{
          whereGeneral = +' ORDER BY '+orderBy+' '+sortOrder+' LIMIT '+pageSize+'  OFFSET '+offset;
          sQuery = sQuery + whereGeneral;
          propiedades2 = Database.query(sQuery);
        }
        getUrlImage();
       // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, sQuery));
      }catch(Exception e){
        System.debug('ERROR ' + e.getMessage());
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'sQuery:' + sQuery + ',' +e.getMessage() ));
      }
            return propiedades2;
       
        
    }
  
  public void searchPropiedades(){
    String sQuery = '';
    String whereGeneral = '';
    String whereArgs = '';
    String wherePrice = '';
    String whereConstruccion = '';
    String whereM2 = '';
    String whereIds  = '';
    String whereVenta = '';
    
    tipo = tipo.equals('Todos') ? '': tipo;
    plaza = plaza.equals('Todos') ? '': plaza;
    estado = estado.equals('Todos') ? '': estado;
    ciudad = ciudad.equals('Todos') ? '': ciudad;
    propiedades = new list<Propiedad__c>();
    //RJP -> Se retira el campo Control__c
    whereArgs = 'EstatusWeb__c = \'Publicada\' AND Punto__Latitude__s != null ';

    if(!estado.equals('')){
      whereArgs+= 'AND Estado__c LIKE \'%'+ estado + '%\' ';
      //whereArgs+= 'AND Estado3__c = \''+ estado + '\' ';
    }
    if(!plaza.equals('')){
      whereArgs+= 'AND Plaza__c LIKE \'%' + plaza + '%\' ';
    }
    if(!ciudad.equals('')){
      whereArgs+= 'AND Municipio__c LIKE \'%'+  ciudad +'%\' ';
    }
    if(!tipo.equals('')){
      whereArgs+= 'AND Tipo__c LIKE \'%' + tipo +'%\' ';
    }
    
    if(priceFrom  != null && priceTo != null && !priceFrom.equals('')  && !priceTo.equals('')){
      wherePrice = ' AND (ValorReferencia__c >= ' + priceFrom + ' AND ValorReferencia__c <= ' + priceTo.replace(',', '') + ')';
    }else if(priceFrom  != null  && !priceFrom.equals('')){
      wherePrice =  ' AND (ValorReferencia__c >= ' + priceFrom + ')';
    }else if(priceTo != null && !priceTo.equals('')){
      wherePrice = ' AND (ValorReferencia__c <= ' + priceTo + ')';
    }
    
    if(m2From  != null && m2To != null && !m2From.equals('')  && !m2To.equals('')){
      whereM2 = ' AND (Terreno_m2__c >= ' + m2From + ' AND Terreno_m2__c <= ' +m2To.replace(',', '') + ')';
    }else if(m2From  != null  && !m2From.equals('')){
      whereM2 =  ' AND (Terreno_m2__c >= ' + m2From + ')';
    }else if(m2To != null && !m2To.equals('')){
      whereM2 = ' AND (Terreno_m2__c <= ' + m2To + ')';
    }
    
    if(m2ConstruccionFrom  != null && m2ConstruccionTo != null && !m2ConstruccionFrom.equals('')  && !m2ConstruccionTo.equals('')){
      whereConstruccion = ' AND (Construccion_m2__c >= ' + m2ConstruccionFrom + ' AND Construccion_m2__c <= ' +m2ConstruccionTo.replace(',', '') + ')';
    }else if(m2ConstruccionFrom  != null  && !m2ConstruccionFrom.equals('')){
      whereConstruccion =  ' AND (Construccion_m2__c >= ' + m2ConstruccionFrom + ')';
    }else if(m2ConstruccionTo != null && !m2ConstruccionTo.equals('')){
      whereConstruccion = ' AND (Construccion_m2__c<= ' + m2ConstruccionTo + ')';
    }
    
    if(estatusVenta != null){
      list<String> estatusArray = estatusVenta.split(',');
      String estatusfinal = '';
      for(String estatus:estatusArray){
        estatusfinal =  '\'' + estatus + '\',' + estatusfinal;
      }
      estatusfinal = estatusfinal.length() > 1  ? estatusfinal.substring(0,estatusfinal.length() -1) : '';
      whereVenta =  ' AND EstatusVenta2__c NOT IN (\'Descartada\',' + estatusfinal +',\'\') ';
    }
    
    for(String id : idsPropiedades.split(',') ){
      if(id.length() > 0){
        whereIds = whereIds + '\'' + id + '\',';
      }
    }
    
    if( whereIds.length() > 0 ){ 
      whereIds = whereIds.substring(0,whereIds.length() - 1);
      String ids = whereIds;
      whereIds = 'AND id IN (' + whereIds + ') ';
    }
    whereArgs = whereArgs + wherePrice + whereM2 + whereConstruccion + whereVenta + whereIds;
    System.debug('## searchPropiedades : '+whereArgs);
    try {
      resultSize = Database.countQuery('SELECT count() FROM Propiedad__c WHERE '+ whereArgs);
      totalPages = Math.mod(resultSize,pageSize) > 0 ? resultSize/pageSize+1 : resultSize/pageSize;
      /*Paginación*/
      listpages = new list<Integer>();
      Integer tope = 7;
      Integer preMostrar = pageNumber >= tope ? pageNumber + 3 : tope; 
      Integer totalMostrar =  totalPages > tope && pageNumber != totalPages? preMostrar : totalPages;
      Integer comienzo = pageNumber >= tope ? pageNumber -3 : 1;
      for(Integer i = comienzo ; i <= totalMostrar;i++){
        listpages.add(i);
      }
      pageNumber = pageNumber > totalPages ? (totalPages == 0 ? 1 : totalPages) : pageNumber;
      pageStart = pageSize*(pageNumber-1)+1;
      pageEnd = pageSize*pageNumber > resultSize ? resultSize : pageSize*pageNumber;
      Integer offset = pageSize*(pageNumber-1);
      sQuery = 'SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,' +
               'ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, ' +
               'FechaPublicacionWeb__c, Construccion_m2__c, EstatusVenta2__c, FolioWeb__c, Estacionamiento__c, N_de_Ba_os__c, N_de_Habitaciones__c, Patios__c, Niveles_Plantas__c '+
           'FROM Propiedad__c ' + 
           'WHERE '+ whereArgs;
      
      if(!centroPropiedad.equals('')){
        Double lat = Double.valueOf(centroPropiedad.split(',')[0]);
        Double lng =  Double.valueOf(centroPropiedad.split(',')[1]);
        whereGeneral = '';
        sQuery = sQuery + whereGeneral;
        for(Propiedad__c prop : Database.query(sQuery)){
          Decimal dist = PropiedadDetalleController.distanciaDos (lat,lng,prop.Punto__Latitude__s,prop.Punto__Longitude__s) * 1000;
        	prop.N_de_Ba_os__c= prop.N_de_Ba_os__c.subString(0,3);
        	system.debug('prop.N_de_Ba_os__c'+prop.N_de_Ba_os__c);
          	prop.N_de_Habitaciones__c= prop.N_de_Habitaciones__c.subString(0,3);
         	system.debug('prop.N_de_Habitaciones__c'+prop.N_de_Habitaciones__c);
          if(dist < = 500){
              propiedades.add(prop);
              
            }
        }propiedades2= propiedades;
      }else{
        whereGeneral = +' ORDER BY '+orderBy+' '+sortOrder+' LIMIT '+pageSize+' OFFSET '+offset;
        sQuery = sQuery + whereGeneral;
        propiedades = Database.query(sQuery);
        propiedades2= propiedades;
      }
      
      getUrlImage();
      //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, sQuery));
    }catch(Exception e){
      System.debug('ERROR ' + e.getMessage());
      //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'sQuery:' + sQuery + ',' +e.getMessage() ));
    }
  }
  
  public void first() {
    pageNumber = 1;
    searchPropiedades();
  }
  
  public void previous() {
    if(pageNumber > 1) {
      pageNumber--;
      searchPropiedades();
    }
  }
  
  public void next() {
    if(pageNumber < totalPages) {
      pageNumber++;
      searchPropiedades();
    }
  }
  
  public void last() {
    pageNumber = totalPages;
    searchPropiedades();
  }
  
  /*busqueda de las propiedades visibles en el mapa*/
  public pageReference searchVista() {
    propiedades = new list<Propiedad__c>();
    set<String> ids = new set<String>();
    ids.addAll(idsPropiedades.split(','));
    propiedades = [SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,
               ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, 
               FechaPublicacionWeb__c, Construccion_m2__c FROM Propiedad__c WHERE id IN :(ids) limit 5000];
      getUrlImage(); 
    return null;
  }
  
  public void getUrlImage(){
    set<Id> idPropiedades = new set<Id>();
    set<Id>parent = new set<Id>();
    string prefixUrl = '/servlet/servlet.FileDownload?file=';
    
    for(Propiedad__c propiedad:propiedades){
      idPropiedades.add(propiedad.Id);
   mapImagenesMini.put(propiedad.Id,Utils.getResourceURL('noImage'));
    }
    //list<Oferta__c> ofertas = [SELECT id,Name,Propiedad__c,(SELECT id,Name,Oferta__c,Tipo__c FROM Documentos__r WHERE Tipo__c = 'Fotografia') FROM Oferta__c WHERE Propiedad__c IN : idPropiedades];
    list<FotoWeb__c> fotosWeb = [SELECT id,Name,Propiedad__c FROM FotoWeb__c WHERE Propiedad__c IN : idPropiedades AND EstatusFoto__c = 'Publicada' limit 5000];
    for(FotoWeb__c foto:fotosWeb){
        parent.add(foto.id);
    }
    
    List<Attachment> attachedFiles = [select Id,parentId from Attachment where parentId IN: idPropiedades  limit 1];
   // for(FotoWeb__c foto:fotosWeb){
        for(Attachment  att: attachedFiles){
          //if(foto.id == att.parentId){
              if(mapImagenesMini.containsKey(att.parentId)){
              	system.debug('HOla1');
               mapImagenesMini.put(att.parentId,prefixUrl+att.Id);
              }
              system.debug(mapImagenesMini);
          //}
      //  }
    }
  }
  
  @RemoteAction
  public static Propiedad getPropiedades(String plaza,String tipo,String estado,String ciudad,String priceFrom,
                      String priceTo,String m2From,String m2To,String centroPropiedad, String estatusVenta){
    list<Propiedad__c> listaPropieades = new list<Propiedad__c>();
    String sQuery = '';
    String whereArgs = '';
    String wherePrice = '';
    String whereM2 = '';
    String whereVenta= '';
    Integer totalPages = 0;
    Integer pageStart = 0;
    Integer pageEnd = 0;
    Integer estadoStatus = 0;
    Integer ciudadStatus = 0;
    Integer tipoStatus = 0;
    //RJP-> se retira campo Control__c
    whereArgs = 'EstatusWeb__c = \'Publicada\' AND Punto__Latitude__s != null ';

    if(!estado.equals('')){
      whereArgs+= 'AND Estado__c LIKE \'%'+ estado + '%\' ';
      estadoStatus = 1;
      //whereArgs+= 'AND Estado3__c = \''+ estado + '\' ';
    }
    if(!plaza.equals('')){
      whereArgs+= 'AND Plaza__c LIKE \'%' + plaza + '%\' ';
    }
    if(!ciudad.equals('')){
      whereArgs+= 'AND Municipio__c LIKE \'%'+  ciudad +'%\' ';
      ciudadStatus = 1;
    }
    if(!tipo.equals('')){
      whereArgs+= 'AND Tipo__c LIKE \'%' + tipo +'%\' ';
      tipoStatus = 1;
    }
    
    if(priceFrom  != null && priceTo != null && !priceFrom.equals('')  && !priceTo.equals('')){
      wherePrice = ' AND (ValorReferencia__c >= ' + priceFrom + ' AND ValorReferencia__c <= ' + priceTo.replace(',', '') + ')';
    }else if(priceFrom  != null  && !priceFrom.equals('')){
      wherePrice =  ' AND (ValorReferencia__c >= ' + priceFrom + ')';
    }else if(priceTo != null && !priceTo.equals('')){
      wherePrice = ' AND (ValorReferencia__c <= ' + priceTo + ')';
    }
    
    if(m2From  != null && m2To != null && !m2From.equals('')  && !m2To.equals('')){
      whereM2 = ' AND (Terreno_m2__c >= ' + m2From + ' AND Terreno_m2__c <= ' +m2To.replace(',', '') + ')';
    }else if(m2From  != null  && !m2From.equals('')){
      whereM2 =  ' AND (Terreno_m2__c >= ' + m2From + ')';
    }else if(m2To != null && !m2To.equals('')){
      whereM2 = ' AND (Terreno_m2__c <= ' + m2To + ')';
    }
    
    if(estatusVenta != null){
      list<String> estatusArray = estatusVenta.split(',');
      String estatusfinal = '';
      for(String estatus:estatusArray){
        estatusfinal =  '\'' + estatus + '\',' + estatusfinal;
      }
      estatusfinal = estatusfinal.length() > 1  ? estatusfinal.substring(0,estatusfinal.length() -1) : '';
      whereVenta =  ' AND EstatusVenta2__c NOT IN (\'Descartada\',' + estatusfinal +',\'\') ';
    }
    
    whereArgs = whereArgs + wherePrice + whereM2 + whereVenta; 
    System.debug('## getPropiedades : '+whereArgs);
    try {
      String lmt = tipoStatus==1 && estadoStatus==1 && ciudadStatus==1 ? '': ' LIMIT 5000';
      
      sQuery = 'SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c,' +
               'ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c, ' +
               'FechaPublicacionWeb__c, Construccion_m2__c, EstatusVenta2__c, FolioWeb__c, Estacionamiento__c, N_de_Ba_os__c, N_de_Habitaciones__c, Patios__c, Niveles_Plantas__c '+
           'FROM Propiedad__c ' + 
           'WHERE '+ whereArgs + lmt;
      if(!centroPropiedad.equals('')){
        Double lat = Double.valueOf(centroPropiedad.split(',')[0]);
        Double lng =  Double.valueOf(centroPropiedad.split(',')[1]);
        for(Propiedad__c prop : Database.query(sQuery)){
          Decimal dist = PropiedadDetalleController.distanciaDos (lat,lng,prop.Punto__Latitude__s,prop.Punto__Longitude__s) * 1000;
          if(dist < = 500){
          	prop.N_de_Ba_os__c= prop.N_de_Ba_os__c.subString(0,3);
        	system.debug('prop.N_de_Ba_os__c'+prop.N_de_Ba_os__c);
          	prop.N_de_Habitaciones__c= prop.N_de_Habitaciones__c.subString(0,3);
         	system.debug('prop.N_de_Habitaciones__c'+prop.N_de_Habitaciones__c);
              listaPropieades.add(prop);
            }
        }
      }else{
        listaPropieades = Database.query(sQuery);
      }
      system.debug('MAPA '+ sQuery);
    }catch(Exception e){
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
    }
    return new Propiedad(listaPropieades);
  }

  public void setTotalPages(Integer total)
  {
    this.totalPages = total;
  }
  
  
}