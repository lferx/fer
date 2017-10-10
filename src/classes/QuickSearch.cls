global with sharing class QuickSearch {
    
    global  QuickSearch(ApexPages.StandardController stdController) {
        
    }
    
    public QuickSearch(ConsolaController cs){
        
    }
    
    public QuickSearch(MapaPropiedadesController mapaPropiedadesController) {
        
    }
    
    global class Pair {
        public String key {get; private set;}
        public String value {get; private set;}
        
        public Pair(String key, String value) {
            this.key = key;
            this.value = value;
        }
    }
    
    @RemoteAction
    global static List<Pair> searchAccount(String word, String tipoCuenta, String filtros) {
        List<Pair> resultsObj = new List<Pair>();
        if(word != null && word.length() >=2){
            word = '\'*' + word + '*\'';
            String query = 'FIND '+ word +' IN ALL FIELDS RETURNING Account(Id, Name WHERE Type = \'' + tipoCuenta +'\' '+  filtros + ' ORDER BY Name ASC)';
            system.debug('QuerySOSL: ' + query);
            List<List<SObject>> searchResults = search.query(query);
            for(SOBject record : searchResults[0]) {
                if(record != null) {
                    Account objeto = (Account)record;
                    resultsObj.add(new Pair(objeto.Id, objeto.Name));
                }
            }
        }else{
            String query = 'Select Id, Name From Account Where Type = \'' + tipoCuenta + '\' ' + filtros;
            for(Account cuenta : Database.query(query)) {
                resultsObj.add(new Pair(cuenta.Id, cuenta.Name));
            }
        }
        return resultsObj;
    }
    
    global class ObjectCP {
        public String label {get; private set;}
        public String value {get; private set;}
        public String colonia {get; private set;}
        public String municipio {get; private set;}
        public String estado {get; private set;}
        
        global ObjectCP(String label, String value, String colonia, String municipio, String estado) {
            this.label = label;
            this.value = value;
            this.colonia = colonia;
            this.municipio = municipio;
            this.estado = estado;
        }
    }
    
    @RemoteAction
    global static List<ObjectCP> searchCodigoPostal(String word, String estado) {
        if(word != null) {
            if(estado!=null && estado!=''){
                word = '' + word + '* AND ' + estado + '*';
            }else{
                word = '' + word + '*';
            }
            List<List<SObject>> searchResults = [FIND :word IN ALL FIELDS RETURNING CodigoPostal__c(Id, Name, CP__c, Colonia__c, Municipio__c, Estado__c)];
            List<ObjectCP> resultsObj = new List<ObjectCP>();
            System.debug(searchResults);
            for(SOBject record : searchResults[0]) {
                if(record != null) {
                    CodigoPostal__c codigosPostales = (CodigoPostal__c)record;
                    resultsObj.add(new ObjectCP(codigosPostales.Name, codigosPostales.Id, codigosPostales.Colonia__c, codigosPostales.Municipio__c, codigosPostales.Estado__c));
                }
            }
            return resultsObj;
        }
        return null;
    }
    
    static testmethod void test() {
        QuickSearch qs = new QuickSearch(new ApexPages.StandardController(new Case()));
        //QuickSearch.searchAccount('06500');
    }
}