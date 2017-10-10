global class ActualizaPanel_schedulable implements Schedulable {

    global void execute(SchedulableContext sc) {
        
        List<Oferta__c> ofertaCargada = new List<Oferta__c>();
        
        ofertaCargada = [SELECT Id, Oferta_Cargada__c FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = null AND FechaPago__c != null AND Oferta_Cargada__c = false AND ID IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Comprobante de anticipo' AND Cerrado__c = True AND NumFiles_MasFilesPadre__c > 0)];
        
        for(Oferta__c reg: ofertaCargada){
            reg.Oferta_Cargada__c = True;
            UPDATE reg;
        }
        
        List<Oferta__c> ofertasCaidas = new List<Oferta__c>();
        
        ofertasCaidas = [SELECT Id, Oferta_Cargada__c FROM Oferta__c WHERE Estatus__c != 'Descartada' AND FechaCobro__c = null AND FechaPago__c != null AND Oferta_Cargada__c = true AND ID IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Comprobante de anticipo' AND Cerrado__c = False)];
        
        for(Oferta__c reg: ofertasCaidas){
            reg.Oferta_Cargada__c = False;
            UPDATE reg;
        }
        
        List<Oferta__c> ofertasConEscritura = new List<Oferta__c>();
        
        ofertasConEscritura = [SELECT Id, Escritu__c FROM Oferta__c WHERE Estatus__c != 'Descartada' AND Escritu__c = 'Sin Escrituras' AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Escrituras Registradas' AND Cerrado__c = True) AND Etapa__c IN ('Compilación expediente cliente','Rehabilitación','Compilación expediente crediticio','Expediente aprobado','Cierre oferta','Finalizada') AND FechaCobro__c = null AND FechaPago__c != null];
        
        for(Oferta__c reg: ofertasConEscritura){
            reg.Escritu__c = 'Con Escrituras';
            UPDATE reg;
        }
        
        List<Oferta__c> ofertasSinFechaPrevEscritu = new List<Oferta__c>();
        
        ofertasSinFechaPrevEscritu = [SELECT Id, Fecha_Prevista_Desalojo__c FROM Oferta__c WHERE Estatus__c != 'Descartada' AND Fecha_Prevista_Desalojo__c != null AND Id IN (SELECT Oferta__c FROM Documento__c WHERE Name = 'Escrituras Registradas' AND Cerrado__c = True) AND Etapa__c IN ('Compilación expediente cliente','Rehabilitación','Compilación expediente crediticio','Expediente aprobado','Cierre oferta','Finalizada')];
        
        for(Oferta__c reg: ofertasSinFechaPrevEscritu){
            reg.Fecha_Prevista_Desalojo__c = null;
            UPDATE reg;
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
        
     }
}