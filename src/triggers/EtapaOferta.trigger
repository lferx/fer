trigger EtapaOferta on EtapaOferta__c (after update, before insert, before update) {
    TriggerTemplate.getHandler().execute();
    
    if(trigger.isBefore && trigger.isUpdate){
        for(EtapaOferta__c e : trigger.new){
            if(e.Estatus__c != trigger.oldMap.get(e.Id).Estatus__c && e.Estatus__c == 'Cerrada'){
                e.HoraFinal__c = Datetime.now();
            }
            if(e.Etapa__c != null && e.HoraInicial__c != null && mEtapas.get(e.Etapa__c).MaximoAmarllo__c != null){
                e.FechaCierre__c = e.HoraInicial__c.date().addDays(Integer.valueOf(mEtapas.get(e.Etapa__c).MaximoAmarllo__c));
            }
        }
    }
    
    if(trigger.isBefore && trigger.isInsert){
        for(EtapaOferta__c e : trigger.new){
            if(e.Etapa__c != null && e.HoraInicial__c != null && mEtapas.get(e.Etapa__c).MaximoAmarllo__c != null){
                e.FechaCierre__c = e.HoraInicial__c.date().addDays(Integer.valueOf(mEtapas.get(e.Etapa__c).MaximoAmarllo__c));
            }
            if(mEtapas.get(e.Etapa__c).Usuario__c != null){
                e.OwnerId = mEtapas.get(e.Etapa__c).Usuario__c;  
            }
        }
    }
    
    
    private static Map<String, Etapa__c> mEtapas{
        get{
            if(mEtapas == null){
                mEtapas = new Map<String, Etapa__c>([Select Id, Name, EstatusOferta__c, MaximoAmarllo__c, MaximoRojo__c, Usuario__c From Etapa__c]);
            }
            return mEtapas;
        }set;
    }
    
}