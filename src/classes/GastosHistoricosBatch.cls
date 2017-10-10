global class GastosHistoricosBatch implements Database.Batchable<sObject>{
     public String query = 'SELECT id,Name, ComisionComercial__c, Devolucion__c FROM Oferta__c Where ComisionComercial__c > 0 AND ComisionComercialReal__c = null';
     
     global Database.QueryLocator start(Database.BatchableContext BC){
         System.debug('EXECUTE BATCH START' + query);
         
         return Database.getQueryLocator(query);
     }
     
     global void execute(Database.BatchableContext info, List<Oferta__c> scope){
          System.debug('EXECUTE BATCH ' + query);
          
          String qryCatalogo = 'SELECT Name, Id FROM ConceptoCatalogo__c WHERE Name like \'%Histórico%\'';
          List<ConceptoCatalogo__c> conceptos = new List<ConceptoCatalogo__c>();
          map<String,ConceptoCatalogo__c> mapConcepto = new map<String,ConceptoCatalogo__c>();
          List<Gasto__c> gastosInsert = new List<Gasto__c>();
          try{
              conceptos = Database.query(qryCatalogo);
              for(ConceptoCatalogo__c cc:conceptos){
                  if(!mapConcepto.containsKey(cc.Name)){
                      mapConcepto.put(cc.Name,cc);
                  }
              }
          }catch(Exception e){
              System.debug('Error obteniendo concepto catalogo: ' + e.getMessage() + ',' + qryCatalogo );
          }
          
          for(Oferta__c oferta : scope){ 
              for(String nameConcepto : mapConceptoField.keyset()){
         	     if((Decimal)oferta.get(mapConceptoField.get(nameConcepto)) > 0){
              	  	  Gasto__c gasto = new Gasto__c();
	                  gasto.Account__c = '001i0000019JA4p';
	                  gasto.Oferta__c = oferta.Id;
	                  gasto.Tipo__c = 'Histórico';
	                  gasto.Comentario__c = 'Histórico producción (Sin cambios)';
	                  gasto.Concepto__c = mapConcepto.get(nameConcepto).Id;
	                  gasto.Importe__c = (Decimal)oferta.get(mapConceptoField.get(nameConcepto));
	                  System.debug('GASTO NUEVO' + gasto); 
	                  gastosInsert.add(gasto);
              	  }	
              }
          }
          
          upsert gastosInsert;
     }
     
     public map<String,string> mapConceptoField {
         get{
             if(mapConceptoField == null){
                 mapConceptoField = new Map<String,string>();
                 mapConceptoField.put('Comisión Comercial (Histórico)','ComisionComercial__c');
             }
             return mapConceptoField;
         }
         set;
     }
     
     global void finish(Database.BatchableContext info){     
     } 
}