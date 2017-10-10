trigger LeadWebTrigger on Lead (before update ,after update,after insert,before insert,before delete) {
	// Juan.Loyola :: Clase contenedora de los metodos del trigger
	TriggerClassLead triggerClass = new TriggerClassLead();

    // Juan.Loyola :: Bloque de ejecuciones Before
    
    // Insert
    if(Trigger.isBefore && Trigger.isInsert){
    	triggerClass.LigarPromotor(Trigger.new );
    	triggerClass.asignarGerente( Trigger.new );
    }
    
    // Udate
    if(Trigger.isBefore && Trigger.isUpdate){
    	//triggerClass.LigarPropiedades( Trigger.new );
    	triggerClass.LigarPromotor( Trigger.new );
    	triggerClass.asignarGerente( Trigger.new );
    }
    
    // Delete
    if(Trigger.isBefore && Trigger.isDelete){
    	triggerClass.eliminarPropiedadesDelLead( Trigger.oldMap );
    }
    
    // Juan.Loyola :: Bloque de ejecucion After 
    
    // Insert
    if(Trigger.isAfter && Trigger.isInsert){
    	triggerClass.LigarPropiedades( Trigger.new );
    	triggerClass.insertarInteresados(Trigger.new );
    }
    
    // Update
    if(Trigger.isAfter && Trigger.isUpdate){
    	triggerClass.LigarPropiedadesUpdate( Trigger.oldMap, Trigger.newMap );
    	triggerClass.asignarBoletos(Trigger.oldMap, Trigger.newMap);
    }
    
    
    
    
    
    
}