public with sharing class Carteo_Inbound_Controller {

    public String folio {get;set;}
    public List<String> listaFolios {get;set;}
    public List<Oferta__c> listObjetoOferta {get;set;}
    public List<Oferta__c> listaOfertas {get;set;}
    public Integer posicion {get;set;}
    public String vuser {get;set;} 
    public String carta1 {get;set;}
    public String carta2 {get;set;}
    public String carta3 {get;set;}
    public Boolean call {get;set;}
    public String fotoUsuario {get;set;}

    public Carteo_Inbound_Controller(){
        User usuario = [Select SmallPhotoUrl From User where id = :Userinfo.getUserid()];
        fotoUsuario = usuario.SmallPhotoUrl;
        call = false;
        listObjetoOferta = new List<Oferta__c>();
        listaOfertas = new List<Oferta__c>();
        vuser = UserInfo.getFirstName()+' '+UserInfo.getLastName();
        carta1 = ApexPages.currentPage().getParameters().get('carta1');
        carta2 = ApexPages.currentPage().getParameters().get('carta2');
        carta3 = ApexPages.currentPage().getParameters().get('carta3');
        System.debug('Carta1: '+ carta1);
        if(carta1 != null){
            if(carta1.trim() == 'true'){
                call = true;
            }
        }
        if(carta2 != null){
            if(carta2 == 'true'){
                call = true;
            }
        }
        if(carta3 != null){
            if(carta3 == 'true'){
                call = true;
            }
        }
        
        if(call){
            folio = ApexPages.currentPage().getParameters().get('idOferta').trim();
            llenaLista();
        }
        System.debug('folio: '+ folio);
        System.debug('listaOfertas: '+ listaOfertas);
    }
    
    public void llenaLista(){
        listaFolios = new List<String>();
        listObjetoOferta = new List<Oferta__c>();
        
        if(folio != NULL){
            folio.toUpperCase();
            folio=folio.trim();
            listaFolios = folio.split('\n');
        }
        
        if(folio != NULL){
            listObjetoOferta = Database.query('SELECT name, ValorReferencia__c, Plaza__c FROM Oferta__c WHERE name =:listaFolios');   
        }
        
        if(listObjetoOferta != NULL){
            listaOfertas.addAll(listObjetoOferta);
        }
        
    
    }
    
    public void limpiaLista(){
        listaOfertas.clear();
    }
    
    public void eliminar(){
        if(listaOfertas != NULL && posicion != NULL){
            listaOfertas.remove(posicion);
        }
    }
    
    public PageReference pdf1 (){
        PageReference pag = Page.Carta_Inbound_1;
        pag.setRedirect(false);
        return pag;
    }
    
    public PageReference pdf2 (){
        PageReference pag = Page.Carta_Inbound_2;
        pag.setRedirect(false);
        return pag;
    }
    public PageReference pdf3 (){
        PageReference pag = Page.Carta_Inbound_3;
        pag.setRedirect(false);
        return pag;
    }
    
}