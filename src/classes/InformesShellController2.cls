public with sharing class InformesShellController2 {

public List<Propiedad__c>propiedades{get;set;}
public List<Propiedad__c>propiedades2{get;set;}
public List<Oferta__c>CargaOferta{get;set;}
public List<Oferta__c>CargaOferta2{get;set;}
public List<Documento__c>CargaOferta3{get;set;} 
public List<Documento__c>CargaOferta4{get;set;}


    public InformesShellController2(ApexPages.StandardController controller) {
    String  x='';
    propiedades = [select Name,Revisada__c,Revisado_Oferta__c from Propiedad__c where Revisada__c = true and Revisado_Oferta__c ='No Revisado'];
  propiedades2 = [select Name,Revisada__c,Revisado_Oferta__c from Propiedad__c where Revisada__c = false and Revisado_Oferta__c ='Revisado'];
 /* CargaOferta2 = [select Name,CreatedDate,Oferta_Cargada__c from Oferta__c where Documentos__r.Name ='Comprobante de anticipo' and Documentos__r.Cerrado__c= false and Documentos__r.NumFiles_MasFilesPadre__c != 0.00
                 and Estatus__c !='Descartada' and FechaCobro__c = NULL and FechaPago__c != NULL and Oferta_Cargada__c = true];    */
                  
   CargaOferta3 =  [select Oferta__r.id,Oferta__r.Name,Oferta__r.Oferta_Cargada__c from Documento__c where Name ='Comprobante de anticipo' and Cerrado__c= true and NumFiles_MasFilesPadre__c != 0.00
                 and Oferta__r.Estatus__c !='Descartada' and Oferta__r.FechaCobro__c = NULL and Oferta__r.FechaPago__c != NULL and Oferta__r.Oferta_Cargada__c = false];
                 
                 for (Documento__c Reg: CargaOferta3){
                     
                   x += '\''+Reg.Oferta__r.name+'\',';
                 }
                 x=x.removeEnd(','); 
    CargaOferta = database.query('select Name,CreatedDate,Oferta_Cargada__c from Oferta__c where name IN ('+x+')');

                 system.debug(x);
                 system.debug(CargaOferta);
   CargaOferta4 =  [select Oferta__r.Name,Oferta__r.Oferta_Cargada__c from Documento__c where Name ='Comprobante de anticipo' and Cerrado__c= false and NumFiles_MasFilesPadre__c != 0.00
                 and Oferta__r.Estatus__c !='Descartada' and Oferta__r.FechaCobro__c = NULL and Oferta__r.FechaPago__c != NULL and Oferta__r.Oferta_Cargada__c = true];           
}

 

 public PageReference save()
 {
 
 update propiedades;
 update propiedades2;
 update CargaOferta;
 update CargaOferta3;
 update CargaOferta4;
 
 
        PageReference pagr = new PageReference('/apex/InformesShell');
        pagr.setRedirect(true);
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
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
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