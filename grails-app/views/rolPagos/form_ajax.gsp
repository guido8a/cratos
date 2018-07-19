<%@ page import="cratos.RolPagos" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!rolPagosInstance}">
    <elm:notFound elem="RolPagos" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmRolPagos" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${rolPagosInstance?.id}" />

        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'anio', 'error')} ">
            <span class="grupo">
                <label for="anio" class="col-md-2 control-label text-info">
                    Año
                </label>
                <div class="col-md-6">
                    <g:select id="anio" name="anio.id" from="${cratos.Anio.list()}" optionKey="id" optionValue="anio" value="${rolPagosInstance?.anio?.id}" class="many-to-one form-control"/>
                </div>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'mess', 'error')} ">
            <span class="grupo">
                <label for="mess" class="col-md-2 control-label text-info">
                    Mes
                </label>
                <div class="col-md-6">
                    <g:select id="mess" name="mess.id" from="${cratos.Mes.list()}" optionKey="id" optionValue="descripcion" value="${rolPagosInstance?.mess?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        

        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'fecha', 'error')} ">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-6">
                    <elm:datepicker name="fecha" title="fecha"  class="datepicker form-control" value="${rolPagosInstance?.fecha}" default="none" noSelection="['': '']" />
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'pagado', 'error')} ">
            <span class="grupo">
                <label for="pagado" class="col-md-2 control-label text-info">
                    Pagado
                </label>
                <div class="col-md-6">
                    <g:textField name="pagado" value="${rolPagosInstance?.pagado}" class="number form-control required" required=""/>

                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'estado', 'error')} ">
            <span class="grupo">
                <label for="estado" class="col-md-2 control-label text-info">
                    Estado
                </label>
                <div class="col-md-6">
                    %{--<g:textField name="estado" maxlength="1" class="allCaps form-control" value="${rolPagosInstance?.estado}"/>--}%
                    <g:select from="${["N": "No Aprobado", "A":"Aprobado"]}" name="estado" optionValue="value" optionKey="key" value="${rolPagosInstance?.estado}" class="form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rolPagosInstance, field: 'empresa', 'error')} ">
            <span class="grupo">
                <label for="empresa" class="col-md-2 control-label text-info">
                    Empresa
                </label>
                <div class="col-md-6">
                    <g:if test="${session.perfil.nombre == 'Administrador General'}">
                        <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" optionValue="nombre" required="" value="${rolPagosInstance?.empresa?.id}" class="many-to-one form-control"/>
                    </g:if>
                    <g:else>
                        <g:textField id="empresa" name="empresa.id" required="" value="${session.empresa.nombre}" readonly="true" class="form-control"/>
                    </g:else>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmRolPagos").validate({
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