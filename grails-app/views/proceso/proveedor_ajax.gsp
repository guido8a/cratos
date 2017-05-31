<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 23/05/17
  Time: 13:20
--%>
<g:if test="${tipo != 'N'}">
    <div class="col-xs-2 negrilla">
        Proveedor:
    </div>
    <div class="col-xs-9 negrilla">
        <div class="col-xs-3" style="margin-left: -15px">
            <input type="text" name="proveedor.ruc" class="form-control " id="prov" disabled="true" value="${proceso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" style="width: 140px" placeholder="RUC"/>
        </div>
        <div class="col-xs-5" style="margin-left: -55px">
            <input type="text" name="proveedor.nombre" class="form-control  label-shared" id="prov_nombre" disabled="true" value="${proceso?.proveedor?.nombre ?: ''}" title="Nombre del proveedor o cliente" style="width: 300px" placeholder="Nombre"/>
        </div>
        <div class="col-xs-2">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prov_id" value="${proceso?.proveedor?.id}">
    </div>
</g:if>
<g:else>
    <div class="col-xs-2 negrilla">
        Cliente:
    </div>
    <div class="col-xs-9 negrilla">
        <div class="col-xs-3" style="margin-left: -15px">
            <input type="text" name="proveedor.ruc" class="form-control " id="prov" disabled="true" value="${proceso?.proveedor?.ruc ?: ''}" title="RUC del proveedor o cliente" style="width: 140px" placeholder="RUC"/>
        </div>
        <div class="col-xs-5" style="margin-left: -55px">
            <input type="text" name="proveedor.nombre" class="form-control  label-shared" id="prov_nombre" disabled="true" value="${proceso?.proveedor?.nombre ?: ''}" title="Nombre del proveedor o cliente" style="width: 300px" placeholder="Nombre"/>
        </div>
        <div class="col-xs-2">
            <g:if test="${proceso?.estado != 'R'}">
                <a href="#" id="btn_buscar" class="btn btn-info">
                    <i class="fa fa-search"></i>
                    Buscar
                </a>
            </g:if>
        </div>
        <input type="hidden" name="proveedor.id" id="prov_id" value="${proceso?.proveedor?.id}">
    </div>
</g:else>

<script type="text/javascript">
    $("#btn_buscar").click(function(){
        $('#modal-proveedor').modal('show')
    });
</script>
