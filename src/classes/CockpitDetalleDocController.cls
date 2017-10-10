public with sharing class CockpitDetalleDocController {
    private string docid;
    private string docsemaforo;
    public list<Documento__c> ldocu {get; set;}
    public map<String,list<Documento__c>> mdocplaza = new map<String,list<Documento__c>>();
    public list<Documento__c> ldocplaza {get;set;}
    public CockpitDetalleDocController()
    {
        docid = ApexPages.currentPage().getParameters().get('idoc');
        docsemaforo = ApexPages.currentPage().getParameters().get('docsem');
        ldocu = [SELECT id, Oferta__c, Name, Oferta__r.Propiedad__r.Plaza__c, Oferta__r.Name, Tiempo_Restante__c, Fecha_Com_Controller__c, DocumentoEtapa__c, DocumentoEtapa__r.Name, 
                        Semaforo__c, DocumentoEtapa__r.Tiempo_Proceso__c, Oferta__r.OwnerId 
                 FROM Documento__c WHERE Iniciado__c =: true AND Cerrado__c =:false AND DocumentoEtapa__c =: docid AND Semaforo__c =: docsemaforo AND
                        Oferta__r.Estatus__c !=: 'Finalizada' AND Oferta__r.Estatus__c !=: 'Descartada' Order by Oferta__r.Propiedad__r.Plaza__c, DocumentoEtapa__c];
         system.debug('Este es el ldocu' + ldocu);
                  
    }
    public map<String,list<Documento__c>> getmdocplaza()
    {
    	for (Documento__c doc :ldocu)
        {
            
           if(mdocplaza.get(doc.Oferta__r.Propiedad__r.Plaza__c) == null)
           {
               mdocplaza.put(doc.Oferta__r.Propiedad__r.Plaza__c, new list<Documento__c> {doc});
           }else
           {
               mdocplaza.get(doc.Oferta__r.Propiedad__r.Plaza__c).add(doc);
           }
            
           
            
        }
        return mdocplaza;
    }
}