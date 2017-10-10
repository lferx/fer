public without sharing class Detalle_de_Colonia_Controller {

	private final sObject mysObject;
    private final id idColonia;

    public ColoniaFraccionamiento__c objColonia {get;set;}
    public List<Propiedad__c> propiedades {get;set;}

    //public integer total {get;set;}

    public Decimal plat {get;set;}
    public Decimal plng {get;set;}

    public boolean hayQueActualizar = false;
    public ColoniaFraccionamiento__c nuevaColonia;



    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    public Detalle_de_Colonia_Controller(ApexPages.StandardController stdController) {
        this.mysObject = (sObject)stdController.getRecord();
        idColonia = mysObject.id;
        if(String.isNotBlank(idColonia)){
            refrescar();
        }
        system.debug(mysObject);

        
    }
    public void refrescar(){
        objColonia = obtenerColonia(idColonia);

        nuevaColonia = new ColoniaFraccionamiento__c();
        nuevaColonia.id = objColonia.id;

        propiedades = obtenerPropiedades(idColonia);
        //obtenerPuntuacion();
        //getCalcular();
        //getAhorro();
        localicacion();
        ajustarPreciosColonia();
    }
    public void localicacion(){
        //Zocalo del DF
        plat = 19.432632;
        plng = -99.133298;
        if(objColonia.Punto__Longitude__s != null && objColonia.Punto__Latitude__s != null){
            plat = objColonia.Punto__Latitude__s;
            plng = objColonia.Punto__Longitude__s;
        }
    }

    public void ajustarPreciosColonia(){
        
        Double precioMinRevimex = 0;
        Double precioMaxRevimex = 0;
        Double precioMedio = 0;
        Double metroTerrenoMedio = 0;
        Double metroConstruccionMedio = 0;
        Integer contadorMedio = 0;

        //cobradas
        Double precioMedioCobradas = 0;
        Double consVendidas = 0;
        Integer contadorMedioCobradas = 0;
        //fin cobradas

        Double diasStockMedio = 0;
        integer contadorDias = 0;



        boolean bandera = true;
        system.debug('codigo 300');
        for(Propiedad__c x: propiedades){
            system.debug('codigo 301');

            if(x.Oferta_Valor_Referencia__c != NULL && x.Terreno_m2__c != NULL && x.Construccion_m2__c != NULL && x.Oferta_Valor_Referencia__c > 0 && x.Terreno_m2__c > 0 && x.Construccion_m2__c > 0){
                if(bandera){
                    precioMinRevimex = x.Oferta_Valor_Referencia__c;
                    precioMaxRevimex = x.Oferta_Valor_Referencia__c;
                    bandera = false;
                }
                else{
                    if(x.Oferta_Valor_Referencia__c < precioMinRevimex){
                        precioMinRevimex = x.Oferta_Valor_Referencia__c;
                    }
                    if(x.Oferta_Valor_Referencia__c > precioMaxRevimex){
                        precioMaxRevimex = x.Oferta_Valor_Referencia__c;
                    }
                }

                precioMedio += x.Oferta_Valor_Referencia__c;
                metroTerrenoMedio += x.Terreno_m2__c;
                metroConstruccionMedio +=  x.Construccion_m2__c;
                contadorMedio ++;
            }
            if(x.ltima_Oferta__r.Total_cobrado__c != null && x.ltima_Oferta__r.Total_cobrado__c > 0 && x.ltima_Oferta__r.FechaCobro__c != null && x.Construccion_m2__c != NULL && x.Construccion_m2__c > 0){
                precioMedioCobradas += x.ltima_Oferta__r.Total_cobrado__c;
                consVendidas += x.Construccion_m2__c;
                contadorMedioCobradas +=1;
            }
            if(x.ltima_Oferta__r.FechaCobro__c != null && x.ltima_Oferta__r.TiempoOferta__c != null){
                diasStockMedio += x.ltima_Oferta__r.TiempoOferta__c;
                contadorDias += 1;
            }

            
        }

        if(contadorDias > 0){
            diasStockMedio /= contadorDias;
            if(objColonia.Dias_medio_de_venta__c != diasStockMedio){
                nuevaColonia.Dias_medio_de_venta__c = diasStockMedio;
                hayQueActualizar = true;
            }
        }
        if(contadorMedio > 0){
            system.debug('codigo 400');
            precioMedio /= contadorMedio;
            metroTerrenoMedio /= contadorMedio;
            metroConstruccionMedio /= contadorMedio;
        }
        if(contadorMedioCobradas > 0){
            system.debug('codigo 500');
            precioMedioCobradas /= contadorMedioCobradas;
            consVendidas /= contadorMedioCobradas;
        }
        if(contadorMedioCobradas > 0 || contadorMedio > 0){
            system.debug('codigo 600');
            if(objColonia.Precio_minimo_revimex__c!=precioMinRevimex){
                nuevaColonia.Precio_minimo_revimex__c=precioMinRevimex;
                hayQueActualizar = true;
            }
            if(objColonia.Precio_maximo_revimex__c!=precioMaxRevimex){
                nuevaColonia.Precio_maximo_revimex__c=precioMaxRevimex;
                hayQueActualizar = true;
            }
            if(objColonia.Precio_medio_de_revimex__c!=precioMedio){
                nuevaColonia.Precio_medio_de_revimex__c=precioMedio;
                hayQueActualizar = true;
            }
            if(objColonia.m2_construccion_medio_revimex__c!=metroConstruccionMedio){
                nuevaColonia.m2_construccion_medio_revimex__c=metroConstruccionMedio;
                hayQueActualizar = true;
            }
            if(objColonia.m2_terreno_medio_revimex__c!=metroTerrenoMedio){
                nuevaColonia.m2_terreno_medio_revimex__c=metroTerrenoMedio;
                hayQueActualizar = true;
            }
            if(objColonia.Precio_medio_vendido__c != precioMedioCobradas){
                nuevaColonia.Precio_medio_vendido__c = precioMedioCobradas;
                hayQueActualizar = true;
            }
            if(objColonia.m2_construccion_medio_vendido__c != consVendidas){
                nuevaColonia.m2_construccion_medio_vendido__c = consVendidas;
                hayQueActualizar = true;
            }
            system.debug('Colonia: '+objColonia);
        }
    }
    public void actualizar(){
        if(hayQueActualizar){
            update nuevaColonia;
            //refesh();
            system.debug('si actualizo');
        }
    }
    //public PageReference refesh(){
    //    refrescar();
    //    PageReference p = new Apexpages.Standardcontroller(mysObject).view();
    //    p.setRedirect(true); 
    //    return p;
    //}

    //public void obtenerPuntuacion(){
    //    total = 0;
    //    if(String.isNotBlank(objColonia.Calificacion_centros_comerciales__c))
    //        total += integer.valueOf(objColonia.Calificacion_centros_comerciales__c);

    //    if(String.isNotBlank(objColonia.Calificacion_escuelas__c))
    //        total += integer.valueOf(objColonia.Calificacion_escuelas__c);

    //    if(String.isNotBlank(objColonia.Calificacion_hospitales__c))
    //        total += integer.valueOf(objColonia.Calificacion_hospitales__c);

    //    if(String.isNotBlank(objColonia.Calificacion_parques__c))
    //        total += integer.valueOf(objColonia.Calificacion_parques__c);

    //    if(String.isNotBlank(objColonia.Calificacion_restaurantes__c))
    //        total += integer.valueOf(objColonia.Calificacion_restaurantes__c);

    //    if(String.isNotBlank(objColonia.Calificacion_super__c))
    //        total += integer.valueOf(objColonia.Calificacion_super__c);
    //}

    //public integer getCalcular(){
    //    integer countPrecioVenta = 0;
    //    integer sumarPrecioVenta = 0;
    //    integer result = 0;
    //    for(Propiedad__c x : propiedades){
    //        if(x.ltima_Oferta__r.PrecioVenta__c != null && x.ltima_Oferta__r.PrecioVenta__c > 0 && x.ltima_Oferta__r.FechaPago__c != null){
    //            sumarPrecioVenta += integer.valueOf(x.ltima_Oferta__r.PrecioVenta__c);
    //            countPrecioVenta ++;
    //        }
    //    }
    //    if(sumarPrecioVenta > 0 && countPrecioVenta > 0){
    //        return sumarPrecioVenta / countPrecioVenta;
    //    }else{
    //        return 0;
    //    }

    //}

    //public integer getAhorro(){
    //    integer result = 0;
    //    if(objColonia.Precio_por_m2_construccion_mercado__c > 0 && objColonia.Precio_por_m2_construccion_revimex__c > 0){
    //        result=integer.valueOf(((objColonia.Precio_por_m2_construccion_mercado__c - objColonia.Precio_por_m2_construccion_revimex__c) / objColonia.Precio_por_m2_construccion_revimex__c)*100);
    //    }
    //    return result;
    //}

    //public integer getPrecioPorM2(){
    //    integer cal = getCalcular();
    //    integer result = 0;
    //    if(cal > 0 && objColonia.m2_construccion_medio_revimex__c != NULL && objColonia.m2_construccion_medio_revimex__c > 0){
    //        //hola
    //        result = integer.valueOf(cal / objColonia.m2_construccion_medio_revimex__c);
    //    }
    //    return result;
    //    //IF(AND(Calcular > 0 , ColoniaFraccionamiento__c.m2_construccion_medio_revimex__c > 0),(Calcular / ColoniaFraccionamiento__c.m2_construccion_medio_revimex__c),0)}
    //}
    public List<Propiedad__c> obtenerPropiedades(id idCol){
        //return null;//[SELECT Name, id FROM Propiedad__c WHERE Colonia_busqueda__c IN :idCol AND ltima_Oferta__c. ];
        //SELECT id,name,Colonia_Busqueda__c,Oferta_Valor_Referencia__c,Terreno_m2__c,Construccion_m2__c FROM Propiedad__c WHERE Colonia_Busqueda__c in :allID AND Oferta__r.Estatus__c != 'Descartada' AND Oferta__r.FechaPago__c != NULL AND Colonia_Busqueda__c != NULL AND Oferta_Valor_Referencia__c != NULL AND Terreno_m2__c != NULL AND Construccion_m2__c != NULL AND Oferta_Valor_Referencia__c > 0 AND Terreno_m2__c > 0 AND Construccion_m2__c > 0
        //return [SELECT Name,ltima_Oferta__r.Name,ltima_Oferta__r.PrecioCompra__c,ltima_Oferta__r.PrecioVenta__c,ltima_Oferta__r.Precio_Original__c,ltima_Oferta__r.TotalCosto__c,ltima_Oferta__r.Total_cobrado__c,ltima_Oferta__r.Total_pagado__c,ltima_Oferta__r.ValorReferencia__c FROM Propiedad__c WHERE ltima_Oferta__r.Estatus__c != 'Descartada' AND ltima_Oferta__r.FechaPago__c != null AND Colonia_busqueda__c IN (:idCol)];
        return [SELECT ltima_Oferta__c,ltima_Oferta__r.TiempoOferta__c, ltima_Oferta__r.FechaCobro__c,Oferta_Valor_Referencia__c,Terreno_m2__c,Construccion_m2__c,EstatusVenta2__c,ltima_Oferta__r.FechaPago__c,ltima_Oferta__r.PrecioCompra__c,ltima_Oferta__r.PrecioVenta__c,ltima_Oferta__r.Precio_Original__c,ltima_Oferta__r.TotalCosto__c,ltima_Oferta__r.Total_cobrado__c,ltima_Oferta__r.Total_pagado__c,ltima_Oferta__r.ValorReferencia__c FROM Propiedad__c WHERE ltima_Oferta__r.Estatus__c != 'Descartada' AND Colonia_busqueda__c =:idCol];
    }
    public ColoniaFraccionamiento__c obtenerColonia(id idCol){
        return [SELECT Ahorro__c,Dias_medio_de_venta__c,m2_terreno_medio_revimex__c,m2_construccion_medio_vendido__c,Precio_medio_vendido__c,Precio_medio_de_revimex__c,Precio_maximo_revimex__c,Precio_minimo_revimex__c,Name,Vendidas__c,Propiedades_Disponibles__c,Punto__Latitude__s,Punto__Longitude__s,m2_construccion_medio_revimex__c,Precio_por_m2_construccion_mercado__c,Precio_por_m2_construccion_revimex__c, Calificacion_centros_comerciales__c, Calificacion_escuelas__c, Calificacion_hospitales__c, Calificacion_parques__c, Calificacion_restaurantes__c, Calificacion_super__c FROM ColoniaFraccionamiento__c WHERE id =:idCol];
    }

    public void guardar(){
        update objColonia;
        refrescar();
    }


    
}