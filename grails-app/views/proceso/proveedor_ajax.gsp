<g:if test="${(tipo == '1' || tipo == '4')}">
    <div class="col-xs-2 negrilla">
        Proveedor:
    </div>

    <div class="col-xs-10 negrilla">
        <div class="col-xs-2" style="margin-left: -15px;">
            <input type="text" name="proveedor?.ruc" class="form-control proveedor" id="prve" readonly
                   value="${proceso?.proveedor?.ruc ?: proveedor?.ruc}" title="RUC del proveedor o cliente"
                   style="width: 130px"
                   placeholder="RUC"/>
        </div>

        <div class="col-xs-5" style="margin-left: -15px">
            <input type="text" name="proveedor?.nombre" class="form-control label-shared proveedor" id="prve_nombre"
                   readonly value="${proceso?.proveedor?.nombre ?: proveedor?.nombre}" title="Nombre del proveedor o cliente"
                   style="width: 100%" placeholder="Nombre"/>
        </div>

        <div class="col-xs-1" style="margin-left: -25px; margin-right: 10px">
            <input type="text" name="proveedor.relacionado" class="form-control label-shared proveedor" id="prve_rlcn"
                   readonly value="Rel: ${proceso?.proveedor?.relacionado}" title="Relacionado" style="width: 76px"
                   placeholder="Rel."/>
        </div>

        <div class="col-xs-4">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info" title="Buscar proveedor">
                    <i class="fa fa-search"></i>
                </a>
            </g:if>
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_editar" class="btn btn-info" title="Editar proveedor">
                    <i class="fa fa-pencil"></i>
                </a>
            </g:if>
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_crear" class="btn btn-info" title="Crear proveedor">
                    <i class="fa fa-plus"></i>
                </a>
            </g:if>
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_cargar" class="btn btn-info" title="Aceptar proveedor">
                    <i class="fa fa-check"></i>
                </a>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prve_id" value="${proceso?.proveedor?.id}">
    </div>
</g:if>
<g:elseif test="${tipo == '2' || tipo == '5' || tipo == '6' || tipo == '7'}">
    <div class="col-xs-2 negrilla">
        Cliente:
    </div>

    <div class="col-xs-10 negrilla">
        <div class="col-xs-2" style="margin-left: -15px">
            <input type="text" name="proveedor?.ruc" class="form-control proveedor" id="prve" readonly
                   value="${proceso?.proveedor?.ruc ?: proveedor?.ruc}" title="RUC del proveedor o cliente"
                   style="width: 130px"
                   placeholder="RUC" idP="${proveedor?.id}"/>
        </div>

        <div class="col-xs-5" style="margin-left: -15px">
            <input type="text" name="proveedor?.nombre" class="form-control label-shared proveedor" id="prve_nombre"
                   readonly value="${proceso?.proveedor?.nombre ?: proveedor?.nombre}" title="Nombre del proveedor o cliente"
                   style="width: 300px" placeholder="Nombre"/>
        </div>

        <div class="col-xs-4">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info" title="Buscar cliente">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
                <g:if test="${proceso?.estado != 'R'}">
                    <a href="#" id="btn_editar" class="btn btn-info" title="Editar cliente">
                        <i class="fa fa-pencil"></i>
                    </a>
                </g:if>
                <g:if test="${proceso?.estado != 'R'}">
                    <a href="#" id="btn_crear" class="btn btn-info" title="Crear cliente">
                        <i class="fa fa-plus"></i>
                    </a>
                </g:if>
                <g:if test="${proceso?.estado != 'R'}">
                    <a href="#" id="btn_cargarCl" class="btn btn-info" title="Aceptar cliente">
                        <i class="fa fa-check"></i>
                    </a>
                </g:if>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prve_id" value="${proceso?.proveedor?.id}">
    </div>
</g:elseif>

<script type="text/javascript">


    $("#btn_crear").click(function () {
        crearEditar(null, false)
    });


    $("#btn_editar").click(function () {
        var pro = $("#prve__id").val();
        if(pro != ''){
            crearEditar(pro, true);
        }
    });

    function crearEditar(id, edi) {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'proveedor', action: 'form_ajax')}',
            data:{
                id: id,
                edi: edi
            },
            success: function (msg){
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Editar Proveedor",
                    class: "long",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").not(".datepicker").first().focus()
                }, 500);
            }
        });
    }

    function submitForm() {
        var $form = $("#frmProveedor");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "ok" ? "success" : "error"); // log(msg, type, title, hide)
//                    console.log('retorna', parts[1])
                    if (parts[0] == "ok") {
                        setTimeout(function () {
                            closeLoader();
                        }, 1000);
                        var tipo = $(".tipoProcesoSel option:selected").val();
                        $("#prve__id").val(parts[1]);
                        cargarProveedor(tipo)
                    } else {
                        closeLoader();
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    $("#btn_buscar").click(function () {
//        console.log("btn_buscar")
        $('#modal-proveedor').modal('show')
        $("#resultados").html('')

        if(!'${proceso}'){
            $("#comprobanteDesc").val('');
            $("#comprobanteDoc").val('');
            $("#comprobanteSaldo").val('');
        }

    });

    $(".proveedor").dblclick(function(){
        $("#btn_buscar").click()
    });

    $("#btn_cargar").click(function(){
        var tipo = $("#tipoProceso").val()
//        console.log("btn_cargar, tipo:", tipo);
//        console.log("ruc: ", $("#prve").val());
        if($("#prve").val() != '' && (tipo == '1'))
            cargarSstr($("#prve__id").val())
        if($("#prve").val() != '' && (tipo == '4' || tipo == '6' || tipo == '7'))
//            console.log('remueve hide...')
            $("#btnBuscarComp").removeClass('hidden')
    });

    $("#btn_cargarCl").click(function(){
        var tipo = $("#tipoProceso").val()
        var prve = $("#prve__id").val()
//        console.log("ttpp: ", $("#tipoProceso").val());
        if($("#prve").val() != '' && (tipo == '6' || tipo == '7'  || tipo == '5'))
            $("#btnBuscarComp").removeClass('hidden')
        if($("#prve").val() != '' && (tipo == '2'))
            cargarTcsr(prve)
    });
</script>
