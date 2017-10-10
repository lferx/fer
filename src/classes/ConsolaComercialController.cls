public with sharing class ConsolaComercialController{

    public ConsolaComercialController(){

        inicioVariables();
        //Decimal tmpWidth;
        
        idReferencia=System.currentPageReference().getParameters().get('id');
        //String tmpStrData = ApexPages.currentPage().getParameters().get('dimension');
        //if(tmpStrData!= null){
            //tmpWidth = Decimal.valueOf(tmpStrData);
        //}

        //if(tmpWidth == null){
        //    tmpWidth = 1024;
        //}

        //tmpWidth = tmpWidth*.70;

        //widthSmall = tmpWidth*.05;
        //widthMedium = tmpWidth*.08;
        //widthLarge = tmpWidth*.1;

        if(String.isNotBlank(idReferencia)){
            huboReferencia = true;
            validarCliente(idReferencia);
            //validarcarrito();
        }
        //huboReferencia = true;
        Reset();
        //botonEnvioPdf = false;
        //String idReferencia=System.currentPageReference().getParameters().get('hayUsuario');
        //if(String.isNotBlank(idReferencia))
            //hayUsuario = Boolean.valueOf(idReferencia);
        //else
            //hayUsuario = false;

        //hayUsuario = true;
        User us = [Select us.SmallPhotoUrl, us.FullPhotoUrl From User us where us.id=:Userinfo.getUserid()];
        Photolink = us.SmallPhotoUrl;

    }
    public string Photolink{get;set;}
    /*public AAEFiltraOfertasControllerPrueba(ConsolaComercialController controller){
        inicioVariables();
        idReferencia=System.currentPageReference().getParameters().get('id');
        if(String.isNotBlank(idReferencia)){
            huboReferencia = true;
            validarCliente(idReferencia);
            validarcarrito();
        }
        //huboReferencia = true;
        Reset();
        //String idReferencia=System.currentPageReference().getParameters().get('hayUsuario');
        //if(String.isNotBlank(idReferencia))
            //hayUsuario = Boolean.valueOf(idReferencia);
        //else
            //hayUsuario = false;

        //hayUsuario = true;
        
    }*/

    //INICIA VARIABLES PARA CUENTA
    public Boolean huboReferencia {get;set;}
    public id idReferencia {get;set;}
    //public Account nuevoLead {get;set;}
    public Boolean hayUsuario {get;set;}
    public Account objetoCuenta {get;set;}
    public String nombre {get;set;}
    //public String apellido {get;set;}
    public String email01 {get;set;}
    public String email02 {get;set;}
    public String email03 {get;set;}
    public String[] arrayCorreos;
    public String preca;
    public final String cuerpoStock = '<br><br>Sabemos lo importante que es hacer crecer tu dinero. Gracias por confiar en REVIMEX para ello.<br><br>En el adjunto, encontrarás las especificaciones de las propiedades de tu interés.<br><br>Nuestra misión es ofrecerte siempre el mejor servicio.';
    public carrito__c objetoCarrito {get;set;}
    public List<Detalle_del_Carrito__c> listadelcarrito {get;set;}
    public Boolean hayCarrito {get;set;}
    //public Boolean botonEnvioPdf {get;set;}
    public Integer carroLleno {get;set;}
    map<id,Detalle_del_Carrito__c> mapacarrito;
    public List<carrito__c> historialDelCarrito {get; set;}
    Set<Id> carritosHistorial;
    public Id ofertaId {get;set;}
    Detalle_del_Carrito__c crearDetalle;
    public String folioOferta {get;set;}
    public boolean seBuscaPorId {get;set;}

    public String tipoDeOrden {get;set;}
    public String campoOrden {get;set;}
    public boolean esPorOrden {get;set;}
    public String orderBy {get;set;}

    public integer aumentarCampo {get;set;}

    public String idDetalleDelete {get;set;}
    public boolean botonEnvioPdf {get;set;}
    public final String cuerpoFicha = 'Hola, Gracias por confiar en REVIMEX para encontrar tu hogar.<br> <br>En el adjunto, encontrarás las especificaciones de las propiedades de tu interés.<br><br>Cualquier duda o comentario estamos a tus ordenes.';
    public boolean actualizarFecha {get;set;}

    //public Decimal widthSmall {get;set;}
    //public Decimal widthMedium {get;set;}
    //public Decimal widthLarge {get;set;}
    //public Decimal newWidth {get;set;}

    integer soloUnaVez = 1;
    Integer ajusteDePreca;
    String ciudad = '';







    //TERMINA VARIABLES PARA CUENTA


    transient List<Oferta__c> ofertasq; //consuta principal trae todo el stock
    //public List<Oferta__c> comentariosq {get;set;} //traer comentarios gerente o ejecutivos posteriormente se modifica

    public transient List<wrapperclass> pag1 {get;set;} //para llenar pagina 1
    public transient List<wrapperclass> pag2 {get;set;} //para llenar pagina 2
    public transient List<wrapperclass> pag3 {get;set;} //para llenar pagina 3
    public transient List<wrapperclass> pag4 {get;set;} //para llenar pagina 4
    public transient List<wrapperclass> pag5 {get;set;} //para llenar pagina 5
    public transient List<wrapperclass> pag6 {get;set;} //para llenar pagina 6
    public transient List<wrapperclass> pag7 {get;set;} //para llenar pagina 7

    //transient List<Documento__c> docs {get;set;} //crea lista de documentos recientes
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
    List<AggregateResult> tpq;
    List<AggregateResult> nhq;

    //Oferta__c precioObj; 
    Double preciomin;
    Double preciomin2;
    //Oferta__c diasObj;
    Double diasmax;
    
    boolean bandera;
    String convertS; //variable para converitir un objeto a string
    String y;//para etiquetar los filtros de true o false
    String[] vaciar = new String[]{'Todo'}; //es un arreglo que sirve para limpiar un arreglo
    final Integer cantidadDeRegistros = 300;

    
    //public boolean ban=True; //se utiliza en los filtros omitir repetidos

    
    
    public String vuser = UserInfo.getFirstName()+' '+UserInfo.getLastName(); //guarda el usuario que inicio secion para ponerlo en la consulta
    public Datetime hoy = Date.today(); //fecha de hoy
    public boolean paginasBoolean{get;set;} //se utiliza para mostrar o no el boton de siguient o anterior ..necesita ser public para comunicarse con la pagina
    public Integer sizelist {get;set;} //calcula el numero de paginas para imprimir en visual
    public Integer n {get;set;} //contador de limite de registros por paginas
    public Integer index = 0; //ordena la lista de ofertaq para mostrar los recien escriturados y los recien desalojados
    public Integer npag2 {get;set;}//para pararse en la pginacion
    public Integer num2 {get;set;}//para numerar los registros
    public Integer[] sizelistarray {get;set;}
    public boolean filtroespecial {get;set;}

    public Boolean esCuentaPersonal {get;set;}
    

    //Integer count=0;

    //variable para los comentarios
    //public Id ofertaId {get;set;} //guarda el id de la oferta de comentario
    //public boolean mostrarDialogoComentarios {get;set;} //muestra u oculta el cuadro de comentarios
    //public Integer comentarios {get;set;} // se utiliza para saber si es comentarios gerente o comentarios ejecutivo 
    
    //Estas variables guardan los campos y condiciones fijas para el stock
    String campos = 'SELECT Precio_Original__c,Inversor2__c,Owner.Name,Oferta_Cargada__c, Propiedad__r.Construccion_m2__c, Comentarios_en_revision__c, Amparo__c, TipoOferta__c, Comentarios_Gerente__c, Comentarios_Ejecutivos__c, Campa__c,Gerente_Comercial__r.Name, Gerente_Operativo__r.Name, Etapa__c,Paquete__r.Name,Propiedad__r.Tipo__c,Name,Plaza__c,Estado__r.Name,  Ciudad_Tabla__r.Name,Colonia_Busqueda__r.Name,Direccion2__c,Propiedad__r.Terreno_m2__c,Propiedad__r.N_de_habitaciones__c,Propiedad__r.N_de_Ba_os__c,Propiedad__r.Tipo_de_invasor__c,Escritu__c,Fecha_Prevista_Desalojo__c,Invadida__c,Desalojada__c,Asegurada__c,Estatus_de_Invasion__c,ValorReferencia__c,PrecioVenta__c,Revisada__c,TiempoOferta__c,CosteRehabilitacion__c,CosteDesalojo2__c FROM Oferta__c ';
    String condiciones;
    final String condicionesFijas =' FechaPago__c != Null AND FechaCobro__c = Null AND ((Etapa__c IN (\'Compilación expediente compra\',\'Compra final\',\'Escrituras en proceso registro\',\'Compilación expediente cliente\')) OR (Etapa__c IN (\'Rehabilitación\') AND Estatus_de_Invasion__c = \'Invadida\')) AND Estatus__c != \'Descartada\' AND (NOT Inversor2__c LIKE \'Regeneradora%\')';

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

    //variable para rango de valor referencia
    public List<SelectOption> prlst2;
    public Integer prs2 {get;set;}
    
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

     //varialbe para tipo de propiedad
    public List<SelectOption> tplst;
    public String tps {get;set;} //guarda lo deleccionado por el visual
    String tpsv=''; //guarda parte de la consulta para adjuntarse en el filtro

    //numero de habitaciones
    public List<SelectOption> nhlst;
    public String nhs {get;set;} //guarda lo deleccionado por el visual
    String nhsv=''; //guarda parte de la consulta para adjuntarse en el filtro


    
    String gesv='';
    String edosv='';// guarda query estado
    String cdsv='';// guarda query ciudad
    String colsv='';// guarda query colonia
    String etsv='';// guarda query etapa
    String ofsv='';// guarda query oferta
    String essv='';// guarda query escritura
    String insv='';// guarda query ivadida
    

    
    //public wrapperclass objectOferBool {get;set;} //objeto de lista compuesta
    public transient List<wrapperclass> listOfertaBool{get;set;}  //lista compuesta
    
    //clase con listas para generar lista compueta
    public class wrapperclass{  
        public Oferta__c registro {get;set;} //crea un campo dentro de la lista compuesta de tipo booleano
        public boolean boleano {get;set;} //crea un campo dentro de la lista compuesta de tipo booleano
        public boolean rehabilitada {get;set;}
        public boolean active {get;set;}
    }   
    


    //public void reCalcWidths(){

    //    //System.debug('newWidth: '+newWidth);

    //    widthMedium = newWidth*.8;
    //    widthSmall = newWidth*.05;
    //    widthLarge = newWidth*.1;

    //    llenadoPaginas();
    //}
    
    
    
    //lista de seleccion de gerente /////////////////////////////////////////////////////   
    
    //public List<SelectOption> getGeLst(){
    //    List<SelectOption> geLst = new List<SelectOption>();
    //    Set<String> sGerentes = new Set<String>();
    //    geLst.add(new SelectOption('Todo','-- Todo --'));

    //    for(AggregateResult x : gcq){
    //        convertS = (String) x.get('Name');
    //        sGerentes.add(convertS);
    //    }

    //    for(AggregateResult x : goq){
    //        convertS = (String) x.get('Name');
    //        sGerentes.add(convertS);
    //    }

    //    for(String geName: sGerentes){
    //        if(geName == null || geName == ''){
    //            geLst.add(new SelectOption('','ERROR'));
    //        }else{
    //            geLst.add(new SelectOption(geName,geName));
    //        }
    //    }

    //    return geLst;
    //}

    //lista de seleccion de estado//////////////////////////////////////////////////////////
    public List<SelectOption> getEdoLst(){    
        List<SelectOption> edoLst = new List<SelectOption>();
        edoLst.add(new SelectOption('Todo','-- Todo --'));
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
        cdLst.add(new SelectOption('Todo','-- Todo --'));
        if(string.isNotBlank(ciudad)){
            cdLst.add(new selectOption(ciudad,'*'+ciudad));
        }
        for(AggregateResult x : cdq){
            convertS = (String) x.get('Name');
            if(convertS == null){
                cdLst.add(new SelectOption('','ERROR'));
            }else if(convertS != ciudad){
                cdLst.add(new SelectOption(convertS,convertS));
            }
        }
        return cdLst;    
    }
    //lista de seleccion de colonia////////////////////////////////////////////////////////////
    public List<SelectOption> getColLst(){
        List<SelectOption> colLst = new List<SelectOption>();
        colLst.add(new SelectOption('Todo','-- Todo --'));
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
        prlst.add(new SelectOption('0','-- Todo --'));
        if(ajusteDePreca > 0){
            prlst.add(new SelectOption(String.valueOf(ajusteDePreca),'* Hasta $'+String.valueOf(ajusteDePreca.format()) ));
        }
        if(preciomin <= 2000000){    prlst.add(new SelectOption('2000000','Hasta $2,000,000'));  }
        if(preciomin <= 1000000){    prlst.add(new SelectOption('1000000','Hasta $1,000,000'));  }
        if(preciomin <= 750000){     prlst.add(new SelectOption( '750000',  'Hasta $750,000'));  }
        if(preciomin <= 500000){     prlst.add(new SelectOption( '500000',  'Hasta $500,000'));  }
        if(preciomin <= 400000){     prlst.add(new SelectOption( '400000',  'Hasta $400,000'));  }
        if(preciomin <= 300000){     prlst.add(new SelectOption( '300000',  'Hasta $300,000'));  }
        if(preciomin <= 200000){     prlst.add(new SelectOption( '200000',  'Hasta $200,000'));  }
        
        return prlst;
        
    }
    //lista de precios valor referencia/////////////////////////////////////////////////////////
    public List<SelectOption> getprlst2(){
        List<SelectOption> prlst2 = new List<SelectOption>();
        prlst2.add(new SelectOption('0','-- Todo --'));
        if(preciomin2 <= 2000000){    prlst2.add(new SelectOption('2000000','Hasta $2,000,000'));  }
        if(preciomin2 <= 1000000){    prlst2.add(new SelectOption('1000000','Hasta $1,000,000'));  }
        if(preciomin2 <= 750000){     prlst2.add(new SelectOption( '750000',  'Hasta $750,000'));  }
        if(preciomin2 <= 500000){     prlst2.add(new SelectOption( '500000',  'Hasta $500,000'));  }
        if(preciomin2 <= 400000){     prlst2.add(new SelectOption( '400000',  'Hasta $400,000'));  }
        if(preciomin2 <= 300000){     prlst2.add(new SelectOption( '300000',  'Hasta $300,000'));  }
        if(preciomin2 <= 200000){     prlst2.add(new SelectOption( '200000',  'Hasta $200,000'));  }
        
        return prlst2;
        
    }
    
    //lista de seleccion de etapa//////////////////////////////////////////////////////////
    public List<SelectOption> getetlst(){
   
        List<SelectOption> etlst = new List<SelectOption>();
        y='';
        etlst.add(new SelectOption('Todo','-- Todo --'));
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
        oflst.add(new SelectOption('Todo','-- Todo --'));
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
        eslst.add(new SelectOption('Todo','-- Todo --'));
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
        inlst.add(new SelectOption('Todo','-- Todo --'));
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
        dilst.add(new SelectOption('0','-- Todo --'));
        if(diasmax > 100){  dilst.add(new SelectOption('100','Mas de 100'));    }
        if(diasmax > 200){  dilst.add(new SelectOption('200','Mas de 200'));    }
        if(diasmax > 300){  dilst.add(new SelectOption('300','Mas de 300'));    }
        if(diasmax > 400){  dilst.add(new SelectOption('400','Mas de 400'));    }
        if(diasmax > 500){  dilst.add(new SelectOption('500','Mas de 500'));    }
        if(diasmax > 600){  dilst.add(new SelectOption('600','Mas de 600'));    }
        if(diasmax > 700){  dilst.add(new SelectOption('700','Mas de 700'));    }
        
        
        return dilst;
        
    }

    //lista de seleccion de rehabilitacion  ////////////////////////////////////////////////////////////////////////   
    public List<SelectOption> getrehalst(){
        List<SelectOption> rehalst = new List<SelectOption>();
        rehalst.add(new SelectOption('Todo','-- Todo --'));
        if(rehacqt > 0){rehalst.add(new SelectOption('True','Rehabilitadas'));}
        if(rehacqf > 0){rehalst.add(new SelectOption('False','No Rehabilitadas'));}
        
        return rehalst;
    }

    //Lista para el tipo de propiedad //////////////////////////////////////////////////////////////////////////////
    public List<SelectOption> gettplst(){

        List<SelectOption> tplst = new List<SelectOption>();
        tplst.add(new SelectOption('Todo','-- Todos --'));
        for(AggregateResult x : tpq){
            convertS = (String) x.get('Tipo__c');
            if(String.isBlank(convertS)){
                tplst.add(new SelectOption('vacio','ERROR'));
            }else{
                tplst.add(new SelectOption(convertS,convertS));
            }
        }
        return tplst;
    }
    public List<SelectOption> getnhlst(){

        List<SelectOption> nhlst = new List<SelectOption>();
        nhlst.add(new SelectOption('Todo','-- Todos --'));
        for(AggregateResult x : nhq){
            convertS = (String) x.get('N_de_Habitaciones__c');
            if(convertS == '' || convertS == null){
                nhlst.add(new SelectOption('vacio','ERROR'));
            }else{
                nhlst.add(new SelectOption(convertS,convertS));
            }
        }
        return nhlst;
    }
    

    //public void cambiarofertas(){
    //    if(filtroespecial){
    //        filtroespecial = false;
    //    }else{
    //        filtroespecial = true;
    //    }
    //    Reset();
    //}

    public void buscar(){
        if(String.isBlank(folioOferta)){
            mandarMensaje(3,'Debe escribir un valor.');
            return ;
        }else{
            folioOferta = folioOferta.toUpperCase();
            folioOferta = folioOferta.trim();
            folioOferta = utilities.accentsRemover(folioOferta);
            seBuscaPorId = true;
            llenadoPaginas();
        }
    }
    public void mandarMensaje(integer n,String e){
        if(n == 1){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,e));
        }else if(n == 2){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, e));
        }else if(n == 3){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,e));
        }
    }
    //public void actualizar2(){
    //    actualizar();
    //    llenadoPaginas();
    //}

    public void inicioVariables(){
        huboReferencia = false;
        filtroespecial = false;
        carritosHistorial = new Set<Id>();
        carroLleno=0;
        hayusuario = false;
        haycarrito = false;
        folioOferta = null;
        seBuscaPorId = false;
        aumentarCampo = 1;
        esCuentaPersonal = true;
        //mostrarVentana = false;
        actualizarFecha = false;
        //validarCliente(idReferencia);
        //muestrameTabla=false;
        //seBuscaPorId = false;
        //preca='';
        //validarcarrito();
        botonEnvioPdf=false;
        esPorOrden = false;
        //aumentarCampo=1;
        
        
    }//fin de public reset
    public void Reset(){
        ges='';
        edos = '';
        cds = '';
        cols = '';
        if(ajusteDePreca > 0){
            prs = ajusteDePreca;
        }else{
            prs = 0;
        }
        
        prs2 = 0;
        ets = '';
        ofs = 'Todo';
        ess = 'Todo';
        ins = 'in01';
        dis = 0;
        rehas = 'Todo';
        tps='Todo';
        nhs='Todo';
        
        setGerenteSelec(vaciar);
        setEstadoSelec(vaciar);
        //setCiudadSelec(vaciar);
        setColoniaSelec(vaciar);
        setEtapaSelec(vaciar);
        setInvasionSelec(vaciar);

        paginasBoolean=false;

        //mostrarDialogoComentarios = false;


        //se utiliza para el ordenamiento
        tipoDeOrden = null;
        campoOrden = null;
        esPorOrden = false;
        orderBy = null;

        
        if(objetoCuenta != null){
            if(String.isNotBlank(objetoCuenta.Ciudad_Plaza__c) ){
                //&& soloUnaVez == 1
                ciudad = objetoCuenta.Ciudad_Plaza__c.trim();
                integer check = Database.countQuery('SELECT count() FROM Oferta__c WHERE Ciudad_Tabla__r.Name IN(\''+ciudad+'\') AND '+condicionesFijas+' LIMIT 1');
                if(check > 0){
                    setCiudadSelec(new String[]{ciudad});
                }
                else{
                    setCiudadSelec(vaciar);
                    mandarMensaje(2,'Por el momento no se encontraron ofertas <br> en el stock con la ciudad de interés del cliente. <br> Intenta buscar otra.');
                }
                soloUnaVez ++;
            }else{
                setCiudadSelec(vaciar);
            }
        }else{
            setCiudadSelec(vaciar);
        }
        

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
        tpsv='';
        nhsv='';

        ges='';
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
    public void ordenar(){
        //system.debug('tipo de orden: '+tipoDeOrden+' : '+campoOrden);
        if(String.isNotBlank(tipoDeOrden) && String.isNotBlank(campoOrden)){
            esPorOrden = true;
            orderBy = ' ORDER BY '+campoOrden+' '+tipoDeOrden;
            npag2=1;
        }else{
            esPorOrden = false;
            orderBy = null;
        }
        //system.debug('Orden: '+esPorOrden+' : '+orderBy);
        //llenadoPaginas();
    }

    public void actualizar(){
        if(filtroespecial){
            condiciones=' FechaPago__c != null AND FechaCobro__c = null AND (Etapa__c IN (\'Antecedentes\',\'Aprobada internamente\',\'Descartada\') OR Estatus__c = \'Descartada\') AND (NOT Inversor2__c LIKE \'Regeneradora%\')';
        }else{
            condiciones= condicionesFijas;
        }

        if(dis > 0){
            condiciones =' TiempoOferta__c >= '+dis+' AND ' + condiciones;
        }
        if(prs2 > 0){
            condiciones =' ValorReferencia__c <= '+prs2+' AND ' + condiciones;
        }

        //String condicionesPrecioOriginal = condiciones;
        //if(hayUsuario && String.isNotBlank(preca) && prs == ajusteDePreca){
        //    condiciones = preca + condiciones;
           
        //}
        //else 
        if(prs > 0){
            condiciones =' Precio_Original__c <= '+prs+' AND ' + condiciones;
            //condicionesPrecioOriginal = condiciones;
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
        if(ofs != 'Todo'){ofs2=Boolean.valueOf(ofs); ofsv=' Oferta_Cargada__c = '+ofs2+' AND ';}else{ofsv='';}// && ets != null
        if(ess != 'Todo' && ess != 'vacio'){essv=' Escritu__c=:ess AND ';}else if(ess == 'vacio'){essv=' Escritu__c=\'\' AND ';}// && ess != null
        //if(ins != 'in01' && ins != 'vacio' && ins != 'Noinvadida'){insv = 'Estatus_de_Invasion__c = :ins AND ';}else if(ins == 'Noinvadida'){insv=' Estatus_de_Invasion__c != \'Invadida\' AND Estatus_de_Invasion__c != \'\' AND ';} else if(ins == 'vacio'){insv=' Estatus_de_Invasion__c=\'\' AND ';}// && ins != null
        
        if(rehas == 'Todo'){rehasv='';}else if(rehas == 'True'){rehasv=' id IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ';}else if(rehas=='False'){rehasv=' id NOT IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ';}

        if(tps != 'Todo' && tps != 'vacio')     {tpsv=' Propiedad__r.Tipo__c = \''+tps+ '\' AND ';              }       else if(tps == 'vacio'){tpsv=' Propiedad__r.Tipo__c = \'\' AND ';}
        if(nhs != 'Todo' && nhs != 'vacio')     {nhsv=' Propiedad__r.N_de_Habitaciones__c = \''+nhs+ '\' AND ';         }       else if(nhs == 'vacio'){nhsv=' Propiedad__r.N_de_Habitaciones__c = \'\' AND ';}




        etq=Database.query('SELECT Etapa__c FROM Oferta__c WHERE '              + gesv + edosv + cdsv + colsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Etapa__c');
        ofq=Database.query('SELECT Oferta_Cargada__c FROM Oferta__c WHERE '     + gesv + edosv + cdsv + colsv + etsv + essv + insv + rehasv + condiciones +  ' GROUP BY Oferta_Cargada__c');
        esq=Database.query('SELECT Escritu__c FROM Oferta__c WHERE '            + gesv + edosv + cdsv + colsv + etsv + ofsv + insv + rehasv + condiciones +  ' GROUP BY Escritu__c');
        inq=Database.query('SELECT Estatus_de_Invasion__c FROM Oferta__c WHERE '+ gesv + edosv + cdsv + colsv + etsv + ofsv + essv + rehasv + condiciones +  ' GROUP BY Estatus_de_Invasion__c');

        gcq = Database.query('SELECT Gerente_Comercial__r.Name FROM Oferta__c WHERE '+ edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones +' GROUP BY Gerente_Comercial__r.Name');
        goq = Database.query('SELECT Gerente_Operativo__r.Name FROM Oferta__c WHERE '+ edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones +' GROUP BY Gerente_Operativo__r.Name');
        
        rehacqt = Database.countQuery('SELECT count() FROM Oferta__c WHERE id IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + condiciones + 'LIMIT 1');
        rehacqf = Database.countQuery('SELECT count() FROM Oferta__c WHERE id NOT IN (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + condiciones + 'LIMIT 1');

        tpq = Database.query('SELECT Propiedad__r.Tipo__c FROM Oferta__c Where '+ edosv + cdsv + colsv + essv + insv + rehasv + nhsv + condiciones+'  GROUP BY Propiedad__r.Tipo__c');
        nhq=Database.query('SELECT Propiedad__r.N_de_Habitaciones__c FROM Oferta__c where '+ edosv + cdsv + colsv + essv + insv + rehasv + tpsv + condiciones+' Group by Propiedad__r.N_de_Habitaciones__c ');

        try{
            Oferta__c precioObj = Database.query('SELECT Precio_Original__c FROM Oferta__c WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' ORDER BY Precio_Original__c ASC NULLS LAST LIMIT 1');
            if(precioObj.Precio_Original__c > 0){
                preciomin = precioObj.Precio_Original__c;
            }
            Oferta__c precioObj2 = Database.query('SELECT ValorReferencia__c FROM Oferta__c WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' ORDER BY ValorReferencia__c ASC NULLS LAST LIMIT 1');
            if(precioObj2.ValorReferencia__c > 0){
                preciomin2 = precioObj2.ValorReferencia__c;
            }
            Oferta__c diasObj = Database.query('SELECT TiempoOferta__c FROM Oferta__c WHERE ' + gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' ORDER BY TiempoOferta__c DESC NULLS LAST LIMIT 1');
            if(diasObj.TiempoOferta__c > 0){
                diasmax = diasObj.TiempoOferta__c;
            }
        }catch(exception e){
            //system.debug('errores en la querys: '+e);
        }
    
        

        String cx = gesv+etsv+ofsv+essv+insv+rehasv;

        if((edos != 'edo01' && edos != '' ) && (cds != 'cd01' && cds != '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------------todos
            edoq=queryAggregateResult('Estado__r.Name', cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', edosv + cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', edosv + cdsv + cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds == 'cd01' || cds == '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------estado 
            edoq=queryAggregateResult('Estado__r.Name',cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', edosv + cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', edosv +cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds != 'cd01' && cds != '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------ciudad 
            edoq=queryAggregateResult('Estado__r.Name', cdsv + cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', cdsv + cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds == 'cd01' || cds == '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------colonia
            edoq=queryAggregateResult('Estado__r.Name', colsv + cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', colsv + cx );
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds != 'cd01' && cds != '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------estado y ciudad
            edoq=queryAggregateResult('Estado__r.Name', cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', edosv + cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', edosv + cdsv + cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos != 'edo01' && edos != '') && (cds == 'cd01' || cds == '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------estado y colonia
            edoq=queryAggregateResult('Estado__r.Name', cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', edosv + colsv + cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name', edosv + cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + edosv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + edosv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else if((edos == 'edo01' || edos == '') && (cds != 'cd01' && cds != '') && (cols != 'col01' && cols != '')){//---------------------------------------------------------------------------------ciudad y colonia
            edoq=queryAggregateResult('Estado__r.Name', cdsv + colsv + cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name', cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name',cdsv + cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + cdsv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        //}else if((edos == 'edo01' || edos == '') && (cds == 'cd01' || cds == '') && (cols == 'col01' || cols == '')){//---------------------------------------------------------------------------------ninguno
            //edoq=queryAggregateResult('Estado__r.Name',cx);
            //cdq=queryAggregateResult('Ciudad_Tabla__r.Name',cx);
            //colq=queryAggregateResult('Colonia_Busqueda__r.Name',cx);
            ////edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            ////cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            ////colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }else{
            edoq=queryAggregateResult('Estado__r.Name',cx);
            cdq=queryAggregateResult('Ciudad_Tabla__r.Name',cx);
            colq=queryAggregateResult('Colonia_Busqueda__r.Name',cx);
            //edoq=Database.query('SELECT Estado__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Estado__r.Name');
            //cdq=Database.query('SELECT Ciudad_Tabla__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones + ' GROUP BY Ciudad_Tabla__r.Name');
            //colq=Database.query('SELECT Colonia_Busqueda__r.Name FROM Oferta__c WHERE '+ gesv + etsv + ofsv + essv + insv + rehasv + condiciones +  ' GROUP BY Colonia_Busqueda__r.Name');
        }

        paginasBoolean=false;
    }// fin de public actualizar

    public List<AggregateResult> queryAggregateResult(String agrup, String condicionesExtra){
        return Database.query('SELECT ' + agrup +' FROM Oferta__c WHERE ' + condicionesExtra + this.condiciones +' GROUP BY '+agrup);
    }
    
    
    public void llenadoPaginas(){
        validarcarrito();
        //system.debug('****Edgar***** Entro al llenado de paginas'+mapacarrito);
        paginasBoolean=true;
        String busquedaConcatenada='';
        
        if(seBuscaPorId){
            busquedaConcatenada = ' Name LIKE \'%'+folioOferta+'%\' AND '+condicionesFijas;
            seBuscaPorId=false;
            //folioOferta = null;
        }else{
            //system.debug('busquedaConcatenada: '+busquedaConcatenada);
            busquedaConcatenada = gesv + edosv + cdsv + colsv + etsv + ofsv + essv + insv + rehasv + condiciones;
            if(hayUsuario && String.isNotBlank(preca)){
            	//system.debug('va a filtrar por preca');
            }
            //system.debug('busquedaConcatenada: '+busquedaConcatenada);
        }

        Datetime reciente = hoy.addDays(-15);
        //system.debug(Campos + ' WHERE ' + busquedaConcatenada + condiciones + orderBy);
        if(esPorOrden){
            ofertasq = Database.query(Campos + ' WHERE ' + busquedaConcatenada  + orderBy);
        }else{
            ofertasq = Database.query(Campos + ' WHERE ' + busquedaConcatenada );
        }
        

        if(ofertasq.isEmpty()){
            mandarMensaje(2,'No se encontraron ofertas en el stock de venta. <br> Intentalo nuevamente. <br> El cliente no cuenta con el presupuesto adecuado');
            //paginacion();
            //return;
        }
        /*
        docs = Database.query('SELECT Oferta__c FROM Documento__c WHERE Name IN (\'Escrituras Registradas\',\'Carta de desalojo\') AND Cerrado__c = true AND Fecha_Cierre__c > :reciente');
        */
        listOfertaBool = new List<wrapperclass>();
        Map<ID,wrapperclass> mapaCompleto = new Map<ID,wrapperclass>();
        wrapperclass objectOferBool;
        for(Oferta__c regOfer : ofertasq){

            objectOferBool = new wrapperclass(); 
            objectOferBool.registro = regOfer;
            objectOferBool.active = false;
            /*for(Documento__c doc : docs){
                if(regOfer.Id == doc.Oferta__c){
                    objectOferBool.boleano = true;
                    break;
                }
                else{
                    objectOferBool.boleano = false;
                }
            }*/
            listOfertaBool.add(objectOferBool);
        }

        for(wrapperclass reg: listOfertaBool){
            mapaCompleto.put(reg.registro.id,reg);
        }
        /*
        //Este for intercambia la posicion de la lista para dar referencias de las mas recientes
        if(!esPorOrden){
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
        }*/
        

        

        rehab = Database.query('SELECT id from Oferta__c where id in (SELECT Oferta__c from Documento__c Where name = \'Fotografia del estado final de la propiedad\' AND NumFiles_MasFilesPadre__c > 0) AND '+ condiciones);
        Map<ID,Oferta__c> mapaRehabilitadas = new Map<ID,Oferta__c>();

        for(Oferta__c reg: rehab){
            mapaRehabilitadas.put(reg.id,reg);
        }

        for(ID regID : mapaCompleto.keySet()){
            mapaCompleto.get(regID).rehabilitada = mapaRehabilitadas.containsKey(regID);
            if(mapacarrito != null){
                mapaCompleto.get(regID).active = mapacarrito.containsKey(regID);
            }
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
        
        //for(integer i=0;i<=151;i++){
            //este for es para hacer pruebas de la paginacion en sandbox
        
        for(wrapperclass x : listOfertaBool){
        
            if(n<cantidadDeRegistros){
                pag1.add(x);   
            }
            else if(n<(cantidadDeRegistros*2)){
                pag2.add(x);
            }
            else if(n<(cantidadDeRegistros*3)){
                pag3.add(x);
            }
            else if(n<(cantidadDeRegistros*4)){
                pag4.add(x);
            }
            else if(n<(cantidadDeRegistros*5)){
                pag5.add(x);
            }
            else if(n<(cantidadDeRegistros*6)){
                pag6.add(x);
            }
            else if(n<(cantidadDeRegistros*7)){
                pag7.add(x);
            }
            n++;
        
        }
        //}
        
        sizelist = pag1.size() + pag2.size() + pag3.size() + pag4.size() + pag5.size() + pag6.size() + pag7.size();

        integer z = math.mod(sizelist,cantidadDeRegistros);
        sizelist /= cantidadDeRegistros;
        
        if(z > 0){
        sizelist++;
        }
        //if(sizelist == null){
        //  sizelist = 1;
        //}
        //if(npag2 == null){
        //  npag2 = 0;
        //}
        paginacion();
        
    }
    
    public PageReference exportar(){
    	//llenadoPaginas();
        PageReference paginaexcel = Page.ExcelOfertasCliente;
        //new PageReference('/apex/ExcelOfertasCliente');
        //Page.ExcelOfertasCliente;
        paginaexcel.setRedirect(false);
        return paginaexcel;

        //llenadoPaginas();
        //PageReference pagr = new PageReference('/apex/Excel');
        //return pagr;
    }
    //public void editarComentarios(){
    //    mostrarDialogoComentarios = true;
    //    if(comentarios==1){comentariosq = Database.query('SELECT id, Comentarios_Gerente__c,Name FROM Oferta__c WHERE id = :ofertaId');}
    //    else if(comentarios==2){comentariosq = Database.query('SELECT id, Comentarios_Ejecutivos__c,Name FROM Oferta__c WHERE id = :ofertaId');}
        
        
    //} 
    //public void cancelarComentarios(){
    //    mostrarDialogoComentarios = false;
    //    comentarios=0;
    //}   
    //public void guardarComentarios(){
    //    if(comentariosq != null){
    //        update comentariosq;
    //    }
    //    cancelarComentarios();
    //    actualizar();
    //    llenadoPaginas();
    //}
    public void next(){
        npag2++;
        num2=(npag2-1)*cantidadDeRegistros;
        llenadoPaginas();
    }
    public void previous(){ 
        npag2--;
        num2=(npag2-1)*cantidadDeRegistros;
        llenadoPaginas();
    }
    public void paginacion(){
        sizelistarray = new Integer[]{} ;
        for(integer i=1;i<=sizelist;i++){
             sizelistarray.add(i);
        }
    }



    private Account queryObjetoCuenta(string idCuenta){
        return [SELECT Email__c,Ciudad_Plaza__c,Email2__c,id, Name, Precalificacion__c, Forma_de_Pago__c, Total_credito_contado__c, PersonContactId, isPersonAccount,PersonEmail FROM Account WHERE id=:idCuenta];
    }

    public void validarCliente(string idCuenta){
        if(String.isNotBlank(idCuenta)){
            idCuenta = idCuenta.trim();
            objetoCuenta=queryObjetoCuenta(idCuenta);
            if(objetoCuenta != null){
                esCuentaPersonal = objetoCuenta.isPersonAccount;
                hayusuario = true;
                if(string.isNotBlank(objetoCuenta.name)){
                    nombre = objetoCuenta.name;
                }else{
                    nombre=' Cliente ';
                }
                
                
                if(String.isNotEmpty(objetoCuenta.PersonEmail)){
                    email01=objetoCuenta.PersonEmail;
                }else if(String.isNotEmpty(objetoCuenta.Email__c)){
                    email01=objetoCuenta.Email__c;
                 
                }else if(String.isNotEmpty(objetoCuenta.Email2__c)){
                    email01=objetoCuenta.Email2__c;
                }
                //if(objetoCuenta.Precalificacion__c != null && objetoCuenta.Precalificacion__c > 0){
                //        Integer add25percent = integer.valueOf(objetoCuenta.Precalificacion__c / 75 * 100);
                //        preca =' Precio_Original__c <= ' + add25percent + ' AND ';
                //}


                if (objetoCuenta.forma_de_pago__c=='Credito_Contado' && objetoCuenta.Total_credito_contado__c != null && objetoCuenta.Total_credito_contado__c > 0){
                    preca=' Precio_Original__c <= ' + objetoCuenta.Total_credito_contado__c + ' AND ';
                }else if(objetoCuenta.Precalificacion__c != null && objetoCuenta.Precalificacion__c > 0){
                    ajusteDePreca = 0;
                    if(objetoCuenta.forma_de_pago__c=='Contado'){
                        ajusteDePreca = integer.valueOf((objetoCuenta.Precalificacion__c / 75) * 100);
                        preca=' Precio_Original__c <= ' + ajusteDePreca + ' AND ';
                    }else{
                        ajusteDePreca = integer.valueOf((objetoCuenta.Precalificacion__c / 125) * 100);
                        preca=' Precio_Original__c <= ' + ajusteDePreca + ' AND ';
                    }
                   
                }
            }
        }
    }

    public void validarcarrito(){ 

        //system.debug('*Edgar* Validar Carrito');
        botonEnvioPdf = false;
        objetoCarrito = null;
        carritosHistorial = new set<id>();
        haycarrito =false;
        listadelcarrito = new List<Detalle_del_Carrito__c>();

        if(hayusuario){
            
            for(carrito__c x : [SELECT id,Name,Cuenta__c,Fecha_de_envio_pdf__c,Correos_de_envio_excel__c,Fecha_de_envio_excel__c,Correos_de_envio_pdf__c,Numero_de_envios_excel__c,Numero_de_envios_pdf__c FROM carrito__c WHERE Cuenta__c =:idReferencia]){
                if(x.Fecha_de_envio_pdf__c == null){
                    objetoCarrito = x;
                    haycarrito =true;
                    //system.debug('*Edgar* encontro el carrito del usuario: '+objetoCarrito.name);
                }else{
                    carritosHistorial.add(x.Id);
                }
            }
            if(hayCarrito || !carritosHistorial.isEmpty()){
                //system.debug('*Edgar* llamo a refrescarDetalleCarrito');
                refrescarDetalleCarrito();
            }
        }
    }
    //public void revalidarCarrito(){
        //if(hayusuario && !haycarrito){
        //    if(objetoCarrito==null){
        //        //system.debug('aqui entro a crear el carrito por que no encontro el de este usuario');
        //        objetoCarrito = crearCarrito(idReferencia);
        //        //objetoCarrito = [SELECT id,Name,Cuenta__c,Fecha_de_envio_pdf__c,Correos_de_envio_excel__c FROM carrito__c WHERE Fecha_de_envio_pdf__c = null AND Cuenta__c =:idReferencia LIMIT 1];
        //        if(objetoCarrito != null){
        //            haycarrito=true;
        //            //system.debug('se tuvo que crear el carrito: '+objetoCarrito.name);
        //            refrescarDetalleCarrito();
        //        }
        //    }
        //}

    //}
    public carrito__c crearCarrito(id idCuenta){
        carrito__c obj = new carrito__c();
            obj.Cuenta__c = idCuenta;
        insert obj;
        return obj;
    }

    public void obtenerUltimoCarritoLleno(){
        //SELECT id,name,Fecha_de_envio_pdf__c, (SELECT id,name,Id_de_Actividad__c, Veces_Abierto__c, Primera_Apertura__c, Ultima_Apertura__c, Oferta__c,Oferta__r.Precio_Original__c,Oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,Precio_Negociado__c,Oferta__r.ValorReferencia__c from Detalles_del_Carrito__r) from carrito__c ORDER BY Fecha_de_envio_pdf__c DESC
        //system.debug('Entro a buscar el ultimo carrito ');
        validarcarrito();
        if(hayusuario && (!haycarrito || listadelcarrito.isEmpty())){
            carritosHistorial = new set<id>();
            objetoCarrito = null;
            botonEnvioPdf = false;
            haycarrito = false;
            //system.debug('El carrito estuvo vacio y fue a buscar el ultimo enviado');
            integer contador1 = 0;
            for(carrito__c x : [SELECT id,Name,Cuenta__c,Fecha_de_envio_pdf__c,Correos_de_envio_excel__c,Fecha_de_envio_excel__c,Correos_de_envio_pdf__c,Numero_de_envios_excel__c,Numero_de_envios_pdf__c from carrito__c where Cuenta__c =:idReferencia ORDER BY Fecha_de_envio_pdf__c DESC NULLS LAST]){
                if(contador1 == 0 && x.Fecha_de_envio_pdf__c != null){
                    objetoCarrito = x;
                    haycarrito=true;
                }else if(x.Fecha_de_envio_pdf__c != null){
                    carritosHistorial.add(x.Id);
                }
                contador1 ++;
            }

            //if(objetoCarrito==null){
            //  //system.debug('aqui entro a crear el carrito por que no encontro el de este usuario');
            //  objetoCarrito = crearCarrito(idReferencia);
            //  //objetoCarrito = [SELECT id,Name,Cuenta__c,Fecha_de_envio_pdf__c,Correos_de_envio_excel__c FROM carrito__c WHERE Fecha_de_envio_pdf__c = null AND Cuenta__c =:idReferencia LIMIT 1];
            if(objetoCarrito != null || !carritosHistorial.isEmpty()){
                
            }
            
            //}
        }
        refrescarDetalleCarrito();
    }


    //AGREGAR AL CARRITO
    public void refrescarDetalleCarrito(){
        //system.debug('*Edgar* Entro a refrescar los detalles del carrito');
        listadelcarrito = new list<Detalle_del_Carrito__c>();
        mapacarrito = new map<id,Detalle_del_Carrito__c>();
        historialDelCarrito = null;
        if(haycarrito){
            //system.debug('*Edgar* Entro a refrescar los detalles del carrito2');
            botonEnvioPdf = false;
            listadelcarrito = [SELECT id,name,Id_de_Actividad__c, Veces_Abierto__c, Primera_Apertura__c, Ultima_Apertura__c, Oferta__c,carrito__c,Oferta__r.Precio_Original__c,Oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,Precio_Negociado__c,Oferta__r.ValorReferencia__c,carrito__r.Fecha_de_envio_pdf__c FROM Detalle_del_Carrito__c WHERE carrito__c =:objetoCarrito.id];
            carroLleno = listadelcarrito.size();
            //system.debug('total de carritos: '+carroLleno);
            if(carroLleno > 0 || !listadelcarrito.isEmpty()){
                botonEnvioPdf = true;
            }
                //carroLleno = true;
                //botonEnvioPdf = true;
            
            
            for(Detalle_del_Carrito__c x : listadelcarrito){
                //System.debug('*Edgar* Lleno el mapa'+x.Oferta__c);
                mapacarrito.put(x.Oferta__c,null);
            }
        }

        if(!carritosHistorial.isEmpty()){
            //historialDelCarrito = [SELECT id,name,Id_de_Actividad__c, Veces_Abierto__c, Primera_Apertura__c, Ultima_Apertura__c, Oferta__c,carrito__c,Oferta__r.Precio_Original__c,Oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,Precio_Negociado__c,Oferta__r.ValorReferencia__c,carrito__r.Fecha_de_envio_pdf__c FROM Detalle_del_Carrito__c WHERE carrito__c in: carritosHistorial ORDER BY carrito__r.Fecha_de_envio_pdf__c DESC];
            historialDelCarrito = [SELECT id,name,Fecha_de_envio_pdf__c, (SELECT id,name,Id_de_Actividad__c, Veces_Abierto__c, Primera_Apertura__c, Ultima_Apertura__c, Oferta__c,Oferta__r.Precio_Original__c,Oferta__r.Propiedad__r.Calle__c,Oferta__r.Colonia_busqueda__c,Precio_Negociado__c,Oferta__r.ValorReferencia__c from Detalles_del_Carrito__r) from carrito__c where id in: carritosHistorial ORDER BY Fecha_de_envio_pdf__c DESC];
            //SeguimientoCorreos seguimiento = new SeguimientoCorreos();
            //seguimiento.actualizarSeguimiento(objetoCuenta.PersonContactId, historialDelCarrito);
        }
        //system.debug('lista del carrito '+listadelcarrito);
        //system.debug('mapa del carrito '+mapacarrito);
    }


    public void creatingCar(){
        //codigo nuevo evita que se creen carrito que van a estar vacios
        //system.debug('CreatinCar: '+hayusuario+' hay carrito '+hayCarrito);
        if(hayusuario && !haycarrito){
        //system.debug('objetoCarrito antes de crear: objeto '+ objetoCarrito);
            if(objetoCarrito == null){
                //system.debug('aqui entro a crear el carrito por que no encontro el de este usuario');
                objetoCarrito = crearCarrito(idReferencia);
                //objetoCarrito = [SELECT id,Name,Cuenta__c,Fecha_de_envio_pdf__c,Correos_de_envio_excel__c FROM carrito__c WHERE Fecha_de_envio_pdf__c = null AND Cuenta__c =:idReferencia LIMIT 1];
                if(objetoCarrito != null){
                    haycarrito=true;
                    //system.debug('se tuvo que crear el carrito: '+objetoCarrito.name);
                    refrescarDetalleCarrito();
                }
            }
        }
        //codigo nuevo evita que se creen carrito que van a estar vacios
    }
    public void agregar(){
        creatingCar();
        system.debug('intentando agregar oferta al carrito '+ofertaId);
        if(String.isBlank(ofertaId)){
            //system.debug('Valor null: '+ofertaId);
            return;
        }
        refrescarDetalleCarrito();
        boolean agregarOf = true;
        if(mapacarrito.containsKey(ofertaId) ){
            agregarOf = false;
            //system.debug('Evito que se añadiera un duplicado');
        }
        //for(Detalle_del_Carrito__c x : listadelcarrito){
        //    if(x.Oferta__c == ofertaId){
        //        agregarOf = false;
        //        
        //        break;
        //    }
        //}
        //system.debug('Entro al detalle: '+haycarrito +' agregarOf '+agregarOf);
        if(haycarrito && agregarOf){
            //system.debug('Entro al detalle2');
            crearDetalle = new Detalle_del_Carrito__c();
                crearDetalle.Carrito__c = objetoCarrito.id;
                crearDetalle.Oferta__c = ofertaId;
            insert crearDetalle;

            //refrescarDetalleCarrito();
            //system.debug('si se añadio al carrito la oferta '+crearDetalle.Name);


        }
        //system.debug('finalizo');
        //llenadoPaginas();

    }
    public void eliminar(){
        if(haycarrito && String.isNotBlank(idDetalleDelete)){
            idDetalleDelete = idDetalleDelete.trim();
            Detalle_del_Carrito__c obj22;
            obj22= [SELECT id,Name FROM Detalle_del_Carrito__c WHERE id=:idDetalleDelete LIMIT 1];
            delete obj22;
            //system.debug('Se elimino correctamente el id'+obj22);
            refrescarDetalleCarrito();
            //llenadoPaginas();
        }
            
    }
    public void guardar(){
        if(haycarrito){
            update listadelcarrito;
            refrescarDetalleCarrito();
        }
    }
    public PageReference pdf(){
        PageReference pag = new PageReference('/apex/ficha_cliente_Pdf');
        pag.getParameters().put('id',objetoCarrito.id);
        return pag;
    }
    public void sendPdf() {
        
        boolean hayErrorEnEmail = checkEmail();
        if(hayErrorEnEmail){
            return;
        }

        PageReference pag = new PageReference('/apex/ficha_cliente_Pdf');
        pag.getParameters().put('id',objetoCarrito.id);

        String mensajeError = '';
        
        Blob body;
        try {
            body = pag.getContentAsPDF();
        } catch (exception e) {
            mensajeError = 'Error al generar archivo. <br>'+e;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensajeError));
            return;
        }

        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        try{
            attach.setContentType('application/pdf');
            attach.setFileName('fichaTecnica.pdf');
            attach.setInline(false);
            attach.Body = body;
        }catch(exception e){
            mensajeError='Hubo un error al adjuntar el archivo: <br>'+e;
            //System.debug(mensajeError+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensajeError));
            return;
        }

        

        try{
            //Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate('00Xg0000000Nvk3', objetoCuenta.PersonContactId, null);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            //mail.setToAddresses(new String[] { email01});
            mail.setToAddresses(arrayCorreos);
            mail.setSubject('Propiedades de tu interes REVIMEX');
            mail.setSaveAsActivity(true);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
            mail.setHtmlBody(cuerpoFicha);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(exception e){
            mensajeError='Hubo un error al enviar el correo: <br>'+e;
            //System.debug(mensajeError+e);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensajeError));
            return;
        }
        
        
        //mail.setTargetObjectId(objetoCuenta.PersonContactId);
        //mail.setTemplateId('00Xg0000000Nvk3');
        /*Datetime ahora = Datetime.now();
        Id tareaId = SeguimientoCorreos.obtenerTarea(ahora, objetoCuenta.PersonContactId);
        for(Detalle_del_Carrito__c det : listadelcarrito){
                det.Id_de_Actividad__c = tareaId;
        }
        

        */
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Correo con PDF enviado a '+arrayCorreos));           
        botonEnvioPdf = false;
        guardar();
        //if(objetoCarrito.Fecha_de_envio_pdf__c == null){
        //    actualizarFecha = true;
        //}else{
        //    actualizarFecha = false;
        //}
        
        modificarDatosPdf();
        validarcarrito();
        obtenerUltimoCarritoLleno();
        //llenadoPaginas();
    }
    public void modificarDatosPdf(){
        if(haycarrito){

        	if(objetoCarrito.Fecha_de_envio_pdf__c == null){
        		objetoCarrito.Fecha_de_envio_pdf__c = System.now();
        	}

            if(objetoCarrito.Numero_de_envios_pdf__c != null && objetoCarrito.Numero_de_envios_pdf__c > 0){
                objetoCarrito.Numero_de_envios_pdf__c += 1;
            }else{
                objetoCarrito.Numero_de_envios_pdf__c = 1;
            }
            
            String correos = objetoCarrito.Correos_de_envio_pdf__c;

            if(string.isBlank(correos)){
                correos='';
            }

            for(integer i=0;i < arrayCorreos.size();i++){
                if(!correos.contains(arrayCorreos[i])){
                    correos +=String.valueOf(arrayCorreos[i])+',';
                    //correosNuevos +=','+String.valueOf(arrayCorreos[i]);
                }
            }

            objetoCarrito.Correos_de_envio_pdf__c = correos;
            update objetoCarrito;
        }
    }

    public void enviarExcel(){
        boolean hayErrorEnEmail = checkEmail();
        if(hayErrorEnEmail){
            return;
        }
        
        
        //llenadoPaginas();
        PageReference paginaexcel = Page.ExcelOfertasCliente;
        paginaexcel.setRedirect(false);

        ////pag.getParameters().put('id',objetoCarrito.id);

        String mensajeError;
        
        Blob body;
        try {
            //system.debug('Excel: '+paginaexcel.getContent());
            body = paginaexcel.getContent();
            //system.debug('Excel2: '+body);
        } catch (VisualforceException e) {
            mensajeError = 'Error al generar excel: '+e;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, mensajeError));
            return;
        }

        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        try{
    // Esta parte genera el archivo adjunto en el correo
            
            attach.setContentType('text/csv');
            attach.setFileName('StockCliente.csv');
            attach.setInline(false);
            attach.setBody(body);
        }catch(exception e){
            mensajeError='Error al adjuntar archivo: <br>'+e;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensajeError));
            return;
        }

        try{
    //Esta partegenera el cuero del email por ejemplo asunto direccion, y adjunta el achivo
            //alex// Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate('00Xg0000000Nvk3', objetoCuenta.PersonContactId, null);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            //mail.setToAddresses(new String[] { email01 });
            mail.setToAddresses(arrayCorreos);
            mail.setSubject('Propiedades de REVIMEX');
            mail.setHtmlBody('Estimad@ '+nombre+'.'+cuerpoStock);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
            //mail.setSaveAsActivity(true);
        
            //mail.setTargetObjectId(objetoCuenta.PersonContactId);
            //mail.setTemplateId('00Xg0000000Nvk3');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

        }catch(exception e){
            mensajeError='Hubo un erro al intentar mandar el correo. <br> Verifica que el correo este correcto.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensajeError));
            return;
        }
    

        //Datetime ahora = Datetime.now();
        
        
        
        //email01 = ' ';
        //email02 = ' ';
        //email03 = ' ';

        creatingCar();
        //if(objetoCarrito != null){
        //    if(objetoCarrito.Fecha_de_envio_excel__c != null){
        //        actualizarFecha = false;
        //    }else{
        //        actualizarFecha = true;
        //    }
        //}

        //guardar();
        //actualizarFecha = true;
        modificarDatosExcel();
        //validarcarrito();
        mensajeError='Mesaje enviado correctamente a: ' +arrayCorreos;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, mensajeError));

        return;
    }
    public void modificarDatosExcel(){
        if(haycarrito){
            
            if(objetoCarrito.Fecha_de_envio_excel__c == null){
                objetoCarrito.Fecha_de_envio_excel__c = System.now();
            }

            if(objetoCarrito.Numero_de_envios_excel__c != null && objetoCarrito.Numero_de_envios_excel__c > 0){
                objetoCarrito.Numero_de_envios_excel__c += 1;
            }else{
                objetoCarrito.Numero_de_envios_excel__c = 1;
            }
            
            String correos = objetoCarrito.Correos_de_envio_excel__c;

            if(string.isBlank(correos)){
                correos='';
            }

            for(integer i=0;i < arrayCorreos.size();i++){
                if(!correos.contains(arrayCorreos[i])){
                    correos +=String.valueOf(arrayCorreos[i])+',';
                    //correosNuevos +=','+String.valueOf(arrayCorreos[i]);
                }
            }

            objetoCarrito.Correos_de_envio_excel__c = correos;
            update objetoCarrito;
        }
    }


    public boolean checkEmail() {
        //system.debug('Entro a validar correos');
        boolean error = false;
        string mensaje = 'Uno o mas correo no son validos verificalos de nuevo: <br>';
        integer numerar = 0;
        integer numcorreos = 0;
        if(string.isBlank(email01) && String.isBlank(email02) && String.isBlank(email03)){
            error = true;
            mensaje = 'No se detecto ningun correo. <br> Debe ingresar por lo menos un correo.';
        }
        else{
            if (string.isNotBlank(email01)){

                email01=email01.trim();
                email01=email01.toLowerCase();

                numcorreos++;
                if(email01.containsNone('@') || email01.containsNone('.')){
                    numerar++;
                    error = true;
                    mensaje += numerar+'.- '+email01+'<br>';
                }
            }
            if (string.isNotBlank(email02)){
                
                email02=email02.trim();
                email02=email02.toLowerCase();

                numcorreos++;
                if(email02.containsNone('@') || email02.containsNone('.')){
                    numerar++;
                    error = true;
                    mensaje += numerar+'.- '+ email02+'<br>';
                }
            }
            if (string.isNotBlank(email03)){

                email03=email03.trim();
                email03=email03.toLowerCase();

                numcorreos++;
                if(email03.containsNone('@') || email03.containsNone('.')){
                    numerar++;
                    error = true;
                    mensaje += numerar+'.- '+ email03+'<br>';
                }
            }
        }
            

            //nuevoLead.Fecha_de_nacimiento__c.addError('');
            ////system.debug('fue menor de edad');
        
        if(error){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, mensaje));
            return error;
        }else{
            arrayCorreos = new String[numcorreos];
            integer count =0;
            if (string.isNotBlank(email01)){
                arrayCorreos[count] = email01;
                count++;
            }
            if (string.isNotBlank(email02)){
                arrayCorreos[count] = email02;
                count++;
            }
            if (string.isNotBlank(email03)){
                arrayCorreos[count] = email03;
                count++;
            }

        }
        return error;
    }

    public void aumentarcampos(){
        aumentarCampo++;
    }

    //ir a una referencia

    public PageReference precalificacion(){

        PageReference precalificacion = page.Precalificacion_FormaPago;
        precalificacion.setRedirect(false);
        if(String.isNotBlank(idReferencia)){
            precalificacion.getParameters().put('id', idReferencia);
        }   
        return precalificacion;
        
    }

    public PageReference cancelarLead(){
        PageReference regresoinicio = new PageReference ('/001/o');
        return regresoinicio;
    }
    public PageReference envioficha(){
        //if(String.isNotBlank(idReferencia)){
            PageReference envioficha = Page.Envio_de_la_ficha;
            envioficha.setRedirect(false);
            envioficha.getParameters().put('id',idReferencia);
            return envioficha;
        //}
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Error al redireccionar'));
        //return null;
    }

    public PageReference stock(){
             
        PageReference stock = Page.ConsolaComercial;
        stock.setRedirect(false);

        if(!String.isBlank(idReferencia)){
            stock.getParameters().put('id',idReferencia);
        }

        //if(nuevoLead != null && nuevoLead.Id != null){
        //  stock.getParameters().put('id', nuevoLead.Id);
        //}
        //llenadoPaginas();
        return stock;
    }
    public PageReference citalead(){
             
        PageReference citalead = Page.Cita_Leads;
        citalead.setRedirect(false);

        if(idReferencia != null){
            citalead.getParameters().put('id', idReferencia);
        }

        return citalead;
    }
    
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
    }

}