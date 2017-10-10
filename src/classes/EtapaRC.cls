Public with sharing class EtapaRC
{

   Public list<Decimal> lrutac {get;set;}
   Public list<Etapa__c> lerc {get;set;}
   Public list<wEtapas> lwetapas {get;set;}
   Public string sRutaC {get;set;}
   
  

   private final Etapa__c et;
    
    
    public EtapaRC(ApexPages.StandardSetController stdsController) {
       CargaEtapas();   
    }

   public void CargaEtapas()
   {
      lerc = [SELECT Id, Name, EstatusOferta__c, NumEtapa__c, Activa__c FROM Etapa__c WHERE Activa__c =: true AND (EstatusOferta__c =: 'Compra' OR EstatusOferta__c =: 'Venta') ORDER BY EstatusOferta__c, NumEtapa__c];
      system.debug('Aquí lerc........' + lerc);
      lwetapas = new list<WEtapas>();
      for (Etapa__c ec :lerc)
      {
        lwetapas.add(new wEtapas(ec));
      } 
      
   }
   
   Public void calculaRC()
   {
      for (wEtapas wec :lwetapas)
      {
         if (wec.etapaselect == true) 
         {
            lrutac = new list<Decimal>(); 
            lrutac = wsUtility.CriticalPath(wec.etapa.Id);
            if (lrutac != null)
            {
               sRutaC = '';
               for (Decimal dpaso :lrutac)
               {
                   sRutaC = string.valueOf(dpaso) + '-->' + sRutaC ;
               } 
               sRutaC = sRutaC.removeEnd('-->');
               system.debug(sRutaC);
            }else 
            {
               sRutaC = 'Error al generar Ruta Crítica de la Etapa ' + wec.etapa.NumEtapa__c + ' ' + wec.etapa.Name;
            }
         }
      }
   }
   Public class wEtapas
   {
      Public Etapa__c etapa {get;set;}
      Public Boolean etapaselect {get;set;}
      Public wEtapas(Etapa__c etapa)
      {
          this.etapa = etapa;
          etapaselect = false;
      }
      
   } 
}