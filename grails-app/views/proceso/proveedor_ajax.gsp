<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/05/17
  Time: 13:20
--%>
<g:if test="${tipo != 'N'}">
    <div class="col-md-2 negrilla">
        Proveedor:
    </div>

    <div class="col-md-10 negrilla">
        <div class="col-md-2" style="margin-left: -15px;">
            <input type="text" name="proveedor.ruc" class="form-control proveedor" id="prve" readonly
                   value="${proceso?.proveedor?.ruc ?: proveedor?.ruc}" title="RUC del proveedor o cliente"
                   style="width: 130px"
                   placeholder="RUC"/>
        </div>

        <div class="col-md-5" style="margin-left: -15px">
            <input type="text" name="proveedor.nombre" class="form-control label-shared proveedor" id="prve_nombre"
                   readonly value="${proceso?.proveedor?.nombre ?: proveedor?.nombre}" title="Nombre del proveedor o cliente"
                   style="width: 100%" placeholder="Nombre"/>
        </div>

        <div class="col-md-1" style="margin-left: -25px; margin-right: 10px">
            <input type="text" name="proveedor.relacionado" class="form-control label-shared proveedor" id="prve_rlcn"
                   readonly value="Rel: ${proceso?.proveedor?.relacionado}" title="Relacionado" style="width: 76px"
                   placeholder="Rel."/>
        </div>

        <div class="col-md-4">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info">
                    <i class="fa fa-search"></i>
                </a>
            </g:if>
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_ingresar" class="btn btn-info">
                    <i class="fa fa-pencil"></i>
                </a>
            </g:if>
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_cargar" class="btn btn-info">
                    <i class="fa fa-check"></i>
                </a>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prve_id" value="${proceso?.proveedor?.id}">
    </div>
</g:if>
<g:else>
    <div class="col-md-2 negrilla">
        Cliente:
    </div>

    <div class="col-md-9 negrilla">
        <div class="col-md-3" style="margin-left: -15px">
            <input type="text" name="proveedor.ruc" class="form-control proveedor" id="prve" readonly
                   value="${proceso?.proveedor?.ruc ?: proveedor.ruc}" title="RUC del proveedor o cliente" style="width: 140px"
                   placeholder="RUC"/>
        </div>

        <div class="col-md-5" style="margin-left: -55px">
            <input type="text" name="proveedor.nombre" class="form-control label-shared proveedor" id="prve_nombre"
                   readonly value="${proceso?.proveedor?.nombre ?: proveedor.nombre}" title="Nombre del proveedor o cliente"
                   style="width: 300px" placeholder="Nombre"/>
        </div>

        <div class="col-md-2">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prve_id" value="${proceso?.proveedor?.id}">
    </div>
</g:else>

<script type="text/javascript">
    $("#btn_buscar").click(function () {
//        console.log("clickf2222")
        $('#modal-proveedor').modal('show')
    });

    $(".proveedor").dblclick(function(){
        $("#btn_buscar").click()
    });

    $("#btn_cargar").click(function(){
        if($("#tipoProceso").val() == 'C' || $("#tipoProceso").val() == 'V')
        cargarSstr($("#prve__id").val())
    });
</script>
