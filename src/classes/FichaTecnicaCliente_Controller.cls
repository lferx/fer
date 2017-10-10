public with sharing class FichaTecnicaCliente_Controller{
	public FichaTecnicaCliente_Controller() {
		iniciaConVariablesLimpias();

        s=System.currentPageReference().getParameters().get('id');
        /*
        if (s==null){
            s='a08g0000008NAHr'; //a08g0000008NAHr
        }*/ 

        if(s != null && s != ''){
            obtenerInfoFicha(s);
        }else{
            objetoOferta = new Oferta__c();
            objetoOferta.name = 'ERROR: Se esperaba un parametro';
            //objetoOferta.Propiedad__r.Tipo_de_calle__c = 'En la url espera un id de oferta';
        }
	}
	
    
    public Oferta__c objetoOferta{get;set;}
    public String s {get;set;}
    public String c {get;set;}

    public Double precioContado {get; set;}

    public String direccionCompleta {get;set;}

    public String vtipodecalle {get; set;}
    public String vcalle {get; set;}
    public String vnumeroexterior {get; set;}
    public String vnumerointerior {get; set;}
    public String vlote {get; set;}
    public String vmz {get; set;}
    public String vcp {get; set;}
    public String vtipodecolonia {get; set;}
    public String vcolonia {get; set;}
    public String vmunicipio {get; set;}
    public String vestado {get; set;}

    public String promodias {get; set;}
    public String promodesalojadas {get; set;}
    public boolean sizelist {get; set;}

    public List<SelectOption> ExtraList {get; set;}
    //public String guardaopcion {get; set;}
    public List<Google_JSONWebToken.Archivo> fotos {get; set;}
    public List<Google_JSONWebToken.Archivo> archivos {get; set;}
    public Google_JSONWebToken.Archivo objfoto;
    boolean fotop = false;
    public integer fotosSize {get;set;}

    

    public void iniciaConVariablesLimpias(){
        vtipodecalle = '';
        vcalle = '';
        vnumeroexterior = '';
        vnumerointerior = '';
        vlote = '';
        vmz = '';
        vcp = '';
        vtipodecolonia = '';
        vcolonia = '';
        vmunicipio = '';
        vestado ='';
        fotosSize = 0;
        direccionCompleta = '';
    }

    public void obtenerInfoFicha(id idOferta){
        c=idOferta;
        objetoOferta = new Oferta__c();
        objetoOferta = QueryObjetoOferta(c);

        if(objetoOferta.ValorReferencia__c != null){
            precioContado = objetoOferta.ValorReferencia__c * .8;
        }else{
            precioContado = 0;
        }
        
        
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


        if(objetoOferta.Propiedad__r.Tipo_de_calle__c != '' && objetoOferta.Propiedad__r.Tipo_de_calle__c != null){
            direccionCompleta += objetoOferta.Propiedad__r.Tipo_de_calle__c +', ';
            //vtipodecalle=objetoOferta.Propiedad__r.Tipo_de_calle__c +', ';
        }
        if(objetoOferta.Propiedad__r.Calle__c != '' && objetoOferta.Propiedad__r.Calle__c != null){
            direccionCompleta += objetoOferta.Propiedad__r.Calle__c +', ';
            //vcalle = objetoOferta.Propiedad__r.Calle__c +', ';
        }
        if(objetoOferta.Propiedad__r.NumeroExterior__c != '' && objetoOferta.Propiedad__r.NumeroExterior__c != null){
            direccionCompleta += 'EXT. '+objetoOferta.Propiedad__r.NumeroExterior__c+', ';
            //vnumeroexterior='EXT. '+objetoOferta.Propiedad__r.NumeroExterior__c+', ';
        }
        if(objetoOferta.Propiedad__r.NumeroInterior__c != '' && objetoOferta.Propiedad__r.NumeroInterior__c != null){
            direccionCompleta +='INT. '+objetoOferta.Propiedad__r.NumeroInterior__c+', ';
            //vnumerointerior='INT. '+objetoOferta.Propiedad__r.NumeroInterior__c+', ';
        }
        if(objetoOferta.Propiedad__r.Lote__c != '' && objetoOferta.Propiedad__r.Lote__c != null){
            direccionCompleta +='LT. '+objetoOferta.Propiedad__r.Lote__c + ', ';
            //vlote='LT. '+objetoOferta.Propiedad__r.Lote__c + ', ';
        }
        if(objetoOferta.Propiedad__r.Manzana__c != '' && objetoOferta.Propiedad__r.Manzana__c != null){
            direccionCompleta +='MZ. '+objetoOferta.Propiedad__r.Manzana__c + ', ';
            //vmz='MZ. '+objetoOferta.Propiedad__r.Manzana__c + ', ';
        }
        if(objetoOferta.Propiedad__r.CP__c != '' && objetoOferta.Propiedad__r.CP__c != null){
            direccionCompleta +='CP. '+objetoOferta.Propiedad__r.CP__c + ', ';
            //vcp='CP. '+objetoOferta.Propiedad__r.CP__c + ', ';
        }
        if(objetoOferta.Propiedad__r.Tipo_de_colonia__c != '' && objetoOferta.Propiedad__r.Tipo_de_colonia__c != null){
            direccionCompleta+=objetoOferta.Propiedad__r.Tipo_de_colonia__c + ', ';
            //vtipodecolonia=objetoOferta.Propiedad__r.Tipo_de_colonia__c + ', ';
        }
        /*if(objetoOferta.Propiedad__r.Colonia__c != '' && objetoOferta.Propiedad__r.Colonia__c != null){
            direccionCompleta+=objetoOferta.Propiedad__r.Colonia__c + ', ';
            //vcolonia=objetoOferta.Propiedad__r.Colonia__c + ', ';
        }
        if(objetoOferta.Propiedad__r.Municipio__c != '' && objetoOferta.Propiedad__r.Municipio__c != null){
            direccionCompleta+=objetoOferta.Propiedad__r.Municipio__c + ', ';
            //vmunicipio=objetoOferta.Propiedad__r.Municipio__c + ', ';
        }
        if(objetoOferta.Propiedad__r.Estado__c != '' && objetoOferta.Propiedad__r.Estado__c != null){
            direccionCompleta+=objetoOferta.Propiedad__r.Estado__c;
            //vestado=objetoOferta.Propiedad__r.Estado__c;
        }*/


        /* Empieza promo para dias en stock */
        if((objetoOferta.Campa__r.Dias_en_stock_max__c != null && objetoOferta.Campa__r.Dias_en_stock_max__c > 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c != null && objetoOferta.Campa__r.Dias_en_stock_min__c > 0)){
            if(objetoOferta.TiempoOferta__c < objetoOferta.Campa__r.Dias_en_stock_max__c && objetoOferta.TiempoOferta__c > objetoOferta.Campa__r.Dias_en_stock_min__c){
                promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
            }
            else{
                promodias='N/A';
            }
        }
        else if((objetoOferta.Campa__r.Dias_en_stock_max__c == null || objetoOferta.Campa__r.Dias_en_stock_max__c == 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c != null && objetoOferta.Campa__r.Dias_en_stock_min__c > 0)){
            if(objetoOferta.TiempoOferta__c > objetoOferta.Campa__r.Dias_en_stock_min__c){
                promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
            }
            else{
                promodias='N/A';
            }
        }
        else if((objetoOferta.Campa__r.Dias_en_stock_max__c != null && objetoOferta.Campa__r.Dias_en_stock_max__c > 0) && (objetoOferta.Campa__r.Dias_en_stock_min__c == null || objetoOferta.Campa__r.Dias_en_stock_min__c == 0)){
            if(objetoOferta.TiempoOferta__c < objetoOferta.Campa__r.Dias_en_stock_max__c){
                promodias=objetoOferta.Campa__r.Promocion_dias_en_stock__c;
            }
            else{
                promodias='N/A';
            }
        }
        /* Termina promo para dias en stock */
            

        /* pormo par adesalojadas*/
        if(objetoOferta.Estatus_de_invasion__c == 'Desalojada' || objetoOferta.Estatus_de_invasion__c == 'Asegurada'){
            promodesalojadas = objetoOferta.campa__r.Promocion_desalojadas__c;
        }
        else{
            promodesalojadas='N/A';
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
        ExtraList.add(new SelectOption('seleccion','-- Disponibles --'));
        sizelist=false;

        
        //if(objetoOferta.Campa__r.Devoluci_n__c != null && objetoOferta.Campa__r.Devoluci_n__c != ''){
        //    ExtraList.add(new SelectOption('devolucion',(String) objetoOferta.Campa__r.Devoluci_n__c));
        //    sizelist =true;
        //}
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

            //ARGUMENTOS COMERCIALES-------------------------------------------------------------------
            Propiedad__r.Punto__Latitude__s,
            Propiedad__r.Punto__Longitude__s,
            Propiedad__r.referencias_links__c,
            //Colonia_busqueda__r.Precio_medio_competencia__c,
            Colonia_busqueda__r.Precio_medio_de_mercado__c,

            Desalojo__r.EtapaDesalojoJudicial__c, //este valor es d las etapas de desalojo
            Colonia_busqueda__r.Vendidas__c, //este valor arroja las propiedades vendidas
            Colonia_busqueda__r.Propiedades_Disponibles__c, //
            Propiedad__r.Argumentos_comerciales__c

            FROM Oferta__c where Id =:idOferta];
    }
    
}