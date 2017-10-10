public with sharing class BorrarFotos {
	public BorrarFotos() {
		List<Document> imagenes = [Select Id from Document where folder.DeveloperName = 'Imagenes_de_Propiedades'];
		if(imagenes != null && imagenes.size() > 0){
			try{
				System.debug('Encontro imagenes para borrar: '+imagenes.size());
			    delete imagenes;
			    System.debug('Se borraron correctamente las imagenes: '+imagenes.size());
			}catch(exception e){
				System.debug('No se pudieron borrar las imagenes');
			}
		}else{
		    System.debug('No se encontraron imagenes');
		}
	}
}