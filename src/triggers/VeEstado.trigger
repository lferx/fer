trigger VeEstado on Oferta__c (after update) {  

    for (Oferta__c c:Trigger.new)
    {
        if (c.Estado__c!=null){
integer i=[select count() from oferta__c where FechaCobro__c != null AND Estado__c =:c.Estado__c];
Estados__c l=[select id, vendidas__c, Propiedades_Disponibles__c from Estados__c where id=:c.Estado__c];
l.vendidas__c=i;
 
integer d=[SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 
               AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null 
               AND ((Etapa__c IN ('Compilación expediente compra','Compra final',
                                  'Escrituras en proceso registro','Compilación expediente cliente')) 
                                OR (Etapa__c IN ('Rehabilitación') AND Invadida__c = true))
                                    AND Estado__c =:c.Estado__c ];
l.Propiedades_Disponibles__c=d;       
update l; 
    }
}
}