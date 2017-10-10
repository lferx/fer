public class SitioHomePageController{
    public Prospecto__c prospecto {get;set;}
    public Boolean mensajeEnviado {get;set;}
    
    public Decimal homeAhorrado {get;set;}
    public Decimal homePropiedadVendidas {get;set;}
    public Decimal homePropiedadDisponibles {get;set;}
    
    public SitioHomePageController(PropiedadDetalleController controller) {
         prospecto = new Prospecto__c();
         prospecto.FechaNacimientoTexto__c = '18/09/1985';
        obtieneDatosHome();
    }  
    
    public SitioHomePageController(PropiedadesController controller) {
         prospecto = new Prospecto__c();
         prospecto.FechaNacimientoTexto__c = '18/09/1985';
         mensajeEnviado = false;
         obtieneDatosHome();
    }
    
    public SitioHomePageController(){
        prospecto = new Prospecto__c();
        prospecto.FechaNacimientoTexto__c = '18/09/1985'; 
        mensajeEnviado = false; 
        obtieneDatosHome();
    }
    

    public PageReference guardaProspecto() { 
        upsert prospecto;
        //prospecto = new Prospecto__c();
        mensajeEnviado = true;
        return null;
    }
    public PageReference omitirSegundoPaso(){
        prospecto = new Prospecto__c(); 
        mensajeEnviado = false;
        return null;
    }
    
    public void obtieneDatosHome(){
        
        Decimal sumVendidoAux = 0;
        Decimal sumValorReferenciaAux = 0; 
        
        Integer hpd = [SELECT Count()  FROM Oferta__c WHERE Etapa__c IN('Oferta','Oferta en proceso','Oferta aprobada','Antecedentes','Aprobada internamente','Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')];
        Integer ov = [SELECT Count()  FROM Oferta__c WHERE Oferta__c.FechaCobro__c != null ];
        
        List<AggregateResult> sumVendido = [SELECT SUM( Oferta__c.PrecioVenta__c ) total FROM Oferta__c WHERE Oferta__c.FechaCobro__c != null];
        List<AggregateResult> sumValorReferencia = [SELECT SUM( Oferta__c.ValorReferencia__c ) total FROM Oferta__c WHERE Oferta__c.FechaCobro__c != null];
        
        if( sumVendido != null && sumVendido.size() > 0){
            sumVendidoAux =  sumVendido[0].get('total')!= null ? Decimal.valueOf(String.valueOf(sumVendido[0].get('total'))) : 0;
        }else{
            sumVendidoAux = 0;
        }
        
        if( sumValorReferencia != null && sumValorReferencia.size() > 0){
            sumValorReferenciaAux = sumValorReferencia[0].get('total') != null ? Decimal.valueOf(String.valueOf(sumValorReferencia[0].get('total'))) : 0;
        }else{
            sumValorReferenciaAux = 0;
        }
        

        
        homeAhorrado = (sumValorReferenciaAux - sumVendidoAux) / 1000000;
        

        
        homePropiedadDisponibles    = Decimal.valueOf(hpd+'.00');
        homePropiedadVendidas       = Decimal.valueOf( ov+'.00');   
        
        Decimal contadorCasas = 0;
        
        for(Integer c = 0; c < 100 ; c++){
            contadorCasas+= c*c;                
        }
        
        System.debug( contadorCasas );
      
    }
}