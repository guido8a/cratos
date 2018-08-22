<%@ page import="cratos.DetallePago" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!detallePagoInstance}">
    <elm:notFound elem="DetallePago" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDetallePago" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${detallePagoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: detallePagoInstance, field: 'rubroTipoContrato', 'error')} ">
            <span class="grupo">
                <label for="rubroTipoContrato" class="col-md-3 control-label text-info">
                    Rubro Tipo Contrato
                </label>
                <div class="col-md-6">
                    <g:select id="rubroTipoContrato" name="rubroTipoContrato.id"
                              from="${rubroTipoContrato.sort{it.descripcion}}" optionKey="id" optionValue="descripcion"
                              value="${detallePagoInstance?.rubroTipoContrato?.id}"
                              class="many-to-one form-control"/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detallePagoInstance, field: 'empleado', 'error')} ">
            <span class="grupo">
                <label for="empleado" class="col-md-3 control-label text-info">
                    Empleado
                </label>
                <div class="col-md-6">
                    %{--<g:select id="empleado" name="empleado.id" from="${cratos.Empleado.list()}" optionKey="id" value="${detallePagoInstance?.empleado?.id}" class="many-to-one form-control" noSelection="['null': '']"/>--}%
                    <g:select id="empleado" name="empleado.id"
                              from="${empleados}" optionKey="id" optionValue="${{it?.persona?.apellido +  " " + it?.persona?.nombre}}"
                              value="${detallePagoInstance?.empleado?.id}"
                              class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detallePagoInstance, field: 'rolPagos', 'error')} ">
            <span class="grupo">
                <label for="rolPagos" class="col-md-3 control-label text-info">
                    Rol de Pagos
                </label>
                <div class="col-md-6">
                    <g:select id="rolPagos" name="rolPagos.id" from="${roles}" optionKey="id" optionValue="${{it.anio.anio + " - " + it.mess.descripcion}}"
                              value="${detallePagoInstance?.rolPagos?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detallePagoInstance, field: 'valor', 'error')} ">
            <span class="grupo">
                <label for="valor" class="col-md-3 control-label text-info">
                    Valor
                </label>
                <div class="col-md-6">
                    <g:textField name="valor" value="${detallePagoInstance?.valor}" class="number form-control  required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: detallePagoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textArea style="resize: none; height: 120px" name="descripcion" maxlength="124" class="form-control" value="${detallePagoInstance?.descripcion}"/>
                </div>
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmDetallePago").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            }
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>