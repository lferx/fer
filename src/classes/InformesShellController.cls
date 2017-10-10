public with sharing class InformesShellController {

    public InformesShellController(ApexPages.StandardController controller) {

    }


public List<Propiedad__c>propiedades{get;set;}
public List<Propiedad__c>propiedades2{get;set;}
public List<Oferta__c>CargaOferta{get;set;}
public List<Oferta__c>CargaOferta2{get;set;}
public InformesShellController()
{
  propiedades = [select Name,Revisada__c,Revisado_Oferta__c from Propiedad__c where Revisada__c = true and Revisado_Oferta__c ='No Revisado'];
  propiedades2 = [select Name,Revisada__c,Revisado_Oferta__c from Propiedad__c where Revisada__c = false and Revisado_Oferta__c ='Revisado'];
  CargaOferta = [select Name,CreatedDate,Oferta_Cargada__c from Oferta__c where Documentos__r.Name ='Comprobante de anticipo' and Documentos__r.Cerrado__c= true and Documentos__r.NumFiles_MasFilesPadre__c != 0.00
                 and Estatus__c !='Descartada' and FechaCobro__c = NULL and FechaPago__c != NULL and Oferta_Cargada__c = false];
  CargaOferta2 = [select Name,CreatedDate,Oferta_Cargada__c from Oferta__c where Documentos__r.Name ='Comprobante de anticipo' and Documentos__r.Cerrado__c= false and Documentos__r.NumFiles_MasFilesPadre__c != 0.00
                 and Estatus__c !='Descartada' and FechaCobro__c = NULL and FechaPago__c != NULL and Oferta_Cargada__c = true];                
}
 public void save()
 {
 
 update propiedades;
 update propiedades2;
 update CargaOferta;
 update CargaOferta2;
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
        
        }
}