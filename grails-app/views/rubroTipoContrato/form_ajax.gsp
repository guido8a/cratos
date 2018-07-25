<%@ page import="cratos.RubroTipoContrato" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!rubroTipoContratoInstance}">
    <elm:notFound elem="RubroTipoContrato" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmRubroTipoContrato" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${rubroTipoContratoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'tipoContrato', 'error')} ">
            <span class="grupo">
                <label for="tipoContrato" class="col-md-3 control-label text-info">
                    Tipo de Contrato
                </label>
                <div class="col-md-6">
                    <g:select id="tipoContrato" name="tipoContrato.id" from="${tipoContrato}" optionKey="id" optionValue="descripcion" required="" value="${rubroTipoContratoInstance?.tipoContrato?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'rubro', 'error')} ">
            <span class="grupo">
                <label for="rubro" class="col-md-3 control-label text-info">
                    Rubro
                </label>
                <div class="col-md-6">
                    <g:select id="rubro" name="rubro.id" from="${cratos.Rubro.list()}" optionKey="id" required="" value="${rubroTipoContratoInstance?.rubro?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'editable', 'error')} ">
            <span class="grupo">
                <label for="editable" class="col-md-3 control-label text-info">
                    Editable
                </label>
                <div class="col-md-4">
                    <g:select name="editable" from="${['1':'SI', '0': 'NO']}" optionValue="value" optionKey="key" class=" form-control required" value="${rubroTipoContratoInstance?.editable}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'decimo', 'error')} ">
            <span class="grupo">
                <label for="decimo" class="col-md-3 control-label text-info">
                    Décimo
                </label>
                <div class="col-md-4">
                    %{--<g:textField name="decimo" maxlength="1" required="" class="allCaps form-control required" value="${rubroTipoContratoInstance?.decimo}"/>--}%
                    <g:select from="${['1':'SI', '0': 'NO']}" name="decimo" optionKey="key" optionValue="value" class="form-control required" value="${rubroTipoContratoInstance?.decimo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'iess', 'error')} ">
            <span class="grupo">
                <label for="iess" class="col-md-3 control-label text-info">
                    Iess
                </label>
                <div class="col-md-4">
                    %{--<g:textField name="iess" maxlength="1" required="" class="allCaps form-control required" value="${rubroTipoContratoInstance?.iess}"/>--}%
                    <g:select from="${['1':'SI', '0': 'NO']}" name="iess" optionValue="value" optionKey="key" class="form-control required" value="${rubroTipoContratoInstance?.iess}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'gravable', 'error')} ">
            <span class="grupo">
                <label for="gravable" class="col-md-3 control-label text-info">
                    Gravable
                </label>
                <div class="col-md-4">
                    %{--<g:textField name="gravable" maxlength="1" required="" class="allCaps form-control required" value="${rubroTipoContratoInstance?.gravable}"/>--}%
                    <g:select from="${['1':'SI', '0': 'NO']}" name="gravable" optionKey="key" optionValue="value" class="form-control required" value="${rubroTipoContratoInstance?.gravable}"/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'valor', 'error')} ">
            <span class="grupo">
                <label for="valor" class="col-md-3 control-label text-info">
                    Valor
                </label>
                <div class="col-md-4">
                    <g:textField name="valor" value="${rubroTipoContratoInstance?.valor}" class="number form-control required" required=""/>
                </div>
                
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'porcentaje', 'error')} ">
            <span class="grupo">
                <label for="porcentaje" class="col-md-3 control-label text-info">
                    Porcentaje
                </label>
                <div class="col-md-4">
                    <g:textField name="porcentaje"  value="${rubroTipoContratoInstance?.porcentaje}" class="number form-control  required" required=""/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: rubroTipoContratoInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-3 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-6">
                    <g:textField name="observaciones" maxlength="127" class="allCaps form-control" value="${rubroTipoContratoInstance?.observaciones}"/>
                </div>
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmRubroTipoContrato").validate({
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