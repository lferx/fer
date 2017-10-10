@RestResource(urlMapping='/ProspectoSorteoAlta/*')
global without sharing class RESTProspectoSorteoController {
    
    @HttpPost
    global static Integer alta(String nombreCompleto, String numeroDeSeguroSocial, String fechaDeNacimiento, String correoElectronico, String telefono, String domicilio, Double credito) {
        Integer cantidadBoletos = 0;
        
        // Validaciones para entrar
        if (numeroDeSeguroSocial != null && numeroDeSeguroSocial != '') {
            // Por default todos traen 1 boleto
            cantidadBoletos = 1;
            
            try {
                // Buscamos si ya tiene venta
                List<AggregateResult> lista = new List<AggregateResult>();
                lista = [SELECT ClienteFinal__c
                           FROM Oferta__c 
                          WHERE Estatus__c IN ('Cobrada','Firmada')
                            AND ClienteFinal__c != null
                            AND ClienteFinal__r.Numero_de_Seguro_Social__c != null
                            AND ClienteFinal__r.Numero_de_Seguro_Social__c =: numeroDeSeguroSocial
                       GROUP BY ClienteFinal__c
                       ORDER BY MAX(ClienteFinal__r.Name)
                          LIMIT 1];
                          
                /*
                    SELECT Id, Name, (SELECT Id, Name, Phone from CONTACTS) 
                      FROM ACCOUNT 
                     WHERE Id IN (SELECT ClienteFinal__c 
                                    FROM Oferta__c 
                                   WHERE ClienteFinal__c != null 
                                     AND Estatus__c IN ('Cobrada','Firmada')) 
                                ORDER BY Name
                */

                // Si encontró registros, asignamos 10 boletos
                if (lista.size() > 0) {
                    cantidadBoletos = 10;
                }
    
                // Upsert al registro
                Prospecto_Sorteo__c ps = new Prospecto_Sorteo__c();
                ps.Nombre_Completo__c = nombreCompleto;
                ps.Numero_de_Seguro_Social__c = numeroDeSeguroSocial;
                ps.Fecha_de_Nacimiento__c = fechaDeNacimiento;
                ps.Correo_Electronico__c = correoElectronico;
                ps.Telefono__c = telefono;
                ps.Cantidad_Boletos__c = cantidadBoletos;
                ps.Domicilio__c = domicilio;
                ps.Credito__c = credito;
                upsert ps Numero_de_Seguro_Social__c;
                
            } catch(Exception error) { System.debug('Error al dar de alta el Prospecto Sorteo ' + error); }
        }

        return cantidadBoletos;
    }
    
}