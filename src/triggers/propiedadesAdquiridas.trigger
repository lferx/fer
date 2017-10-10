trigger propiedadesAdquiridas on Oferta__c (after update) {


    List<Account> listaCuenta = [SELECT id, name, Propiedades_Adquiridas__c, phone, Email__c FROM Account];
    Map<ID,Account> mapaCuentas = new Map<ID,Account>();
    //Map<ID,Oferta__c> mapaOfertas = new Map<ID,Oferta__c>();


    for(Account cuenta: listaCuenta){

        mapaCuentas.put(cuenta.id,cuenta);

    }

    for(Oferta__c oferta:Trigger.new){

        //mapaOfertas.put(oferta.id,oferta);
        Oferta__c oldOfer=trigger.oldMap.get(oferta.id);

        if(mapaCuentas.containsKey(oferta.ClienteFinal__c) && oldOfer.ClienteFinal__c != oferta.ClienteFinal__c){
            mapaCuentas.get(oferta.ClienteFinal__c).Propiedades_Adquiridas__c++;
        }

    }

    for(ID regId: mapaCuentas.keySet()){
        if(mapaCuentas.get(regId).phone == null && mapaCuentas.get(regId).Email__c == NULL){
            mapaCuentas.remove(regId);
        }
    }

    update mapaCuentas.values();
    //for(ID regId : mapaOfertas.keySet()){

    //  if(mapaOfertas.get(regId).ClienteFinal__c == ''){

    //  }
    //}

}