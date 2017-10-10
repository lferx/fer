trigger VendidasDisponiblesEstado on Estados__c (after update) {
        for (Estados__c c:Trigger.new)
    {
integer i=[select count() from oferta__c where FechaCobro__c != null AND Estado__c=:c.id];
c.vendidas__c=i;
integer d=[SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 
               AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null 
               AND ((Etapa__c IN ('Compilación expediente compra','Compra final',
                                  'Escrituras en proceso registro','Compilación expediente cliente')) 
                                  OR (Etapa__c IN ('Rehabilitación') AND Invadida__c = true))
                                  AND Estado__c=:c.id ];
               c.Propiedades_disponibles__c=d;            
}

}