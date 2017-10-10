public without sharing class PropiedadDetalleController {
    public String idPropiedad{get;set;}
    public Propiedad__c propiedad22 {get;set;}
    public list<String> urlImages {get;set;}
    public Decimal distanciaCoordenada{ get{ return 0.005;} set;}
    
    public list<Propiedad__c> propiedades {get;set;}
    public list<PropiedadWrapper> propiedadesWrapper {get;set;}
    
    public map<Id,String> mapImagenesMini {get;set;}
    
    public PropiedadDetalleController(){
        idPropiedad = (String)ApexPages.CurrentPage().getParameters().get('propiedad');
        propiedades = new list<Propiedad__c>();
        propiedadesWrapper = new list<PropiedadWrapper>();
        mapImagenesMini =  new map<Id,String>();
        if(idPropiedad != null){
            propiedad22 = [SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c, 
                             ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c,Construccion_m2__c ,
                             FechaPublicacionWeb__c, EstatusVenta2__c, FolioWeb__c, Views__c,Estacionamiento__c,N_de_Ba_os__c,N_de_Habitaciones__c,Patios__c,Niveles_Plantas__c
                         FROM Propiedad__c 
                         WHERE id =: idPropiedad];
                 
        }
    }

    public void addView()
    {
        idPropiedad = (String)ApexPages.CurrentPage().getParameters().get('propiedad');
        if(idPropiedad != null){
            propiedad22 = [SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c, 
                             ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c,Construccion_m2__c ,
                             FechaPublicacionWeb__c, EstatusVenta2__c, FolioWeb__c, Views__c, Estacionamiento__c, N_de_Ba_os__c, N_de_Habitaciones__c, Patios__c, Niveles_Plantas__c
                         FROM Propiedad__c 
                         WHERE id =: idPropiedad];
            try {
                propiedad22.Views__c = propiedad22.Views__c + 1;
            } catch (Exception e) {

            }
            update propiedad22;
        
        }
    }
    
    public list<String> getImages(){
        list<String> urls = new list<String>();
        set<Id>parent = new set<Id>();
        string prefixUrl = '/servlet/servlet.FileDownload?file=';
        
        List<Attachment> attachedFiles = [SELECT Id,Name FROM Attachment WHERE ParentId = :idPropiedad order By LastModifiedDate DESC];
        for(Attachment att:attachedFiles){
            urls.add(prefixUrl + att.Id);
        }
        //if(urls.size() == 0){
         //   urls.add(Utils.getResourceURL('noImage'));
       // }
        return urls;
    }
    public void getUrlImage(){
    set<Id> idPropiedades = new set<Id>();
    set<Id>parent = new set<Id>();
    string prefixUrl = '/servlet/servlet.FileDownload?file=';
    
    for(Propiedad__c propiedad22:propiedades){
      idPropiedades.add(propiedad22.Id);
   mapImagenesMini.put(propiedad22.Id,Utils.getResourceURL('noImage'));
    }
    
    List<Attachment> attachedFiles = [select Id,parentId from Attachment where parentId IN: idPropiedades  limit 1];
      for(Attachment  att: attachedFiles){
         if(mapImagenesMini.containsKey(att.parentId)){
                system.debug('HOla1');
               mapImagenesMini.put(att.parentId,prefixUrl+att.Id);
              }
              system.debug(mapImagenesMini);
          
        }
      }
    
    public class PropiedadWrapper implements Comparable{
        public Propiedad__c propiedad {get;set;}
        public Decimal distancia {get;set;}
        
        public PropiedadWrapper(){
        
        }
        
        public PropiedadWrapper(Propiedad__c propiedad, Decimal distancia ){
            this.propiedad = propiedad;
            this.distancia = distancia;
        }
        
         public Integer compareTo(Object compareTo) {
            PropiedadWrapper compareToOppy = (PropiedadWrapper)compareTo;
            Integer returnValue = 0;
             if (distancia > compareToOppy.distancia) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (distancia < compareToOppy.distancia) {
                // Set return value to a negative value.
                returnValue = -1;
            }
            return  returnValue;
         }
        
    }
    public list<PropiedadWrapper> getPropiedadesCercanas(){
        propiedades = new list<Propiedad__c>();
        propiedadesWrapper = new list<PropiedadWrapper>();
        set <PropiedadWrapper> propiedadesSet = new set<PropiedadWrapper>();
        
        Decimal  latitud = propiedad22.Punto__Latitude__s == null ? 0: propiedad22.Punto__Latitude__s;
        Decimal longitud = propiedad22.Punto__Longitude__s  == null ? 0: propiedad22.Punto__Longitude__s;
        
        Decimal latSup = latitud  - distanciaCoordenada;
        Decimal lngSup = longitud - distanciaCoordenada;
        
        Decimal latInf = latitud  + distanciaCoordenada;
        Decimal lngInf = longitud + distanciaCoordenada;
        
        propiedades =[SELECT Id,Name,Plaza__c,Estado__c,Estado2__c,EstadoCompleto__c,Municipio__c,Municipio2__c,Colonia__c,Colonia2__c,Calle__c,Calle2__c,CP__c,CP2__c, 
                             ValorCompra__c,ValorReferencia__c,Oferta_Valor_Referencia__c, Tipo__c,Punto__c,Punto__Latitude__s,Punto__Longitude__s,Geolocalizada__c,Terreno_m2__c,Construccion_m2__c ,
                             FechaPublicacionWeb__c, EstatusVenta2__c, FolioWeb__c, Estacionamiento__c, N_de_Ba_os__c, N_de_Habitaciones__c, Patios__c, Niveles_Plantas__c
                         FROM Propiedad__c 
                         WHERE Plaza__c =: propiedad22.Plaza__c AND Punto__Latitude__s != null AND Punto__Longitude__s != null 
                         AND id  !=: propiedad22.id
                         AND Colonia2__c =: propiedad22.Colonia2__c
                         AND EstatusWeb__c = 'Publicada'
                         limit 50];
        Decimal distanciaBase = 500;

        do{
            for( Propiedad__c propiedad : propiedades){
                Decimal dist = distanciaDos (latitud,longitud,propiedad.Punto__Latitude__s,propiedad.Punto__Longitude__s) * 1000;
                if(dist < = distanciaBase){
                    propiedadesSet.add( new PropiedadWrapper(propiedad,dist));
                }
                if(propiedadesSet.size() >= 10){
                    break;  
                }
            }
            distanciaBase = distanciaBase + 500;
        }while (distanciaBase <= 2000);
        getUrlImage();
        propiedadesWrapper.addAll(propiedadesSet);
        propiedadesWrapper.sort();
        return propiedadesWrapper;
    }   
    
    public static Decimal distancia(Decimal lat1, Decimal lng1, Decimal lat2, Decimal lng2){
        Decimal distance = 0.0;
        Double R =  6371;//radi de la Tierra Km;
        Double toRad = 0.0174532925; // (PI/180);
        Double dLat = (lat2 - lat1) * toRad;
        Double dLng = (lng2 - lng1) * toRad;
        Double a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1 * toRad) * Math.cos(lat2 * toRad);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        distance = R * c;
        return distance;
    }
    
    public static Decimal distanciaDos(Decimal lat1, Decimal lng1, Decimal lat2, Decimal lng2){
        Decimal distance = 0.0;
        Double R =  6371;//radi de la Tierra Km;
        Double dLat = toRadians (lat2 - lat1);
        Double dLon = toRadians (lng2 - lng1);
        Double a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(toRadians(lat1)) *   Math.cos(toRadians(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
        double c = 2 * Math.asin(Math.sqrt(a));
        distance = R * c * 0.62;
        return distance;
    }
    
    private static Double toRadians(Decimal degree){
        Double res= degree * 3.1415926 / 180;
        return res;
    }
    
    public pageReference vacio(){
        return null;
    }

    public PageReference doNothing()
    {
        return null;
    }
    
}