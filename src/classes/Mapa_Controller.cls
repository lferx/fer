public with sharing class Mapa_Controller {
	public List<ColoniaFraccionamiento__c> colonias {get;set;}
	public integer index {get;set;}
	public Decimal plat {get;set;}
    public Decimal plng {get;set;}
    public integer total {get;set;}

	public Mapa_Controller() {
		index = 0;
		colonias = [SELECT Id,Name,Punto__Latitude__s,Punto__Longitude__s FROM ColoniaFraccionamiento__c];
		total = colonias.size();
		system.debug('colonias: '+colonias);
		revisarCoordenadas();
	}

	public void next(){
		index ++;
		if(index > total-1){
			index = 0;
		}
		revisarCoordenadas();
	}
	public void previous(){
		index --;
		if(index < 0){
			index = total-1;
		}
		revisarCoordenadas();
	}
	public void revisarCoordenadas(){
		//Zocalo del DF
        plat = 19.432632;
        plng = -99.133298;
		if(colonias.get(index).Punto__Latitude__s != null){
			plat = colonias.get(index).Punto__Latitude__s;
		}
		if(colonias.get(index).Punto__Longitude__s != null){
			plng = colonias.get(index).Punto__Longitude__s;
		}
	}
}