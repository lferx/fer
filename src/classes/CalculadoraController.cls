public with sharing class CalculadoraController {


    public List<Oferta__c> idOfertasq {get;set;}            /////////Consulta para traer los valores necesarios de la oferta
    public List<listaOfertas> listaRegistros {get;set;} 
    public List<listaOfertas> ordenaIndex {get;set;} 
    public double valorReferencia {get;set;}                /////////variable que guarda el valor de referencia traido de la oferta
    public double costoTotalCampo {get;set;}                /////////variable que guarda el valor del costo total traido de la oferta
    
    
    public Integer del {get;set;}     
    
    public Boolean mostrarDialogo {get;set;}                      
    
    public ID varIdOferta {get;set;}                        /////////variable que guarda el id ingresado por el usuario
    public Integer posicion = 1;                            /////////variable que guarda la posicion de registro
    public String folio {get;set;}
    public double promvrPorcentaje {get;set;}
    public double sumaVr {get;set;} 
    public double sumaCt1 {get;set;} 
    public double sumaPm {get;set;} 
    public double sumaGe {get;set;} 
    public double sumaDes {get;set;} 
    public double sumagastoVenta {get;set;}
    public double promcomPorcentaje {get;set;}
    public double sumaCom {get;set;}
    public double sumaCt {get;set;}  
    public double sumaBen {get;set;} 
    public double prommarg {get;set;}
    
    public class listaOfertas{
        public ID idoferta {get;set;}
        public Integer pos {get;set;}
        public String folioLista {get;set;}
        public double vrPorcentaje {get;set;}
        public double vr {get;set;} 
        public double ctCamp {get;set;}
        public double pm {get;set;}  
        public double ge {get;set;}
        public double des {get;set;}
        public double gastoVenta{get;set;}
        public double comPorcentaje {get;set;}  
        public double com {get;set;} 
        public double ct {get;set;} 
        public double ben {get;set;} 
        public double marg {get;set;} 
    }
    
    /////////Constructor de la clase
    public CalculadoraController(ApexPages.StandardController controller) {
        listaRegistros = new List<listaOfertas>();
        limpiavariables();
    }
    
    public void sumas(){
        limpiavariables();
        integer n=0;
        for(listaOfertas registro : listaRegistros){
            n++;
            promvrPorcentaje += registro.vrPorcentaje;
            sumaVr += registro.vr;
            sumaCt1 += registro.ctCamp;
            sumaPm += registro.pm;
            sumaGe += registro.ge;
            sumaDes += registro.des;
            sumagastoVenta += registro.gastoVenta;
            promcomPorcentaje += registro.comPorcentaje;
            sumaCom += registro.com;
            sumaCt += registro.ct;
            sumaBen += registro.ben;
            prommarg += registro.marg;
        }
        if(n>0){
            promvrPorcentaje /= n;
            promcomPorcentaje /= n;
            prommarg /= n;
        }
    }
    
    public void limpiavariables(){
        folio = '';
        promvrPorcentaje = 0;
        sumaVr =0;
        sumaCt1 =0;
        sumaPm =0;
        sumaGe=0;
        sumaDes =0;
        sumagastoVenta=0;
        promcomPorcentaje =0;
        sumaCom =0;
        sumaCt =0;
        sumaBen =0;
        prommarg =0;
        
        
    }
    
    /////////Metodo para llenar la lista de registros
    public void llenaLista(){
        listaOfertas objListaOfertas = new listaOfertas();
        objListaOfertas.pos = posicion;
        
        idOfertasq = Database.query('SELECT ValorReferencia__c, TotalCosto__c,FolioLlave__c, ID From Oferta__c WHERE FolioLlave__c IN(:folio)'); 
        if(idOfertasq.size() > 0){
            for(Oferta__c registro : idOfertasq){
                folio = registro.FolioLlave__c;
                valorReferencia = registro.ValorReferencia__c;
                costoTotalCampo = registro.TotalCosto__c;
                varIdOferta = registro.ID;
            }  
            
            objListaOfertas.idoferta = varIdOferta;
            objListaOfertas.folioLista = folio;
            objListaOfertas.vr = valorReferencia;
            objListaOfertas.ctCamp = costoTotalCampo;
            objListaOfertas.comPorcentaje = 5;
            objListaOfertas.pm = valorReferencia;
            objListaOfertas.ge = 10000;
            objListaOfertas.des = 1500;
            objListaOfertas.gastoVenta = 0;
            //comienzan calculos
            objListaOfertas.vrPorcentaje = (objListaOfertas.pm / objListaOfertas.vr)*100;
            objListaOfertas.com = objListaOfertas.pm * objListaOfertas.comPorcentaje / 100;
            objListaOfertas.ct = objListaOfertas.ctCamp + objListaOfertas.des + objListaOfertas.com + objListaOfertas.ge + objListaOfertas.gastoVenta;
            objListaOfertas.ben = objListaOfertas.pm - objListaOfertas.ct;
            objListaOfertas.marg = objListaOfertas.ben / objListaOfertas.ct *100;
            /*
            objListaOfertas.vrPorcentaje = (objListaOfertas.pm / valorReferencia)*100;
            objListaOfertas.com = objListaOfertas.pm * (objListaOfertas.comPorcentaje/100);
            objListaOfertas.ct = costoTotalCampo + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge + objListaOfertas.gastoVenta;
            objListaOfertas.ben = objListaOfertas.pm - (costoTotalCampo + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100) ) + objListaOfertas.ge);
            objListaOfertas.marg = ((objListaOfertas.pm - (costoTotalCampo + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge)) / (costoTotalCampo + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge))*100;
            */
            //termina calculos
            
            listaRegistros.add(objListaOfertas);//aqui se llena la lista con valores
            posicion++;
            
            limpiavariables();
            mostrarDialogo = false;
            
        }
        else{
            mostrarDialogo = true;
        }
        sumas();
    }
    
    
    public void eliminaRegistro(){
    
        ordenaIndex = new List<listaOfertas>();
        Integer x = 1;
        
        listaRegistros.remove(del-1);
        
        for(listaOfertas reg : listaRegistros){
            reg.pos = x;
            ordenaIndex.add(reg);
            x++;
        }
        posicion = x;
        listaRegistros.clear();
        listaRegistros.addAll(ordenaIndex);
        ordenaIndex.clear();
        limpiavariables();
        sumas();
    }
    
    public void limpiar(){
        listaRegistros.clear();
        limpiavariables();
        posicion = 1;
    }
    
    public void actualizar(){
    
        listaOfertas objListaOfertas = new listaOfertas();
        
        objListaOfertas = listaRegistros.get(del-1);
            
            //comienzan calculos
            objListaOfertas.vrPorcentaje = (objListaOfertas.pm / objListaOfertas.vr)*100;
            objListaOfertas.com = objListaOfertas.pm * objListaOfertas.comPorcentaje / 100;
            objListaOfertas.ct = objListaOfertas.ctCamp + objListaOfertas.des + objListaOfertas.com + objListaOfertas.ge + objListaOfertas.gastoVenta;
            objListaOfertas.ben = objListaOfertas.pm - objListaOfertas.ct;
            objListaOfertas.marg = objListaOfertas.ben / objListaOfertas.ct *100;
            //termina calculos
            
            /*
            objListaOfertas.vrPorcentaje = (objListaOfertas.pm / objListaOfertas.vr)*100;
            objListaOfertas.com = objListaOfertas.pm * (objListaOfertas.comPorcentaje/100);
            objListaOfertas.ct = objListaOfertas.ctCamp + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge + ;
            objListaOfertas.ben = objListaOfertas.pm - (objListaOfertas.ctCamp + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge);
            objListaOfertas.marg = ((objListaOfertas.pm - (objListaOfertas.ctCamp + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge)) / (objListaOfertas.ctCamp + objListaOfertas.des + (objListaOfertas.pm * (objListaOfertas.comPorcentaje/100)) + objListaOfertas.ge))*100;
            */
            
        listaRegistros.set(del-1,objListaOfertas);
        sumas();
    }
    public PageReference exportarPaquete(){
        PageReference pagr = new PageReference('/apex/Calculadora_Excel');
        return pagr;
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
        
    }
    public void Coberturab(){
        Integer b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
        b = 1;
    }
    public void Coberturac(){
        Integer c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
        c = 1;
    }
    public void Coberturad(){
        Integer d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
        d = 1;
    }
    public void Coberturae(){
        Integer e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
        e = 1;
    }
    public void Coberturaf(){
        Integer f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
        f = 1;
    }
    public void Coberturah(){
        Integer h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
        h = 1;
    }
}