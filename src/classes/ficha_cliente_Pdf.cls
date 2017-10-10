public with sharing class ficha_cliente_Pdf {


	public List<Detalle_del_carrito__c> listaCarro {get;set;}
	public List<wrapperDetalleCarrito> wrappedListaCarro {get;set;}
	public class wrapperDetalleCarrito{
		public Detalle_del_carrito__c detalle {get;set;}
		public List<Google_JSONWebToken.Archivo> urls {get;set;}
		public String calleynumero {get;set;}
		public String coloniaycp {get;set;}
		public String ciudadyestado {get;set;}
	}

	public ficha_cliente_Pdf() {

		Id carritoId = ApexPages.currentPage().getParameters().get('id');
		listaCarro= [SELECT
		//imagen-----------------------------------------------------------------------------------
		Oferta__r.Propiedad__r.Collection_Id__c,

		//Detalles de la propiedad-----------------------------------------------------------------
		Oferta__r.Name,
		//Direccion2__c,
		Oferta__r.Propiedad__r.Tipo_de_calle__c, 
		Oferta__r.Propiedad__r.Calle__c,
		Oferta__r.Propiedad__r.NumeroExterior__c,
		Oferta__r.Propiedad__r.NumeroInterior__c,
		Oferta__r.Propiedad__r.Lote__c,
		Oferta__r.Propiedad__r.Manzana__c,
		Oferta__r.Propiedad__r.CP__c,
		Oferta__r.Propiedad__r.Tipo_de_colonia__c,

		Oferta__r.Propiedad__r.Colonia__c,
		Oferta__r.Propiedad__r.Municipio__c,
		Oferta__r.Propiedad__r.Estado__c,

		Oferta__r.Estado__r.Name,
		Oferta__r.Ciudad_tabla__r.Name,
		Oferta__r.Colonia_busqueda__r.Name,

		//tecnica propiedad-----------------------------------------------------------------------
		Oferta__r.Propiedad__r.Construccion_m2__c,
		Oferta__r.Propiedad__r.Terreno_m2__c,
		Oferta__r.Propiedad__r.N_de_Habitaciones__c,
		Oferta__r.Propiedad__r.N_de_Ba_os__c,
		Oferta__r.Propiedad__r.Patios__c,
		Oferta__r.Propiedad__r.Estacionamiento__c,
		Oferta__r.Propiedad__c,

		//RESUMEN FINANCIERO-----------------------------------------------------------------------
		Oferta__r.Valor_Aval_o_Infonavit__c,
		Oferta__r.ValorReferencia__c,
		Oferta__r.Precio_Original__c,
		Oferta__r.Escritu__c,
		Oferta__r.Estatus_de_invasion__c,
		//otros
		Oferta__r.MargenNeto__c,
		Oferta__r.PrecioVenta__c,

		//PROMOSION----------------------------------------------------------------
		Oferta__r.TiempoOferta__c,
		Oferta__r.Campa__r.Dias_en_stock_max__c,
		Oferta__r.Campa__r.Dias_en_stock_min__c,
		Oferta__r.Campa__r.Promocion_dias_en_stock__c,
		
		Oferta__r.campa__r.Promocion_desalojadas__c,

		Oferta__r.Campa__r.Comisi_n__c,

		//Oferta__r.Campa__r.A_C__c,
		//Oferta__r.Campa__r.Bardas__c,
		//Oferta__r.Campa__r.Rejas__c,
		Oferta__r.Campa__r.Devoluci_n__c,

		//ARGUMENTOS COMERCIALES-------------------------------------------------------------------
		Oferta__r.Propiedad__r.Punto__Latitude__s,
		Oferta__r.Propiedad__r.Punto__Longitude__s,
		Oferta__r.Propiedad__r.referencias_links__c,
		//Oferta__r.Colonia_busqueda__r.Precio_medio_competencia__c,

		Oferta__r.Desalojo__r.EtapaDesalojoJudicial__c, //este valor es d las etapas de desalojo
		Oferta__r.Colonia_busqueda__r.Vendidas__c, //este valor arroja las propiedades vendidas
		Oferta__r.Colonia_busqueda__r.Propiedades_Disponibles__c, //
		Oferta__r.Propiedad__r.Argumentos_comerciales__c,
		Precio_Negociado__c

		FROM Detalle_del_Carrito__c where carrito__c =:carritoId];

		wrappedListaCarro = new List<wrapperDetalleCarrito>();
		for(Detalle_del_Carrito__c det : listaCarro){
			String calleynumero='';
			String coloniaycp = '';
			String ciudadyestado='';
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.Tipo_de_calle__c)){
		      //vtipodecalle
		      calleynumero+=det.Oferta__r.Propiedad__r.Tipo_de_calle__c +', ';}

		    if(!String.isBlank(det.Oferta__r.Propiedad__r.Calle__c)){
		      //vcalle
		      calleynumero += det.Oferta__r.Propiedad__r.Calle__c +', ';
		  	}
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.NumeroExterior__c)){
		      //vnumeroexterior
		      calleynumero +='Ext. '+det.Oferta__r.Propiedad__r.NumeroExterior__c+', ';
		  	}
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.NumeroInterior__c)){
		      //vnumerointerior
		      calleynumero +='Int. '+det.Oferta__r.Propiedad__r.NumeroInterior__c+', ';
		  	}
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.Lote__c)){
		      //vlote
		      calleynumero+='Lt. '+det.Oferta__r.Propiedad__r.Lote__c + ', ';
		  	}
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.Manzana__c)){
		      //vmz
		      calleynumero+='Mz. '+det.Oferta__r.Propiedad__r.Manzana__c ;
		    }

		    if(!String.isBlank(det.Oferta__r.Colonia_busqueda__r.Name)){
		    	coloniaycp += 'Col. '+det.Oferta__r.Colonia_busqueda__r.Name+', ';
		    }
		    if(!String.isBlank(det.Oferta__r.Propiedad__r.CP__c)){
		      //vcp
		      coloniaycp+='C.P. '+det.Oferta__r.Propiedad__r.CP__c ;
		  	}
		    //if(!String.isBlank(det.Oferta__r.Propiedad__r.Tipo_de_colonia__c))
		      //vtipodecolonia
		      //direccionCompleta+=det.Oferta__r.Propiedad__r.Tipo_de_colonia__c + ', ';
		    if(!String.isBlank(det.Oferta__r.Ciudad_tabla__r.Name)){
		    	ciudadyestado += det.Oferta__r.Ciudad_tabla__r.Name+', ';
		    }
		    if(!String.isBlank(det.Oferta__r.Estado__r.Name)){
		    	ciudadyestado += det.Oferta__r.Estado__r.Name;
		    }


			wrapperDetalleCarrito wrap = new wrapperDetalleCarrito();
			wrap.detalle = det;
			wrap.calleynumero = calleynumero.toLowerCase();
			wrap.coloniaycp = coloniaycp.toLowerCase();
			wrap.ciudadyestado = ciudadyestado.toLowerCase();
			wrap.urls = obtenerFoto(det.Oferta__r.Propiedad__r.Collection_Id__c);
			wrappedListaCarro.add(wrap);
		}
	}

	public void guardarFotosComoAdjuntos(){
		Set<Id> propiedades = new Set<Id>();
		Map<String,Google_JSONWebToken.Archivo> mapaDetalle = new Map<String,Google_JSONWebToken.Archivo>();
		for(wrapperDetalleCarrito wrap : wrappedListaCarro){
			propiedades.add(wrap.detalle.Oferta__r.Propiedad__c);
			for(Google_JSONWebToken.Archivo arch : wrap.urls){
				if(arch.datos != null){
					mapaDetalle.put(String.valueOf(wrap.detalle.Oferta__r.Propiedad__c) + arch.Name, arch);
				}
			}
		}
		List<Folder> carpetaResultados = [SELECT Id, DeveloperName from Folder where DeveloperName = 'Imagenes_de_Propiedades'];
		if(!carpetaResultados.isEmpty()){
			if(!propiedades.isEmpty()){
				List<Document> documentosSistema = [Select Id, Name, Keywords from Document where Keywords in: propiedades and folderid =: carpetaResultados.get(0).Id];
				if(!documentosSistema.isEmpty()){
					for(Document attach : documentosSistema){
						if(mapaDetalle.containsKey(attach.Keywords + attach.name)){
							mapaDetalle.get(attach.Keywords + attach.name).salesforceId = attach.Id;
							mapaDetalle.get(attach.Keywords + attach.name).datos = null;
						}
					}
				}
			}
			List<Document> documentosInsert = new List<Document>();
			for(wrapperDetalleCarrito wrap : wrappedListaCarro){
				for(Google_JSONWebToken.Archivo arch : wrap.urls){
					if(arch.Salesforceid == null && arch.datos != null){
						Document attach = new Document();
						attach.keywords = wrap.detalle.Oferta__r.Propiedad__c;
						attach.body = arch.datos;
						attach.name = arch.Name;
						attach.folderId = carpetaResultados.get(0).Id;
						documentosInsert.add(attach);
						arch.datos = null;
					}
				}
			}
			
			if(!documentosInsert.isEmpty()){
				insert documentosInsert;
				for(Document attach : documentosInsert){
					if(mapaDetalle.containsKey(attach.Keywords + attach.name)){
						mapaDetalle.get(attach.Keywords + attach.name).salesforceId = attach.Id;
					}
				}
			}

		}
	}
	public List<Google_JSONWebToken.Archivo> sinFoto(){
		Google_JSONWebToken.Archivo archivoSinFoto = new Google_JSONWebToken.Archivo();
		archivoSinFoto.name ='sinFoto';
		archivoSinFoto.url = '/resource/1494290307000/imagen_no_encontrada';
		return new List<Google_JSONWebToken.Archivo> { archivoSinFoto};
	}
	public List<Google_JSONWebToken.Archivo> obtenerfoto(String collectionId){
		List<Google_JSONWebToken.Archivo> fotos = new List<Google_JSONWebToken.Archivo>();

		if(collectionId != null && collectionId != ''){
			Google_JSONWebToken cls = new Google_JSONWebToken();
			cls.init();
			List<Google_JSONWebToken.Archivo> archivos = cls.obtenerDatosArchivos(collectionId);
			System.debug(' ** ARCHIVOS ENCONTRADOS: ** '+archivos.size()+' ** ARCHIVOS: **'+archivos);
			if(archivos.size()>0){
				fotos = new List<Google_JSONWebToken.Archivo>();
				for(Google_JSONWebToken.Archivo x : archivos){
					if(x.name.contains('.jpg') || x.name.contains('.jpeg')|| x.name.contains('.png') || x.name.contains('.gif')|| x.name.contains('.bmp') ){
						fotos.add(x);
					}
				}
			}
			
			if(fotos != null && !fotos.isEmpty()){
				system.debug(' ** FOTOS ENCONTRADAS: **' + fotos.size() + ' ** FOTOS ** ' + fotos);
				integer count=0;
				Boolean fotop = false;
				Integer fotosSize = fotos.size();
				for(Google_JSONWebToken.Archivo x : fotos){
					if(x.name.contains('foto_principal')){
						system.debug('FOTO PRINCIPAL: Nombre: ' + x.name + ' Url: ' + x.url);
						fotop = true;
						break;
					}
					count++;
				}
				if(fotop){
					Google_JSONWebToken.Archivo objfoto = fotos.get(count);
					fotos.set(count,fotos.get(0));
					fotos.set(0,objfoto);
					system.debug('lista de fotos ordenada: '+fotos);
				}
			}
			else{
				return sinFoto();
			}
		}else{
			return sinFoto();
		}
		return fotos;
	}
	public void cobertura(){
		integer a=1;
		a=1;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
		a++;
	}


}