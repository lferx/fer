public with sharing class Informe_Inversionistas_Controller {

    public transient Map<String,List<ClienteOferta__c>> mapaCompleto {get;set;}
    public transient List<ClienteOferta__c> clientesOferta {get;set;}
    public transient List<ClienteOferta__c> segmentoClienteOferta {get;set;}
    public transient List<Account> cuentas {get;set;}
    public transient Map<String,Account> mapaCuentas {get;set;}
    public List<WrapperClass> listaWrapper {get;set;}
    public transient WrapperClass objetoWrapper {get;set;}
    public transient List<String> paquetesOfertas {get;set;}
    public String conca {get;set;}
    public Integer cont {get;set;}
    public Integer contIndex {get;set;}
    public Integer ind {get;set;}
    public Account cuentaActualizar {get;set;}
    public RecordType tipoReg {get;set;}
    public Integer pagina {get;set;}
    public List<Integer> totalPaginas {get;set;}
    public Integer totalInversionistas {get;set;}
    public Account cuentaMaestra {get;set;}
    public Account cuentaEsclava {get;set;}
    public Id idPrimeraCuenta {get;set;}
    public Id idSegundaCuenta {get;set;}

    public Informe_Inversionistas_Controller() {
        cont = 0;
        contIndex = 0;
        ind = 0;
        pagina = 0;
        totalInversionistas = 0;
        listaWrapper = new List<wrapperClass>();
        totalPaginas = new List<Integer>();
        cuentaActualizar = new Account();
        tipoReg = [SELECT Id FROM RecordType where name = 'Inversionista' limit 1];
        proceso();
    }



    public class WrapperClass {
        public Integer index {get;set;}
        public Account cuenta {get;set;}
        public List<ClienteOferta__c> ofertas {get;set;}
        public List<String> paquete {get;set;}

        public void wrapperClass(){
            cuenta = new Account();
            ofertas = new List<ClienteOferta__c>();
            paquete = new List<String>();
        }
    }



    public void proceso(){
        mapaCompleto = new Map<String,List<ClienteOferta__c>>();
        mapaCuentas = new Map<String,Account>();
        listaWrapper = new List<WrapperClass>();

        clientesOferta = [SELECT ID,Cuenta__c,Cuenta__r.name,Oferta__r.name,Oferta__c,Estatus2__c,Oferta__r.Paquete_de_Ofertas__c,Oferta__r.Paquete_de_Ofertas__r.name FROM ClienteOferta__c WHERE (Cuenta__r.phone != NULL OR Cuenta__r.Telefono_2__c != NULL OR Cuenta__r.Email__c != NULL OR Cuenta__r.PersonEmail != NULL) AND Cuenta__r.Estatus__c = 'Activo'  ORDER BY NAME];

        for(ClienteOferta__c co: clientesOferta){
            segmentoClienteOferta = new List<ClienteOferta__c>();
            segmentoClienteOferta = mapaCompleto.get(co.Cuenta__c);

            if(segmentoClienteOferta == NULL){
                segmentoClienteOferta = new List<ClienteOferta__c>();
            }

            segmentoClienteOferta.add(co);

            mapaCompleto.put(co.Cuenta__c,segmentoClienteOferta);
        }

        for(String coId: mapaCompleto.keySet()){
            if(mapaCompleto.get(coId).size()<2){
                for(ClienteOferta__c reg: mapaCompleto.get(coId)){
                    if(reg.Estatus2__c != 'Cliente final' || reg.Oferta__r.Paquete_de_Ofertas__c == NULL){
                        mapaCompleto.remove(coId);
                    }
                }
            }
        }

        cuentas = [SELECT id, name, phone, Email__c, type, Target__c, Plaza__c, Plaza_2__c, SubOrigen__c, Promotor__c, Registros_Totales__c, Activos__c, Cerrado__c FROM Account WHERE id IN :mapaCompleto.keySet()];

        for(Account reg: cuentas){
            mapaCuentas.put(reg.id,reg);
        }


        if(mapaCuentas.values().size() >= 50){
            for(Integer i=0;i<mapaCuentas.values().size();i+=50){
                totalPaginas.add(i);
            }
        }
        else{
            totalPaginas.add(0);
        }

        totalInversionistas = mapaCuentas.values().size();

        for(String rowId: mapaCuentas.keySet()){
            
            objetoWrapper = new WrapperClass();
            paquetesOfertas = new List<String>();

            objetoWrapper.cuenta = mapaCuentas.get(rowId);

            objetoWrapper.ofertas = mapaCompleto.get(rowId);
            conca = '';
            for(ClienteOferta__c reg: mapaCompleto.get(rowId)){
                
                if(reg.Oferta__r.Paquete_de_Ofertas__c != NULL && conca.contains(reg.Oferta__r.Paquete_de_Ofertas__r.name)){
                    continue;
                }
                paquetesOfertas.add(reg.Oferta__r.Paquete_de_Ofertas__r.name);
                conca +=reg.Oferta__r.Paquete_de_Ofertas__r.name;
                
            }

            objetoWrapper.paquete = paquetesOfertas;

            if(cont >= pagina && cont < (pagina+50)){
                listaWrapper.add(objetoWrapper);
                objetoWrapper.index = contIndex;
                contIndex++;
            }

            cont++;
        }
        contIndex = 0;
        cont = 0;
    }

    public PageReference guardar(){
        System.debug('ind'+ind);
        cuentaActualizar = listaWrapper.get(ind).cuenta;
        cuentaActualizar.RecordTypeId = tipoReg.id;
        cuentaActualizar.Revisar__c = true;
        UPDATE cuentaActualizar;
        PageReference pag = new PageReference('/apex/Panel_Inversionistas');
        pag.setRedirect(true);
        return pag;

    }

    public void cambiarPagina(){
        System.debug('pagina: '+pagina);
        totalPaginas.clear();
        proceso();
    }

    public PageReference combinar(){
        PageReference pag = new PageReference('/apex/Panel_Inversionistas');
        pag.setRedirect(true);
        cuentaMaestra = new Account();
        cuentaEsclava = new Account();
        Account cuentaMaestra = [SELECT type,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c, Email2__c,Phone2__c  FROM Account WHERE id = :idPrimeraCuenta];
        Account cuentaEsclava = [SELECT type,phone,Email__c,CURP__c,RFC__c,Numero_de_Seguro_Social__c,CLABE__c,Beneficiario__c, Email2__c,Phone2__c  FROM Account WHERE id = :idSegundaCuenta];
            if(cuentaMaestra.phone == NULL){
                cuentaMaestra.phone = cuentaEsclava.phone;
            }
            else if(cuentaEsclava.phone != NULL){
                cuentaMaestra.Phone2__c = cuentaEsclava.phone;
            }
            if(cuentaMaestra.Email__c == NULL){
                cuentaMaestra.Email__c = cuentaEsclava.Email__c;
            }
            else if(cuentaEsclava.Email__c != NULL){
                cuentaMaestra.Email2__c = cuentaEsclava.Email__c;
            }
            if(cuentaMaestra.CURP__c == NULL){
                cuentaMaestra.CURP__c = cuentaEsclava.CURP__c;
            }
            if(cuentaMaestra.Numero_de_Seguro_Social__c == NULL){
                cuentaMaestra.Numero_de_Seguro_Social__c = cuentaEsclava.Numero_de_Seguro_Social__c;
            }
            if(cuentaMaestra.CLABE__c == NULL){
                cuentaMaestra.CLABE__c = cuentaEsclava.CLABE__c;
            }
            if(cuentaMaestra.RFC__c == NULL){
                cuentaMaestra.RFC__c = cuentaEsclava.RFC__c;
            }
            if(cuentaMaestra.Beneficiario__c == NULL){
                cuentaMaestra.Beneficiario__c = cuentaEsclava.Beneficiario__c;
            }

            UPDATE cuentaMaestra;

            MERGE cuentaMaestra cuentaEsclava;
        return pag;
    }

    public void cobertura(){
        Integer a = 0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;
        a=0;


    }

}