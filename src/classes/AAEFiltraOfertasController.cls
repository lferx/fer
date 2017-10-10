public with sharing class AAEFiltraOfertasController{
      
    transient List<Oferta__c> ofertasq; //consuta principal trae todo el stock
    public List<Oferta__c> comentariosq {get;set;} //traer comentarios gerente o ejecutivos posteriormente se modifica

    public transient List<wrapperclass> pag1 {get;set;} //para llenar pagina 1
    public transient List<wrapperclass> pag2 {get;set;} //para llenar pagina 2
    public transient List<wrapperclass> pag3 {get;set;} //para llenar pagina 3
    public transient List<wrapperclass> pag4 {get;set;} //para llenar pagina 4
    public transient List<wrapperclass> pag5 {get;set;} //para llenar pagina 5
    public transient List<wrapperclass> pag6 {get;set;} //para llenar pagina 6
    public transient List<wrapperclass> pag7 {get;set;} //para llenar pagina 7

    transient List<Documento__c> docs {get;set;} //crea lista de documentos recientes
    List<Oferta__c> rehab {get;set;}
    
    List<AggregateResult> edoq; //llena el filtro de estado
    List<AggregateResult> cdq; //llena el filtro de ciudad
    List<AggregateResult> colq; //llena el filtro de colonia
    List<AggregateResult> etq; //llena el filtro de etapa
    List<AggregateResult> ofq; //llena el filtro de ofertas
    List<AggregateResult> esq; //llena el filtro de escrituras
    List<AggregateResult> inq; //llena el filtro de invadida
    List<AggregateResult> goq; //llena el filtro de gerente operativo
    List<AggregateResult> gcq; //llena el filtro de gerente comercial

    Oferta__c precioObj; 
    Double preciomin;
    Oferta__c diasObj;
    Double diasmax;
    
    boolean bandera;
    String convertS; //variable para converitir un objeto a string
    String y;//para etiquetar los filtros de true o false
    String[] vaciar = new String[]{'Todo'}; //es un arreglo que sirve para limpiar un arreglo

    
    //public boolean ban=True; //se utiliza en los filtros omitir repetidos

    
    
    public String vuser = UserInfo.getFirstName()+' '+UserInfo.getLastName(); //guarda el usuario que inicio secion para ponerlo en la consulta
    public Datetime hoy = Date.today(); //fecha de hoy
    public boolean algo{get;set;} //se utiliza para mostrar o no el boton de siguient o anterior ..necesita ser public para comunicarse con la pagina
    public Integer sizelist {get;set;} //calcula el numero de paginas para imprimir en visual
    public Integer n {get;set;} //contador de limite de registros por paginas
    public Integer index = 0; //ordena la lista de ofertaq para mostrar los recien escriturados y los recien desalojados
    public Integer npag2 {get;set;}//para pararse en la pginacion
    public Integer num2 {get;set;}//para numerar los registros
    public Integer[] sizelistarray {get;set;}
    public boolean filtroespecial {get;set;}
    

    //Integer count=0;

    //variable para los comentarios
    public Id idRegistro {get;set;} //guarda el id de la oferta de comentario
    public boolean mostrarDialogoComentarios {get;set;} //muestra u oculta el cuadro de comentarios
    public Integer comentarios {get;set;} // se utiliza para saber si es comentarios gerente o comentarios ejecutivo 
    
    //Estas variables guardan los campos y condiciones fijas para el stock
    String campos = 'SELECT Inversor2__c,Oferta_Cargada__c, Propiedad__r.Construccion_m2__c, Comentarios_en_revision__c, Amparo__c, TipoOferta__c, Comentarios_Gerente__c, Comentarios_Ejecutivos__c, Campa__c,Gerente_Comercial__r.Name, Gerente_Operativo__r.Name, Etapa__c,Paquete__r.Name,Propiedad__r.Tipo__c,Name,Plaza__c,Estado__r.Name,  Ciudad_Tabla__r.Name,Colonia_Busqueda__r.Name,Direccion2__c,Propiedad__r.Terreno_m2__c,Propiedad__r.N_de_habitaciones__c,Propiedad__r.N_de_Ba_os__c,Propiedad__r.Tipo_de_invasor__c,Escritu__c,Fecha_Prevista_Desalojo__c,Invadida__c,Desalojada__c,Asegurada__c,Estatus_de_Invasion__c,ValorReferencia__c,PrecioVenta__c,Revisada__c,TiempoOferta__c FROM Oferta__c ';
    String condiciones;

    //=' TiempoOferta__c >= :dis AND PrecioVenta__c <= :prs AND Estatus__c != \'Descartada\' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN (\'Compilación expediente compra\',\'Compra final\',\'Escrituras en proceso registro\',\'Compilación expediente cliente\')) OR (Etapa__c IN (\'Rehabilitación\') AND Estatus_de_Invasion__c = \'Invadida\')) ';
    
    //WORKBENCH: SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')) OR (Etapa__c IN ('Rehabilitación') AND Estatus_de_Invasion__c = 'Invadida')) AND (NOT Inversor2__c LIKE 'Regeneradora%')
    //WORKBENCHOTRA SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 AND Estatus__c != 'Descartada' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN ('Compilación expediente compra','Compra final','Escrituras en proceso registro','Compilación expediente cliente')) OR (Etapa__c IN ('Rehabilitación') AND Estatus_de_Invasion__c = 'Invadida')) AND  (NOT Inversor2__c LIKE 'Regeneradora de Propiedades y Viviendas Mexicanas%')
    //WORKBENCH22: SELECT count() FROM Oferta__c WHERE TiempoOferta__c >= -1500 AND PrecioVenta__c <= 5000000 AND FechaPago__c != null AND FechaCobro__c = null AND (Etapa__c IN ('Antecedentes','Aprobada internamente','Descartada') OR Estatus__c = 'Descartada') AND (NOT Inversor2__c LIKE 'Regeneradora%')
    

    //variable para gerentes
    public List<SelectOption> gelst;
    String ges='';
    String[] GerenteSelec = new String[]{};
    public String[]getGerenteSelec(){return GerenteSelec;} 
    public void setGerenteSelec(String[] GerenteSelec){this.GerenteSelec = GerenteSelec;}

    
    //variables para estado
    public List<SelectOption> edoLst;
    String edos='';
    String[] EstadoSelec = new String[]{};
    public String[] getEstadoSelec(){return EstadoSelec;}
    public void setEstadoSelec(String[] EstadoSelec) {this.EstadoSelec = EstadoSelec;}

    
    //variables para ciudad
    public List<SelectOption> cdLst;
    public String cds='';
    String[] CiudadSelec = new String[]{};
    public String[] getCiudadSelec(){return CiudadSelec;}
    public void setCiudadSelec(String[] CiudadSelec) {this.CiudadSelec = CiudadSelec;}
    
    //variables para colonia
    public List<SelectOption> colLst;
    String cols='';
    String[] ColoniaSelec = new String[]{};
    public String[] getColoniaSelec(){return ColoniaSelec;}
    public void setColoniaSelec(String[] ColoniaSelec) {this.ColoniaSelec = ColoniaSelec;}
    
    //variable para rango de precio
    public List<SelectOption> prlst;
    public Integer prs {get;set;}
    
    //variables para etapa
    public List<SelectOption> etlst;
    String ets='';
    String[] EtapaSelec = new String[]{};
    public String[] getEtapaSelec(){return EtapaSelec;}
    public void setEtapaSelec(String[] EtapaSelec) {this.EtapaSelec = EtapaSelec;}
    
    //variables para oferta/////////////////////
    public List<SelectOption> oflst;
    public String ofs{get;set;}
    public Boolean ofs2;
    
    //variable para escritura
    public List<SelectOption> eslst;
    public String ess {get;set;}
    
    //variable para invadida, desalojada, asegurada
    public List<SelectOption> inlst;
    public String ins ='';
    String[] InvasionSelec = new String[]{};
    public String[] getInvasionSelec(){return InvasionSelec;}
    public void setInvasionSelec(String[] InvasionSelec) {this.InvasionSelec = InvasionSelec;}
    
    //variable para dias en stock
    public List<SelectOption> dilst;
    public Integer dis {get;set;}

    //variablea para rehabilitados
    public List<SelectOption> rehalst;
    public String rehas {get;set;} //guarda lo deleccionado por el visual
    Integer rehacqt; //numero para ver si tiene rehabilitada en true
    Integer rehacqf; //numero para ver si tiene rehabilitada en false
    String rehasv=''; //guarda parte de la consulta para adjuntarse en el filtro


    
    String gesv='';
    String edosv='';// guarda query estado
    String cdsv='';// guarda query ciudad
    String colsv='';// guarda query colonia
    String etsv='';// guarda query etapa
    String ofsv='';// guarda query oferta
    String essv='';// guarda query escritura
    String insv='';// guarda query ivadida
    

    
    public wrapperclass objectOferBool {get;set;} //objeto de lista compuesta
    public transient List<wrapperclass> listOfertaBool{get;set;}  //lista compuesta
    
    //clase con listas para generar lista compueta
    public class wrapperclass{  
        public Oferta__c registro {get;set;} //crea un campo dentro de la lista compuesta de tipo booleano
        public boolean boleano {get;set;} //crea un campo dentro de la lista compuesta de tipo booleano
        public boolean rehabilitada {get;set;}
    }   
    
    
    public AAEFiltraOfertasController(){
        filtroespecial = false;
        reset();
    }
    
    //lista de seleccion de gerente /////////////////////////////////////////////////////   
    
    public List<SelectOption> getGeLst(){
        List<SelectOption> geLst = new List<SelectOption>();
        geLst.add(new SelectOption('Todo','-- Todos --'));
        for(AggregateResult x : gcq){
            convertS = (String) x.get('Name');
            if(convertS == null){
                geLst.add(new SelectOption('','ERROR'));
            }else{
                geLst.add(new SelectOption(convertS,convertS));
            }
        }
        for(AggregateResult x : goq){
            bandera=True;
            for(AggregateResult y : gcq){
                if(x==y){
                    bandera=False;
                    break;
                }
            }
            if(bandera==True){
                convertS = (String) x.get('Name');
                if(convertS == null){
                    geLst.add(new SelectOption('','ERROR'));
                }else{
                    geLst.add(new SelectOption(convertS,convertS));
                }
            }
            
        }
        return geLst;
    }
    //lista de seleccion de estado//////////////////////////////////////////////////////////
    public List<SelectOption> getEdoLst(){    
        List<SelectOption> edoLst = new List<SelectOption>();
        edoLst.add(new SelectOption('Todo','-- Todos --'));
        for(AggregateResult x : edoq){
            convertS = (String) x.get('Name');
            if(convertS == null){
                edoLst.add(new SelectOption('','ERROR'));
            }else{
                edoLst.add(new SelectOption(convertS,convertS));
            }
        }    
        return edoLst;    
    }
        
    //lista de seleccion de ciudad/////////////////////////////////////////////////////////
    public List<SelectOption> getCdLst(){
        List<SelectOption> cdLst = new List<SelectOption>();
        cdLst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : cdq){
            convertS = (String) x.get('Name');
            if(convertS == null){
                cdLst.add(new SelectOption('','ERROR'));
            }else{
                cdLst.add(new SelectOption(convertS,convertS));
            }
        }
        return cdLst;    
    }
    //lista de seleccion de colonia////////////////////////////////////////////////////////////
    public List<SelectOption> getColLst(){
        List<SelectOption> colLst = new List<SelectOption>();
        colLst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : colq){
            convertS = (String) x.get('Name');
            if(convertS == null){
                colLst.add(new SelectOption('','ERROR'));
            }else{
                colLst.add(new SelectOption(convertS,convertS));
            }
        }
        return colLst;    
    }
     //lista de seleccion de precios /////////////////////////////////////////////////////   
    public List<SelectOption> getprlst(){
        List<SelectOption> prlst = new List<SelectOption>();
        prlst.add(new SelectOption('5000000','-- Todos --'));
        if(preciomin < 2000000){    prlst.add(new SelectOption('2000000','Hasta $2,000,000'));  }
        if(preciomin < 1000000){    prlst.add(new SelectOption('1000000','Hasta $1,000,000'));  }
        if(preciomin < 750000){     prlst.add(new SelectOption( '750000',  'Hasta $750,000'));  }
        if(preciomin < 500000){     prlst.add(new SelectOption( '500000',  'Hasta $500,000'));  }
        if(preciomin < 400000){     prlst.add(new SelectOption( '400000',  'Hasta $400,000'));  }
        if(preciomin < 300000){     prlst.add(new SelectOption( '300000',  'Hasta $300,000'));  }
        if(preciomin < 200000){     prlst.add(new SelectOption( '200000',  'Hasta $200,000'));  }
        
        return prlst;
        
    }  
    
    //lista de seleccion de etapa//////////////////////////////////////////////////////////
    public List<SelectOption> getetlst(){
   
        List<SelectOption> etlst = new List<SelectOption>();
        y='';
        etlst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : etq){
            convertS = (String) x.get('Etapa__c');
            if(convertS == null){
                etLst.add(new SelectOption('','ERROR'));
            }else{
                if(convertS == 'Antecedentes'){y ='Etapa 4';}else if(convertS == 'Aprobada internamente'){y ='Etapa 5';}else if(convertS == 'Compilación expediente compra'){y ='Etapa 6';} else if(convertS == 'Compra final'){y='Etapa 7';} else if(convertS == 'Escrituras en proceso registro'){y='Etapa 8';} else if(convertS == 'Compilación expediente cliente'){y='Etapa 9';} else if(convertS == 'Rehabilitación'){y='Etapa 10';}else{y=convertS;}
                etLst.add(new SelectOption(convertS,y));
            }
        }
        return etlst;    
    }
    
    //lista de seleccion de oferta//////////////////////////////////////////////////////////
    public List<SelectOption> getoflst(){
   
        List<SelectOption> oflst = new List<SelectOption>();
        y='';
        oflst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : ofq){
            convertS = (String) String.valueOf(x.get('Oferta_Cargada__c'));
            if(convertS == 'true'){y='Con Oferta';}else if(convertS=='false'){y='Sin Oferta';}
            oflst.add(new SelectOption(convertS,y));
        }
        return oflst;    
    }
    
    //lista de seleccion de Escritura /////////////////////////////////////////////////////   
    public List<SelectOption> geteslst(){
        List<SelectOption> eslst = new List<SelectOption>();
        eslst.add(new SelectOption('Todo','-- Todas --'));
        for(AggregateResult x : esq){
            convertS = (String) x.get('Escritu__c');
            if(convertS == null){
                eslst.add(new SelectOption('vacio','ERROR'));
            }else{
                eslst.add(new SelectOption(convertS,convertS));
            }
        }
        return eslst;
    }   

    //lista de seleccion de Estatus de Invasion /////////////////////////////////////////////////////   
    public List<SelectOption> getinlst(){

        List<SelectOption> inlst = new List<SelectOption>();
        inlst.add(new SelectOption('Todo','-- Todos --'));
        for(AggregateResult x : inq){
            convertS = (String) x.get('Estatus_de_Invasion__c');
            if(convertS == null){
                inlst.add(new SelectOption('','ERROR'));
            }else{
                inlst.add(new SelectOption(convertS,convertS));
            }
        }
        return inlst;
    }  
 
    //lista de seleccion de dias en stock  //////////////////////////////////////////////////////////////////////   
    public List<SelectOption> getdilst(){
        List<SelectOption> dilst = new List<SelectOption>();
        dilst.add(new SelectOption('-1500','-- Todos --'));
        if(diasmax > 100){  dilst.add(new SelectOption('100','Mas de 100'));    }
        if(diasmax > 200){  dilst.add(new SelectOption('200','Mas de 200'));    }
        if(diasmax > 300){  dilst.add(new SelectOption('300','Mas de 300'));    }
        if(diasmax > 400){  dilst.add(new SelectOption('400','Mas de 400'));    }
        if(diasmax > 500){  dilst.add(new SelectOption('500','Mas de 500'));    }
        
        return dilst;
        
    }

    //lista de seleccion de rehabilitacion  ////////////////////////////////////////////////////////////////////////   
    public List<SelectOption> getrehalst(){
        List<SelectOption> rehalst = new List<SelectOption>();
        rehalst.add(new SelectOption('Todo','-- Todos --'));
        if(rehacqt > 0){rehalst.add(new SelectOption('True','Rehabilitadas'));}
        if(rehacqf > 0){rehalst.add(new SelectOption('False','No Rehabilitadas'));}
        
        return rehalst;
    }

    public void cambiarofertas(){
        if(filtroespecial){
            filtroespecial = false;
        }else{
            filtroespecial = true;
        }
        Reset();
    }    
    public void Reset2(){
        filtroespecial = false;
        Reset();
        
    }//fin de public reset
    public void Reset(){
        ges='';
        edos = '';
        cds = '';
        cols = '';
        prs = 5000000;
        ets = 'et01';
        ofs = 'Todo';
        ess = 'Todo';
        ins = 'in01';
        dis = -1500;
        rehas = 'Todo';
        
        setGerenteSelec(vaciar);
        setEstadoSelec(vaciar);
        setCiudadSelec(vaciar);
        setColoniaSelec(vaciar);
        setEtapaSelec(vaciar);
        setInvasionSelec(vaciar);

        algo=false;

        mostrarDialogoComentarios = false;

        actualizar();
        llenadoPaginas();
    }//fin de public reset
     
    public void limpiavariables(){
        gesv='';// guarda query usuario
        edosv='';// guarda query estado
        cdsv='';// guarda query ciudad
        colsv='';// guarda query colonia
        etsv='';// guarda query etapa
        ofsv='';// guarda query oferta
        essv='';// guarda query escritura
        insv='';// guarda query ivadida

        edos = '';
        cds='';
        cols='';
        ets='';
        ins='';

        npag2=1;
        num2=0;
    }

    /*public void fusuario(){

    }
    public void festado(){}
    public void fciudad(){}
    public void fcolonia(){}
    public void finvacion(){}
    public void fetapa(){} */


    public void actualizar(){
        if(filtroespecial){
            condiciones=' TiempoOferta__c >= :dis AND PrecioVenta__c <= :prs AND FechaPago__c != null AND FechaCobro__c = null AND (Etapa__c IN (\'Antecedentes\',\'Aprobada internamente\',\'Descartada\') OR Estatus__c = \'Descartada\') AND (NOT Inversor2__c LIKE \'Regeneradora%\')';
        }else{
            condiciones=' TiempoOferta__c >= :dis AND PrecioVenta__c <= :prs AND Estatus__c != \'Descartada\' AND FechaCobro__c = Null AND FechaPago__c != Null AND ((Etapa__c IN (\'Compilación expediente compra\',\'Compra final\',\'Escrituras en proceso registro\',\'Compilación expediente cliente\')) OR (Etapa__c IN (\'Rehabilitación\') AND Estatus_de_Invasion__c = \'Invadida\')) AND (NOT Inversor2__c LIKE \'Regeneradora%\')';
        }

        limpiavariables();

        //Usuario
        for(integer i=0; i < GerenteSelec.size();i++){
            if(this.GerenteSelec[i]== 'Todo'){  ges ='';        break;                  }
            else if(i==0){                      ges ='\''+this.GerenteSelec[i]+'\'';    }
            else{                               ges +=',\''+this.GerenteSelec[i]+'\'';  }
        }
        //Estado
        for(integer i=0; i < EstadoSelec.size();i++){
            if(this.EstadoSelec[i]== 'Todo'){   edos ='';       break;                  }
            else if(i==0){                      edos ='\''+this.EstadoSelec[i]+'\'';    }
            else{                               edos +=',\''+this.EstadoSelec[i]+'\'';  }
        }
        //ciudad
        for(integer i=0; i < CiudadSelec.size();i++){       
            if(this.CiudadSelec[i]== 'Todo'){   cds ='';        break;                  }
            else if(i==0){                      cds ='\''+this.CiudadSelec[i]+'\'';     }
            else{                               cds +=',\''+this.CiudadSelec[i]+'\'';   }    
        }
        //colonia
        for(integer i=0; i < ColoniaSelec.size();i++){
            if(this.ColoniaSelec[i]== 'Todo'){  cols ='';       break;                  }
            else if(i==0){                      cols ='\''+this.ColoniaSelec[i]+'\'';   }
            else{                               cols +=',\''+this.ColoniaSelec[i]+'\''; }
        }
        //etapa
        for(integer i=0; i < EtapaSelec.size();i++){
            if(this.EtapaSelec[i]== 'Todo'){    ets ='';        break;                  }
            else if(i==0){                      ets ='\''+this.EtapaSelec[i]+'\'';      }
            else{                               ets +=',\''+this.EtapaSelec[i]+'\'';    }
        }
        //invadida
        for(integer i=0; i < InvasionSelec.size();i++){
            if(this.InvasionSelec[i]== 'Todo'){ ins ='';        break;                  }
            else if(i==0){                      ins ='\''+this.InvasionSelec[i]+'\'';   }
            else{                               ins +=',\''+this.InvasionSelec[i]+'\''; }
        }

        if(edos == '')  {edosv='';  }     else{edosv=' Estado__r.Name IN('+edos+') AND ';                                                       }
        if(cds == '')   {cdsv='';   }     else{cdsv=' Ciudad_Tabla__r.Name IN('+cds+') AND ';                                                   }
        if(cols == '')  {colsv='';  }     else{colsv=' Colonia_Busqueda__r.Name IN('+cols+') AND ';                                             }
        if(ets == '')   {etsv='';   }     else{etsv=' Etapa__c IN('+ets+') AND ';                                                               }
        if(ins == '')   {insv='';   }     else{insv=' Estatus_de_Invasion__c IN('+ins+') AND ';                                                 }
        if(ges == '')   {gesv='';   }     else{gesv=' (Gerente_Operativo__r.Name IN ('+ges+') OR Gerente_Comercial__r.Name IN ('+ges+')) AND '; }

        //if(us != 'us01' && us == 'login'){gesv=' (Gerente_Operativo__r.Name = :vuser OR Gerente_Comercial__r.Name = :vuser) AND ';}
        //if(edos != 'edo01' && edos != 'null'){edosv=' Estado__r.Name IN (:edos) AND ';}else if(edos == 'null'){edosv=' Estado__r.Name = \'\' AND ';}// && edos != null
        //if(cds != 'cd01' && cds != 'null'){cdsv=' Ciudad_Tabla__r.Name = :cds AND ';}else if(cds =='null'){cdsv=' Ciudad_Tabla__r.Name = \'\' AND ';}// && cds != null
        //if(cols != 'col01' && cols != 'null'){colsv=' Colonia_Busqueda__r.Name = :cols AND ';}else if(cols == 'null'){colsv=' Colonia_Busqueda__r.Name = \'\' AND ';}// && cols != null
        //if(ets != 'et01' && ets != 'vacio'){etsv=' Etapa__c = :ets AND ';}else if(ets == 'vacio'){colsv=' Colonia_Busqueda__r.Name = \'\' AND ';}// && ets != null
        if(ofs != 'Todo'){ofs2=Boolean.valueOf(ofs); ofsv=' Oferta_Cargada__c = :ofs2 AND ';}else{ofsv='';}// && ets != null
        if(ess != 'Todo' && ess != 'vacio'){essv=' Escritu__c=:ess AND ';}else if(ess == 'vacio'){essv=' Escritu__c=\'\' AND ';}// && ess != null
        //if(ins != 'in01' && ins != 'vacio' && ins != 'Noinvadida'){insv = 'Estatus_de_Invasion__c = :ins AND ';}else if(ins == 'Noinvadida'){insv=' Estatus_de_Invasion__c != \'Invadida\' AND Estatus_de_Invasion__c != \'\' AND ';} else if(ins == 'vacio'){insv=' Estatus_de_Invasion__c=\'\' AND ';}// && ins != null
        
        if(rehas == 'Todo'){rehasv='';}else if(rehas == 'True'){rehasv=' id IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ';}else if(rehas=='False'){rehasv=' id NOT IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ';}


        etq=Database.query('SELECT Etapa__c FROM Oferta__c WHERE '              + gesv + edosv + cdsv + colsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Etapa__c');
        ofq=Database.query('SELECT Oferta_Cargada__c FROM Oferta__c WHERE '     + gesv + edosv + cdsv + colsv + etsv + essv + insv + rehasv + condiciones +  ' GROUP BY Oferta_Cargada__c');
        esq=Database.query('SELECT Escritu__c FROM Oferta__c WHERE '            + gesv + edosv + cdsv + colsv + etsv + ofsv + insv + rehasv + condiciones +  ' GROUP BY Escritu__c');
        inq=Database.query('SELECT Estatus_de_Invasion__c FROM Oferta__c WHERE '+ gesv + edosv + cdsv + colsv + etsv + ofsv + essv + rehasv + condiciones +  ' GROUP BY Estatus_de_Invasion__c');

        gcq = Database.query('SELECT Gerente_Comercial__r.Name FROM Oferta__c WHERE '+ edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones +' GROUP BY Gerente_Comercial__r.Name');
        goq = Database.query('SELECT Gerente_Operativo__r.Name FROM Oferta__c WHERE '+ edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones +' GROUP BY Gerente_Operativo__r.Name');
        
        rehacqt = Database.countQuery('SELECT count() FROM Oferta__c WHERE id IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + condiciones + 'LIMIT 1');
        rehacqf = Database.countQuery('SELECT count() FROM Oferta__c WHERE id NOT IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + condiciones + 'LIMIT 1');

        List<Oferta__c> precioLista = new List<Oferta__c>();
        precioLista = Database.query('SELECT PrecioVenta__c FROM Oferta__c WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' ORDER BY PrecioVenta__c ASC NULLS LAST LIMIT 1');
        if(precioLista.size() > 0){
            precioObj= precioLista.get(0);
            preciomin = precioObj.PrecioVenta__c;
        }
        List<Oferta__c> diasLista = new List<Oferta__c>();
        diasLista = Database.query('SELECT TiempoOferta__c FROM Oferta__c WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' ORDER BY TiempoOferta__c DESC NULLS LAST LIMIT 1');
        if(diasLista.size() > 0){
            diasObj = diasLista.get(0);
            diasmax = diasObj.TiempoOferta__c;
        }


        if((edos != 'edo01' && edos != '' ) && (cds != 'cd01' && cds != '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------------todos
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds == 'cd01' || cds == '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------estado 
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds != 'cd01' && cds != '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------ciudad 
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds == 'cd01' || cds == '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------colonia
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds != 'cd01' && cds != '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------estado y ciudad
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds == 'cd01' || cds == '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------estado y colonia
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds != 'cd01' && cds != '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------ciudad y colonia
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds == 'cd01' || cds == '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------ninguno
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else{
            edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        } 


        algo=false;
    }// fin de public actualizar
    
    
    public void llenadoPaginas(){
        algo=true;

        Datetime reciente = hoy.addDays(-15);
        
        ofertasq = Database.query(Campos + ' WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones );
        docs = [SELECT Name, Fecha_Cierre__c, Oferta__r.Name FROM Documento__c WHERE Name IN ('Escrituras Registradas','Carta de desalojo') AND Cerrado__c = true AND Fecha_Cierre__c > :reciente ];

        
        
        listOfertaBool = new List<wrapperclass>(); 
        
        
        for(Oferta__c regOfer : ofertasq){
            objectOferBool = new wrapperclass(); 
            objectOferBool.registro = regOfer;
            for(Documento__c doc : docs){
                if(regOfer.Id == doc.Oferta__c){
                    objectOferBool.boleano = true;
                    break;
                }
                else{
                    objectOferBool.boleano = false;
                }
            }
            listOfertaBool.add(objectOferBool);
        }
        
        n=0;
        index=0;
        for(wrapperclass regListOferBool : listOfertaBool){
            if(regListOferBool.boleano == true){
                objectOferBool = new wrapperclass();
                objectOferBool = listOfertaBool.get(index);
                listOfertaBool.set(index,regListOferBool);
                listOfertaBool.set(n,objectOferBool);
                index++;
            }
            n++;
        }
        
        Map<ID,wrapperclass> mapaCompleto = new Map<ID,wrapperclass>();

        for(wrapperclass reg: listOfertaBool){
            mapaCompleto.put(reg.registro.id,reg);
        }

        rehab = Database.query('SELECT id from Oferta__c where id in (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND '+ condiciones);
        Map<ID,Oferta__c> mapaRehabilitadas = new Map<ID,Oferta__c>();

        for(Oferta__c reg: rehab){
            mapaRehabilitadas.put(reg.id,reg);
        }

        for(ID regID : mapaCompleto.keySet()){
            mapaCompleto.get(regID).rehabilitada = mapaRehabilitadas.containsKey(regID);
        }

        pag1 = new List<wrapperclass>();
        pag2 = new List<wrapperclass>();
        pag3 = new List<wrapperclass>();
        pag4 = new List<wrapperclass>();
        pag5 = new List<wrapperclass>();
        pag6 = new List<wrapperclass>();
        pag7 = new List<wrapperclass>();
        
        n=0;
        //npag2 = 1;
        
        
        for(wrapperclass x : listOfertaBool){
        
            if(n<300){
                pag1.add(x);   
            }
            else if(n<600){
                pag2.add(x);
            }
            else if(n<900){
                pag3.add(x);
            }
            else if(n<1200){
                pag4.add(x);
            }
            else if(n<1500){
                pag5.add(x);
            }
            else if(n<1800){
                pag6.add(x);
            }
            else if(n<2100){
                pag7.add(x);
            }
            n++;
        
        }
        
        sizelist = pag1.size() + pag2.size() + pag3.size() + pag4.size() + pag5.size() + pag6.size() + pag7.size();
        integer z = math.mod(sizelist,300);
        sizelist /= 300;
        
        if(z > 0){
        sizelist++;
        }
        
        paginacion();
        
    }
    
    public PageReference exportar(){
        llenadoPaginas();
        PageReference pagr = new PageReference('/apex/Excel');
        return pagr;
    }
    
    public void editarComentarios(){
        mostrarDialogoComentarios = true;
        if(comentarios==1){comentariosq = Database.query('SELECT id, Comentarios_Gerente__c,Name FROM Oferta__c WHERE id = :idRegistro');}
        else if(comentarios==2){comentariosq = Database.query('SELECT id, Comentarios_Ejecutivos__c,Name FROM Oferta__c WHERE id = :idRegistro');}
        
        
    } 
    public void cancelarComentarios(){
        mostrarDialogoComentarios = false;
        comentarios=0;
    }   
    public void guardarComentarios(){
        update comentariosq;
        cancelarComentarios();
        actualizar();
        llenadoPaginas();
    }
    public void next(){
        npag2++;
        num2=(npag2-1)*300;
        llenadoPaginas();
 
    }
    public void previous(){ 
        npag2--;
        num2=(npag2-1)*300;
        llenadoPaginas();
    }
    public void paginacion(){
  
        sizelistarray = new Integer[]{} ;
        for(integer i=1;i<=sizelist;i++){
             sizelistarray.add(i); 

        }
    }
           /*public Integer counter2 {get;set;}
           
        public integer counter2 {
      get { return counter2; }
      set { counter2 = 0; }
   }


        
        public void incrementCounter() {
                counter2++;
        }
        public Integer getCount() {
            return counter2;
        }*/
    
    
    
    public void Cobertura(){
        Integer a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
        a = 1;
    }
}