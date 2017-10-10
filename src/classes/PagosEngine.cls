public with sharing class PagosEngine {
    public static map<ID,ConceptoCatalogo__c> MAP_CONCEPTO_CATALOGO_ID {
        get {
            if(MAP_CONCEPTO_CATALOGO_ID == null) {
                MAP_CONCEPTO_CATALOGO_ID = new map<ID,ConceptoCatalogo__c>();
                for(ConceptoCatalogo__c item : [Select Id, Name, Tipo__c, Subtipo__c, Categoria__c, Concepto__c, CampoSuma__c, ObjetoSuma__c, ReglaValidacionA__c, ReglaValidacionB__c, ReglaValidacionC__c From ConceptoCatalogo__c]) {
                    MAP_CONCEPTO_CATALOGO_ID.put(item.Id,item);
                }
            }
            return MAP_CONCEPTO_CATALOGO_ID;
        }
        private set;
    }
    
    public static map<ID,ReglaValidacion__c> MAP_REGLAS_ID {
        get {
            if(MAP_REGLAS_ID == null) {
                MAP_REGLAS_ID = new map<ID,ReglaValidacion__c>();
                for(ReglaValidacion__c item : [select Id, Name, Tipo__c, Periodo__c, VecesPermitidas__c, LimiteMonto__c, LimitePorcentaje__c, CampoReferencia__c from ReglaValidacion__c]) {
                    MAP_REGLAS_ID.put(item.Id,item);
                }
            }
            return MAP_REGLAS_ID;
        }
        private set; 
    }
    
    public static final List<String> CAMPOS_REGLAS = new String[]{'ReglaValidacionA__c','ReglaValidacionB__c','ReglaValidacionC__c'};
    
    private Map<Id, List<Gasto__c>> mapGastosParent = new Map<Id, List<Gasto__c>>();
    private Map<Id, Oferta__c> mapOfertas = new Map<Id, Oferta__c>();
    
    public PagosEngine(List<Gasto__c> listaGastos){
        Set<String> setCatalogo = new Set<String>();
        Set<String> setGastosExistentes = new Set<String>();
        String whereClause = ' Id IN (';
        for(Gasto__c c : listaGastos){
            String parentId = c.Oferta__c != null? c.Oferta__c:c.Dimension1__c;
            if(!mapGastosParent.containsKey(parentId)){
                mapGastosParent.put(parentId, new List<Gasto__c>());
            }
            mapGastosParent.get(parentId).add(c);
            setCatalogo.add(c.Concepto__c);
            if(c.Id != null){
                setGastosExistentes.add(c.Id);
            }
            whereClause +='\''+ parentId + '\',';
        }
        
        whereClause = whereClause.left(whereClause.length()-1) + ') ';
        //String query = Utils.getCreatableFieldsSOQL('Oferta__c',whereClause,false);
        String query = 'select Id, OwnerId, Name, Anticipo__c, CobroFinal__c, CodigoPostal__c, CosteAdeudos__c, BeneficioNeto__c, CosteHonorariosNotaria__c, CosteImpuestosNotaria__c, CosteRehabilitacion__c, AvaluoCatastralCompra__c, EntidadFinanciera__c, EnviarAntecedenteNotaria__c, EnviarEmailNotaria__c, Promotor__c, Proceso__c, Etapa__c, FechaCobro__c, FirmaComprador__c, FirmaVendedor__c, Inversor__c, MargenBruto__c, Municipio__c, Notaria__c, Paquete__c, PrecioCompra__c, PrecioVenta__c, Contratista__c, Propiedad__c, Proyecto_final__c, TipoOferta__c, AvaluoCompra__c, AvaluoCatastralVenta__c, Plaza__c, Valuador__c, Direccion2__c, Comentarios__c, Sincronizado__c, EstatusCorreoNotaria__c, EnviosNotaria__c, CorreoNotaria__c, ClasificacionR5__c, PromotorFinal__c, Estatus__c, ValorReferencia__c, Invadida__c, Gravamen__c, FirmaEntidadFinanciera__c, MontoCredito__c, MontoContado__c, TotalCosto__c, Total_pagado__c, LiquidacionPendiente__c, CosteAdeudosVenta__c, MargenNeto__c, MargenRehabilitacion__c, FechaPago__c, PosesionLegal__c, ProblematicaComercial__c, DocumentosVerificados__c, ComisionComercial__c, Devolucion__c, FolioLlave__c, ClienteFinal__c, NombreCliente__c, UtilidadNeta__c, BuroCredito__c, CreditoInfonavit__c, AvaluoVenta__c, TiempoOferta__c, DiferenciaCompra__c, diferencia_venta__c, OfertaCobrada__c, Total_cobrado__c, NumeroClientes__c, InversorId__c, ResultadoRehabilitacion__c, ProyectoLiberado__c, Desalojo__c, Numero_de_promotores__c, Llave__c, Operador__c, DesalojosCompletados__c, CosteDesalojo2__c from Oferta__c Where ' + whereClause;
        system.debug(query);
        for(Oferta__c oferta : Database.query(query)){
            mapOfertas.put(oferta.Id, oferta);
        }
        
        for(Gasto__c c : [Select Id, Estatus__c, Name, Oferta__c, Concepto__c, Account__c, Fecha__c, CreatedDate, SolicitudPago__c From Gasto__c Where SolicitudPago__c != null AND EstatusManual__c NOT IN ('Cancelado','Rechazado','Histórico', 'Automático') AND (Oferta__c IN: mapGastosParent.keySet() OR Dimension1__c IN: mapGastosParent.keySet()) AND Concepto__c IN: setCatalogo AND Id NOT IN: setGastosExistentes]){
            String parentId = c.Oferta__c != null? c.Oferta__c:c.Dimension1__c;
            if(!mapGastosParent.containsKey(parentId)){
                mapGastosParent.put(parentId, new List<Gasto__c>());
            }
            mapGastosParent.get(parentId).add(c);
        }
        
    }
    
    public Gasto__c revisaValidacionesConcepto(Gasto__c con){
        con.ReglaValidacionA__c = null;
        con.ReglaValidacionB__c = null;
        con.ReglaValidacionC__c = null;
        con.ErrorDuplicado__c = '';
        for(String s : PagosEngine.CAMPOS_REGLAS){
            ConceptoCatalogo__c conCatalogo = PagosEngine.MAP_CONCEPTO_CATALOGO_ID.get(con.Concepto__c);
            String reglaId;
            if(conCatalogo.get(s) != null){
                reglaId = '' + conCatalogo.get(s);
            }
            if(reglaId != null && PagosEngine.MAP_REGLAS_ID.containsKey(reglaId)){
                ReglaValidacion__c regla = PagosEngine.MAP_REGLAS_ID.get(reglaId);
                if(regla.Tipo__c == 'Duplicado'){
                    validacionesDuplicados(con, conCatalogo, regla);
                }
                else if(regla.Tipo__c == 'Límite porcentaje'){
                    validacionesLimitePorcentaje(con, conCatalogo, regla);
                }
                else if(regla.Tipo__c == 'Límite monto'){
                    validacionesLimiteMonto(con, conCatalogo, regla);
                }
                
            }
        } 
        return con;
    }
    
    private Gasto__c validacionesDuplicados(Gasto__c con, ConceptoCatalogo__c conCatalogo, ReglaValidacion__c regla){
        Id parentId = (con.Oferta__c != null)? con.Oferta__c: con.Dimension1__c;
        Integer num = 0;
        Date fechaGasto = con.Fecha__c;
        String errorDuplicado = '';
        for(Gasto__c c : mapGastosParent.get(parentId)){
        	Integer numInicio = num;
			if((c.Id != con.Id) && (c.Concepto__c != con.Concepto__c || c.Estatus__c == 'Cancelado' || c.Estatus__c == 'Rechazado' || c.Estatus__c == 'Histórico' || c.Estatus__c == 'Automático' || (c.Estatus__c == 'Nuevo' && c.SolicitudPago__c == null))){
                continue; 
            }
            Date fechaPorComparar;
            if(c.Fecha__c != null){
                fechaPorComparar = c.Fecha__c;
            }
            
            if(regla.Periodo__c == 'Único'){
                num++;
            }
            else if(regla.Periodo__c == 'Anual'){
                if(fechaPorComparar.year() == fechaGasto.year()){
                    num++;
                }
            }
            else if(regla.Periodo__c == 'Mensual'){
                if(fechaPorComparar.toStartOfMonth() == fechaGasto.toStartOfMonth()){
                    num++;
                }
            }
            else if(regla.Periodo__c == 'Semanal'){
                if(fechaPorComparar.toStartOfWeek() == fechaGasto.toStartOfWeek()){
                    num++;
                }
            }
            else if(regla.Periodo__c == 'Diario'){
                if(fechaPorComparar == fechaGasto){
                    num++;
                }
            }
            if(numInicio != num && c.Id != con.Id){
            	if(c.Estatus__c == 'Nuevo' && c.SolicitudPago__c != null){
            		errorDuplicado += c.Name + ' - ' + 'Agrupado\n';
            	}else{
            		errorDuplicado += c.Name + ' - ' + c.Estatus__c + '\n';
            	}
            	 
            }
        }
        if(num > regla.VecesPermitidas__c && con.Tipo__c != 'Automático'){
            if(con.ReglaValidacionC__c == null){ 
                con.ReglaValidacionC__c = regla.Id;
            }else if(con.ReglaValidacionB__c == null){
                con.ReglaValidacionB__c = regla.Id;
            }else if(con.ReglaValidacionA__c == null){
                con.ReglaValidacionA__c = regla.Id;
            }
            con.ErrorDuplicado__c = '!Este pago ya se había solicitado!\n' + errorDuplicado;
            if(con.AprobacionDuplicado__c == null){
            	con.AprobacionDuplicado__c = 'Rechazado';
            }
        }else{
        	con.AprobacionDuplicado__c = null;
        }
        return con;
    }
    
    private Gasto__c validacionesLimitePorcentaje(Gasto__c con, ConceptoCatalogo__c conCatalogo, ReglaValidacion__c regla){
        if(mapOfertas.containsKey(con.Oferta__c)){
            Double montoReferencia = mapOfertas.get(con.Oferta__c).get(regla.CampoReferencia__c) != null? Double.valueOf(mapOfertas.get(con.Oferta__c).get(regla.CampoReferencia__c)) : 0;
            if(con.Importe__c/montoReferencia > regla.LimitePorcentaje__c/100){
                if(con.ReglaValidacionA__c == null){
                    con.ReglaValidacionA__c = regla.Id;
                }else if(con.ReglaValidacionB__c == null){
                    con.ReglaValidacionB__c = regla.Id;
                }else if(con.ReglaValidacionC__c == null){
                    con.ReglaValidacionC__c = regla.Id;
                }
            }
        }
        return con;
    }
    
    private Gasto__c validacionesLimiteMonto(Gasto__c con, ConceptoCatalogo__c conCatalogo, ReglaValidacion__c regla){
            if(con.Importe__c > regla.LimiteMonto__c){
                if(con.ReglaValidacionA__c == null){
                    con.ReglaValidacionA__c = regla.Id;
                }else if(con.ReglaValidacionB__c == null){
                    con.ReglaValidacionB__c = regla.Id;
                }else if(con.ReglaValidacionC__c == null){
                    con.ReglaValidacionC__c = regla.Id;
                }
            }
        return con;
    }
}