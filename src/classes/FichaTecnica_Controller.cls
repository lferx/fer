public with sharing class FichaTecnica_Controller {


  public Oferta__c objetoOferta {get;set;}
  public Desalojo__c objetoDesalojo {get;set;}
  
  //public String vacio {get;set;}
  public String s {get;set;}
  public String c {get;set;}
  //public Double venta {get;set;}
  //public Double refer {get; set;}
  //public Double resul {get;set;}
  
  //public Double precioVenta {get; set;}
  //public Double precioReferencia {get; set;}
  public Double precioContado {get; set;}
  public String direccionCompleta {get;set;}
  //public String vtipodecalle {get; set;}
  //public String vcalle {get; set;}
  //public String vnumeroexterior {get; set;}
  //public String vnumerointerior {get; set;}
  //public String vlote {get; set;}
  //public String vmz {get; set;}
  //public String vcp {get; set;}
  //public String vtipodecolonia {get; set;}
  //public String vcolonia {get; set;}
  //public String vmunicipio {get; set;}
  //public String vestado {get; set;}


  public String promodias {get; set;}
  public String promodesalojadas {get; set;}
  public boolean sizelist {get; set;}

  public Double ppm2c  {get; set;}
  public Double pcolonia  {get; set;}
  public Double ahorro  {get; set;}

  public List<SelectOption> ExtraList {get; set;}
  public List<Google_JSONWebToken.Archivo> fotos {get; set;}
  public List<Google_JSONWebToken.Archivo> archivos {get; set;}
  public Google_JSONWebToken.Archivo objfoto;
  
  public String[] arrayPros {get;set;}
  public String[] arrayCons {get;set;}

  boolean fotop = false;
  public integer fotosSize {get;set;}
  //desalojo 
  //SELECT Oferta__c,Estatus_del_Desalojo__c,Estatus__c,EtapaDemanda__c,EtapaDesalExtraJud__c,EtapaDesalojoJudicial__c,Etapa_Desalojo_Inbound__c,Etapa_Proceso__c,Etapa__c,Id,Name FROM Desalojo__c WHERE Oferta__c = 'a083100001O57i7AAB' ORDER BY CreatedDate DESC NULLS FIRST LIMIT 1
  public FichaTecnica_Controller(){
    iniciaConVariablesLimpias();

    s=System.currentPageReference().getParameters().get('id');

    if(String.isNotEmpty(s)){
      obtenerFicha(s);
    }else{
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Se esperaba un parametro: debe hacer referencia a una oferta.'));
    }

  }
  public void obtenerFicha(String idOferta){
    c=idOferta.trim();
    objetoOferta = new Oferta__c();
    objetoOferta = QueryObjetoOferta(c);
    try{
      objetoDesalojo = queryDesalojo(c);
    }catch(exception e){
      objetoDesalojo = new Desalojo__c();
    }
    //objetoDesalojo = queryDesalojo(c);
    if(String.isNotBlank( objetoOferta.Ventajas__c)){
      arrayPros = objetoOferta.Ventajas__c.split(';');
    }
    if(String.isNotBlank(objetoOferta.Desventajas__c)){
      arrayCons = objetoOferta.Desventajas__c.split(';');
    }
    

    if(objetoOferta.ValorReferencia__c != null && objetoOferta.ValorReferencia__c > 0){
      precioContado = objetoOferta.ValorReferencia__c * .8;
    }

    if(objetoOferta.Colonia_busqueda__r.Precio_por_m2_construccion_mercado__c != null && objetoOferta.Colonia_busqueda__r.Precio_por_m2_construccion_mercado__c > 0){
      ppm2c = objetoOferta.Colonia_busqueda__r.Precio_por_m2_construccion_mercado__c;
      if(objetoOferta.Propiedad__r.Construccion_m2__c != null && objetoOferta.Propiedad__r.Construccion_m2__c > 0){
        pcolonia = ppm2c * objetoOferta.Propiedad__r.Construccion_m2__c;
        if(objetoOferta.ValorReferencia__c != null && objetoOferta.ValorReferencia__c > 0){
          ahorro=((ppm2c - (objetoOferta.ValorReferencia__c / objetoOferta.Propiedad__r.Construccion_m2__c)) / ppm2c) * 100;
        }
      }
    }
    try{
      if(objetoOferta.Propiedad__r.Collection_Id__c != null && objetoOferta.Propiedad__r.Collection_Id__c != ''){
        Google_JSONWebToken cls = new Google_JSONWebToken();
        
        cls.init();
        archivos = cls.obtenerUrls(objetoOferta.Propiedad__r.Collection_Id__c);
        System.debug(' ** ARCHIVOS ENCONTRADOS: ** '+archivos.size()+' ** ARCHIVOS: **'+archivos);
        if(archivos.size()>0){
          fotos = new List<Google_JSONWebToken.Archivo>();
          for(Google_JSONWebToken.Archivo x : archivos){
            if(x.name.contains('.jpg') || x.name.contains('.jpeg')|| x.name.contains('.png') || x.name.contains('.gif')|| x.name.contains('.bmp') ){
            fotos.add(x);
            }
          }
        }
      
        if(fotos != null){
          system.debug(' ** FOTOS ENCONTRADAS: **' + fotos.size() + ' ** FOTOS ** ' + fotos);
          integer count=0;
        
          fotosSize = fotos.size();
          for(Google_JSONWebToken.Archivo x : fotos){
            if(x.name.contains('foto_principal')){
              system.debug('FOTO PRINCIPAL: Nombre: ' + x.name + ' Url: ' + x.url);
              fotop = true;
              break;
            }
            count++;
          }
          if(fotop){
            objfoto = fotos.get(count);
            fotos.set(count,fotos.get(0));
            fotos.set(0,objfoto);
            system.debug('lista de fotos ordenada: '+fotos);
          }
        }
        else{
          sinFoto();
        }
      }else{
        sinFoto();
      }
    }catch(exception e){
      System.debug('Este error proviene del servidor de google');
      System.debug('Hubo un erro fatal con el servidor de google y no se pudo obtener la imagen: '+e);
      sinFoto();
    }
    

    direccionCompleta='';
    if(!String.isBlank(objetoOferta.Propiedad__r.Tipo_de_calle__c))
      //vtipodecalle
      direccionCompleta+=objetoOferta.Propiedad__r.Tipo_de_calle__c +', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.Calle__c))
      //vcalle
      direccionCompleta += objetoOferta.Propiedad__r.Calle__c +', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.NumeroExterior__c))
      //vnumeroexterior
      direccionCompleta +='EXT. '+objetoOferta.Propiedad__r.NumeroExterior__c+', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.NumeroInterior__c))
      //vnumerointerior
      direccionCompleta +='INT. '+objetoOferta.Propiedad__r.NumeroInterior__c+', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.Lote__c))
      //vlote
      direccionCompleta+='LOTE. '+objetoOferta.Propiedad__r.Lote__c + ', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.Manzana__c))
      //vmz
      direccionCompleta+='MZ. '+objetoOferta.Propiedad__r.Manzana__c + ', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.CP__c))
      //vcp
      direccionCompleta+='CP. '+objetoOferta.Propiedad__r.CP__c + ', ';
    if(!String.isBlank(objetoOferta.Propiedad__r.Tipo_de_colonia__c))
      //vtipodecolonia
      direccionCompleta+=objetoOferta.Propiedad__r.Tipo_de_colonia__c + ', ';
    /*if(objetoOferta.Propiedad__r.Colonia__c != '' && objetoOferta.Propiedad__r.Colonia__c != null)
      vcolonia=objetoOferta.Propiedad__r.Colonia__c + ', ';
    if(objetoOferta.Propiedad__r.Municipio__c != '' && objetoOferta.Propiedad__r.Municipio__c != null)
      vmunicipio=objetoOferta.Propiedad__r.Municipio__c + ', ';
    if(objetoOferta.Propiedad__r.Estado__c != '' && objetoOferta.Propiedad__r.Estado__c != null)
      vestado=objetoOferta.Propiedad__r.Estado__c;*/

    /* Empieza promo para dias en stock */
    if((objetoOferta.Campa__r.Dias_en_stock_max__c != null && objetoOferta.Campa__r.Dias_en_stock_max__c > 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c != null && objetoOferta.Campa__r.Dias_en_stock_min__c > 0)){
      if(objetoOferta.TiempoOferta__c < objetoOferta.Campa__r.Dias_en_stock_max__c && objetoOferta.TiempoOferta__c > objetoOferta.Campa__r.Dias_en_stock_min__c){
        promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
      }
    }
    else if((objetoOferta.Campa__r.Dias_en_stock_max__c == null || objetoOferta.Campa__r.Dias_en_stock_max__c == 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c != null && objetoOferta.Campa__r.Dias_en_stock_min__c > 0)){
      if(objetoOferta.TiempoOferta__c > objetoOferta.Campa__r.Dias_en_stock_min__c){
        promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
      }
    }
    else if((objetoOferta.Campa__r.Dias_en_stock_max__c != null && objetoOferta.Campa__r.Dias_en_stock_max__c > 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c == null || objetoOferta.Campa__r.Dias_en_stock_min__c == 0)){
      if(objetoOferta.TiempoOferta__c < objetoOferta.Campa__r.Dias_en_stock_max__c){
        promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
      }
    }
    /* Termina promo para dias en stock */
    

    /* pormo par adesalojadas*/
    if(objetoOferta.Estatus_de_invasion__c == 'Desalojada' || objetoOferta.Estatus_de_invasion__c == 'Asegurada'){
      promodesalojadas = objetoOferta.campa__r.Promocion_desalojadas__c;
    }
    getExtraList();
  }

  public void sinFoto(){
    fotos = new List<Google_JSONWebToken.Archivo>();
    objfoto = new Google_JSONWebToken.Archivo('FotoNoDisponible2','/resource/1494290307000/imagen_no_encontrada');
    fotos.add(objfoto);
    system.debug('carpeta no disponible: '+fotos);
    fotosSize = 1;
    fotop=false;
  }

  public List<SelectOption> getExtraList(){
    ExtraList = new List<SelectOption>();
    ExtraList.add(new SelectOption('seleccion','-Disponible-'));
    sizelist=false;
    
    if(objetoOferta.Campa__r.Devoluci_n__c != null && objetoOferta.Campa__r.Devoluci_n__c != ''){
      ExtraList.add(new SelectOption('devolucion',(String) objetoOferta.Campa__r.Devoluci_n__c));
      sizelist =true;
    }
    if(String.isNotBlank(objetoOferta.Campa__r.Extras__c)){
      for(String key : objetoOferta.Campa__r.Extras__c.split(';')){
        ExtraList.add(new SelectOption(key,key));
        sizelist=true;
      }
    }
    return ExtraList;

  }

  public Oferta__c QueryObjetoOferta(id idOferta){
    return [SELECT
    //imagen-----------------------------------------------------------------------------------
    Propiedad__r.Collection_Id__c,

    //Detalles de la propiedad-----------------------------------------------------------------
    Name,
    //Direccion2__c,
    Propiedad__r.Tipo_de_calle__c, 
    Propiedad__r.Calle__c,
    Propiedad__r.NumeroExterior__c,
    Propiedad__r.NumeroInterior__c,
    Propiedad__r.Lote__c,
    Propiedad__r.Manzana__c,
    Propiedad__r.CP__c,
    Propiedad__r.Tipo_de_colonia__c,

    Propiedad__r.Colonia__c,
    Propiedad__r.Municipio__c,
    Propiedad__r.Estado__c,

    Estado__c,
    Ciudad_tabla__c,
    Colonia_busqueda__c,

    //tecnica propiedad-----------------------------------------------------------------------
    Propiedad__r.Construccion_m2__c,
    Propiedad__r.Terreno_m2__c,
    Propiedad__r.N_de_Habitaciones__c,
    Propiedad__r.N_de_Ba_os__c,
    Propiedad__r.Patios__c,
    Propiedad__r.Estacionamiento__c,

    //RESUMEN FINANCIERO-----------------------------------------------------------------------
    Valor_Aval_o_Infonavit__c,
    ValorReferencia__c,
    Precio_Original__c,
    Escritu__c,
    Estatus_de_invasion__c,
    //otros
    MargenNeto__c,
    PrecioVenta__c,

    //PROMOSION----------------------------------------------------------------
    TiempoOferta__c,
    Campa__r.Dias_en_stock_max__c,
    Campa__r.Dias_en_stock_min__c,
    Campa__r.Promocion_dias_en_stock__c,
      
    campa__r.Promocion_desalojadas__c,

    Campa__r.Comisi_n__c,
    Campa__r.Devoluci_n__c,
    Campa__r.Extras__c,

    //ARGUMENTOS COMERCIALES-------------------------------------------------------------------
    Propiedad__r.Punto__Latitude__s,
    Propiedad__r.Punto__Longitude__s,
    Propiedad__r.referencias_links__c,
    //Colonia_busqueda__r.Precio_medio_competencia__c,
    Colonia_busqueda__r.Precio_medio_de_mercado__c,
    Colonia_busqueda__r.Precio_por_m2_construccion_mercado__c,

    Colonia_busqueda__r.Calificacion_centros_comerciales__c,
    Colonia_busqueda__r.Calificacion_super__c,
    Colonia_busqueda__r.Calificacion_escuelas__c,
    Colonia_busqueda__r.Calificacion_parques__c,
    Colonia_busqueda__r.Calificacion_hospitales__c,
    Colonia_busqueda__r.Calificacion_restaurantes__c,
    Colonia_busqueda__r.Total_Calificacion__c,



    Desalojo__r.EtapaDesalojoJudicial__c, //este valor es d las etapas de desalojo
    Colonia_busqueda__r.Vendidas__c, //este valor arroja las propiedades vendidas
    Colonia_busqueda__r.Propiedades_Disponibles__c, //
    Propiedad__r.Argumentos_comerciales__c,
    Ventajas__c,
    Desventajas__c

    FROM Oferta__c where Id =:idOferta];
  }

  public Desalojo__c queryDesalojo(String idOferta){
    for(Desalojo__c x : [SELECT Oferta__c,Corte_de_Suministros__c,Estatus_del_Desalojo__c,Estatus__c,EtapaDemanda__c,EtapaDesalExtraJud__c,EtapaDesalojoJudicial__c,Etapa_Desalojo_Inbound__c,Etapa_Proceso__c,Etapa__c,Id,Name FROM Desalojo__c WHERE Oferta__c = :idOferta ORDER BY CreatedDate DESC NULLS LAST LIMIT 1]){
      return  x;
    }
    return null;
  }

  public void iniciaConVariablesLimpias(){
    direccionCompleta='';
    fotosSize = 0;
    precioContado = 0;
    ppm2c = 0;
    pcolonia =0;
    ahorro = 0;
    promodesalojadas='N/A';
    promodias='N/A';
  }

  /*public PageReference irANegociacion(){
    PageReference pag = Page.autorizacion;
    pag.getParameters().put('id', c);
    return pag;
  }
  */

}