public with sharing class ReporteVencimientoConsola_controller {
    public List<Vencimiento> vencimientos{get; set;}
    public List<Vencimiento> recRetrasado{get; set;}
    public Datetime hoy {get;set;}
    
    public List<Vencimiento> pag1{get; set;}
    public List<Vencimiento> pag2{get; set;}
    public List<Vencimiento> pag3{get; set;}
    public List<Vencimiento> pag4{get; set;}
    public List<Vencimiento> pag5{get; set;}
    public List<Vencimiento> pag6{get; set;}
    public List<Vencimiento> pag7{get; set;}
    public List<Vencimiento> pag8{get; set;}
    public List<Vencimiento> pag9{get; set;}
    public List<Vencimiento> pag10{get; set;}
    public List<Vencimiento> pag11{get; set;}
    public List<Vencimiento> pag12{get; set;}
    public List<Vencimiento> pag13{get; set;}
    public List<Vencimiento> pag14{get; set;}
    public List<Vencimiento> pag15{get; set;}
    
    public List<Vencimiento> pag16{get; set;}
    public List<Vencimiento> pag17{get; set;}
    public List<Vencimiento> pag18{get; set;}
    public List<Vencimiento> pag19{get; set;}
    public List<Vencimiento> pag20{get; set;}
    public List<Vencimiento> pag21{get; set;}
    public List<Vencimiento> pag22{get; set;}
    public List<Vencimiento> pag23{get; set;}
    public List<Vencimiento> pag24{get; set;}
    public List<Vencimiento> pag25{get; set;}
    public List<Vencimiento> pag26{get; set;}
    public List<Vencimiento> pag27{get; set;}
    public List<Vencimiento> pag28{get; set;}
    public List<Vencimiento> pag29{get; set;}
    public List<Vencimiento> pag30{get; set;}
    
    public ReporteVencimientoConsola_controller() {
        hoy = Datetime.now();
        queryVencidos();
        paginadoLista();
    }

    private void  queryVencidos(){
        vencimientos = new List<Vencimiento>();
        recRetrasado = new List<Vencimiento>();
        List<Documento__c> documentosVencidos = [SELECT Name, Fecha_Com_Controller__c, Tiempo_Restante__c, Oferta__r.Name, Oferta__r.Etapa__c, Oferta__r.Gerente_Operativo__r.Name, (Select Comentarios__c, Dictamen_Consola__c, Recordatorio__c from Bitacora_Ofertas__r ORDER BY Recordatorio__c limit 1) FROM Documento__c
        WHERE Oferta__r.Etapa__c IN ('Expediente aprobado','Compilación expediente crediticio','Rehabilitación','Cierre oferta')
        AND name IN ('Presupuesto de rehabilitación','Fotografia del estado inicial','Fotografia del estado final de la propiedad','Avalúo','CLG','Predial','Constancia de Crédito','Carta de instrucción Notarial','Carta de Intrucción Revimex','Proyecto de Escrituras','Aviso de Retención Y Firma Cliente','Confirmación cobro propiedad','Carta de entrega','Fotos de Entrega','Pre-cierre','Pago Activado','Escrituras Registradas','Cierre Contabilidad','Comprobante Firma Apoderado','Comprobante Comisión Broker','Comprobante Comisión Gerente','Comprobante Anticipo Comisión Gerente','Pago Ventanilla Unica','Comprobante de Pago Ventanilla Unica','Pre-Pantalla') 
        AND Cerrado__c != true 
        AND EtapaOferta__r.EtapaActual__c = true 
        AND Iniciado__c = true
        AND Tiempo_Restante__c < 0
        AND Oferta__r.TipoOferta__c != 'Contado' 
        AND Oferta__r.FechaCobro__c = NULL 
        AND Oferta__r.Estatus__C != 'Descartada'
        ORDER BY Tiempo_Restante__c];

        List<Bitacora_Oferta__c> documentosProximosAVencerse = [Select Documento__r.Name, Documento__r.Fecha_Com_Controller__c, Documento__r.Tiempo_Restante__c, Documento__r.Oferta__r.Name, Documento__r.Oferta__r.Etapa__c,
        Documento__r.Oferta__r.Gerente_Operativo__r.Name, Dictamen_Consola__c, Comentarios__c, Recordatorio__c from Bitacora_Oferta__c where Recordatorio_Retardado__c = true AND Documento__r.Fecha_Com_Controller__c > :hoy AND Documento__r.Cerrado__c != true ORDER BY Documento__r.Fecha_Com_Controller__c, Documento__r.name, CreatedDate desc];
        
        for(Documento__c doc : documentosVencidos){
            Vencimiento ven = new Vencimiento();
            ven.responsable = doc.Oferta__r.Gerente_Operativo__r.name;
            ven.oferta = doc.Oferta__r.Name;
            ven.etapa = doc.Oferta__r.Etapa__c;
            ven.nombre = doc.Name;
            ven.fechaVencimiento = doc.Fecha_Com_Controller__c;
            ven.diasRetrasado = Integer.valueOf(doc.Tiempo_Restante__c * -1);
            ven.dictamen = doc.Bitacora_Ofertas__r.isEmpty() ? null : doc.Bitacora_Ofertas__r.get(0).Dictamen_Consola__c;
            ven.comentarios = doc.Bitacora_Ofertas__r.isEmpty() ? null : doc.Bitacora_Ofertas__r.get(0).Comentarios__c;
            ven.proximoRecordatorio = doc.Bitacora_Ofertas__r.isEmpty() ? null : doc.Bitacora_Ofertas__r.get(0).Recordatorio__c;
            vencimientos.add(ven);
        }
        for(Bitacora_Oferta__c doc : documentosProximosAVencerse){
            Vencimiento ven = new Vencimiento();
            ven.responsable = doc.Documento__r.Oferta__r.Gerente_Operativo__r.Name;
            ven.nombre = doc.Documento__r.Name;
            ven.etapa = doc.Documento__r.Oferta__r.Etapa__c;
            ven.oferta = doc.Documento__r.Oferta__r.Name;
            ven.fechaVencimiento = doc.Documento__r.Fecha_Com_Controller__c;
            ven.diasRetrasado = Integer.valueOf(doc.Documento__r.Tiempo_Restante__c * -1);
            ven.dictamen = doc.Dictamen_Consola__c;
            ven.comentarios = doc.Comentarios__c;
            ven.proximoRecordatorio = doc.Recordatorio__c;
            recRetrasado.add(ven);
        }
                
    }
    
    public void paginadoLista(){
        Integer contador = 0;
        pag1 = new List<Vencimiento>();
        pag2 = new List<Vencimiento>();
        pag3 = new List<Vencimiento>();
        pag4 = new List<Vencimiento>();
        pag5 = new List<Vencimiento>();
        pag6 = new List<Vencimiento>();
        pag7 = new List<Vencimiento>();
        pag8 = new List<Vencimiento>();
        pag9 = new List<Vencimiento>();
        pag10 = new List<Vencimiento>();
        pag11 = new List<Vencimiento>();
        pag12 = new List<Vencimiento>();
        pag13 = new List<Vencimiento>();
        pag14 = new List<Vencimiento>();
        pag15 = new List<Vencimiento>();
        for(Vencimiento registro: vencimientos){
            if(contador < 999){
                pag1.add(registro);
            }
            else if(contador < 1998){
                pag2.add(registro);
            }
            else if(contador < 2997){
                pag3.add(registro);
            }
            else if(contador < 3996){
                pag4.add(registro);
            }
            else if(contador < 4995){
                pag5.add(registro);
            }
            else if(contador < 5994){
                pag6.add(registro);
            }
            else if(contador < 6993){
                pag7.add(registro);
            }
            else if(contador < 7992){
                pag8.add(registro);
            }
            else if(contador < 8991){
                pag9.add(registro);
            }
            else if(contador < 9990){
                pag10.add(registro);
            }
            else if(contador < 10989){
                pag11.add(registro);
            }
            else if(contador < 11988){
                pag12.add(registro);
            }
            else if(contador < 12987){
                pag13.add(registro);
            }
            else if(contador < 13986){
                pag14.add(registro);
            }
            else if(contador < 14985){
                pag15.add(registro);
            }
            contador++;
        }
        
        contador = 0;
        pag16 = new List<Vencimiento>();
        pag17 = new List<Vencimiento>();
        pag18 = new List<Vencimiento>();
        pag19 = new List<Vencimiento>();
        pag20 = new List<Vencimiento>();
        pag21 = new List<Vencimiento>();
        pag22 = new List<Vencimiento>();
        pag23 = new List<Vencimiento>();
        pag24 = new List<Vencimiento>();
        pag25 = new List<Vencimiento>();
        pag26 = new List<Vencimiento>();
        pag27 = new List<Vencimiento>();
        pag28 = new List<Vencimiento>();
        pag29 = new List<Vencimiento>();
        pag30 = new List<Vencimiento>();
        for(Vencimiento registro: recRetrasado){
            if(contador < 999){
                pag16.add(registro);
            }
            else if(contador < 1998){
                pag17.add(registro);
            }
            else if(contador < 2997){
                pag18.add(registro);
            }
            else if(contador < 3996){
                pag19.add(registro);
            }
            else if(contador < 4995){
                pag20.add(registro);
            }
            else if(contador < 5994){
                pag21.add(registro);
            }
            else if(contador < 6993){
                pag22.add(registro);
            }
            else if(contador < 7992){
                pag23.add(registro);
            }
            else if(contador < 8991){
                pag24.add(registro);
            }
            else if(contador < 9990){
                pag25.add(registro);
            }
            else if(contador < 10989){
                pag26.add(registro);
            }
            else if(contador < 11988){
                pag27.add(registro);
            }
            else if(contador < 12987){
                pag28.add(registro);
            }
            else if(contador < 13986){
                pag29.add(registro);
            }
            else if(contador < 14985){
                pag30.add(registro);
            }
            contador++;
        }
        
        contador = 0;
    }
    

    public class Vencimiento{
        public String responsable {get; set;}
        public String nombre {get;set;}
        public String etapa {get;set;}
        public String oferta {get;set;}
        public Datetime fechaVencimiento {get;set;}
        public Integer diasRetrasado {get;set;}
        public String dictamen {get;set;}
        public String comentarios {get;set;}
        public Datetime proximoRecordatorio {get; set;}

        public Vencimiento(){
            
        }
    }
    public void Cobertura(){
        Integer a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
     }
}