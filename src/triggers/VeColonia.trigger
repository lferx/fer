trigger VeColonia on Oferta__c (after update) {
    for (Oferta__c c:Trigger.new)
    {
        if (c.Colonia_busqueda__c!=null){
integer i=[select count() from oferta__c where FechaCobro__c != null AND Colonia_busqueda__c =:c.Colonia_busqueda__c];
ColoniaFraccionamiento__c l=[select id, vendidas__c, Propiedades_Disponibles__c from ColoniaFraccionamiento__c where id=:c.Colonia_busqueda__c];
l.vendidas__c=i;
 
integer d=[SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 
               AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null 
               AND ((Etapa__c IN ('Compilación expediente compra','Compra final',
                                  'Escrituras en proceso registro','Compilación expediente cliente')) 
                                OR (Etapa__c IN ('Rehabilitación') AND Invadida__c = true))
                                    AND Colonia_busqueda__c =:c.Colonia_busqueda__c ];
l.Propiedades_Disponibles__c=d;       
update l; 
    }
}
}