trigger veCiudad on Oferta__c (after update) {

    for (Oferta__c c:Trigger.new)
    {
                if (c.Ciudad_tabla__c !=null){
integer i=[select count() from oferta__c where FechaCobro__c != null AND Ciudad_tabla__c =:c.Ciudad_tabla__c];

    Ciudad__c l=[select id, Propiedades_Disponibles__c,Propiedades_vendidas__c from Ciudad__c where id=:c.Ciudad_tabla__c];
 l.Propiedades_vendidas__c=i;
 
integer d=[SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 
               AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null 
               AND ((Etapa__c IN ('Compilación expediente compra','Compra final',
                                  'Escrituras en proceso registro','Compilación expediente cliente')) 
                                OR (Etapa__c IN ('Rehabilitación') AND Invadida__c = true))
                                    AND Ciudad_tabla__c =:c.Ciudad_tabla__c];
l.Propiedades_Disponibles__c=d;       
                    update l; }
    }

}