global with sharing class UtilidadMenuRapido {

    public static final String SEMAFORO_ROJO = 'Rojo';
    public static final String SEMAFORO_AMARILLO = 'Amarillo';
    public static final String SEMAFORO_VERDE = 'Verde';

	public UtilidadMenuRapido() {}


	public static Estado_Menu_Rapido__c crearEstado() {
        return new Estado_Menu_Rapido__c (
            Semaforo_Autorizacion__c = SEMAFORO_ROJO,
            Semaforo_Carrito__c = SEMAFORO_ROJO,
            Semaforo_Cita__c = SEMAFORO_ROJO,
            Semaforo_Datos_Iniciales__c = SEMAFORO_ROJO,
            Semaforo_Precalificacion__c = SEMAFORO_ROJO,
            Semaforo_Stock__c = SEMAFORO_ROJO
        );
	}


	public static Estado_Menu_Rapido__c obtenerEstado(Id idCuenta) {
        Estado_Menu_Rapido__c estadoMenuRapido = null;

        if (idCuenta != null) {
            // Obtener el registro de Estado del Menu Rapido (si no existe, se debe crear)
            for (Estado_Menu_Rapido__c e : [
                SELECT Id, Cuenta__c, Semaforo_Autorizacion__c, Semaforo_Carrito__c, Semaforo_Cita__c,
                    Semaforo_Datos_Iniciales__c, Semaforo_Precalificacion__c, Semaforo_Stock__c
                FROM Estado_Menu_Rapido__c WHERE Cuenta__c = :idCuenta
                ORDER BY CreatedDate
            ]) {
                estadoMenuRapido = e;
                break;
            }
        }

        if (estadoMenuRapido == null) {
            estadoMenuRapido = crearEstado();
        }

        return estadoMenuRapido;
	}


	public static Estado_Menu_Rapido__c guardarEstado(Estado_Menu_Rapido__c e) {
		if (e.Id == null && e.Cuenta__c != null) {
			insert e;
		} else if (e.Id != null) {
			update e;
		}
		return e;
	}
}