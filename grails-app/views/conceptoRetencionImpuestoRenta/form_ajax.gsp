<%@ page import="cratos.ConceptoRetencionImpuestoRenta" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!conceptoRetencionImpuestoRentaInstance}">
    <elm:notFound elem="ConceptoRetencionImpuestoRenta" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmConceptoRetencionImpuestoRenta" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${conceptoRetencionImpuestoRentaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-3 control-label text-info">
                    Código
                </label>
                <div class="col-md-3">
                    <g:textField name="codigo" maxlength="4" required="" class="allCaps form-control required" value="${conceptoRetencionImpuestoRentaInstance?.codigo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textField name="descripcion" maxlength="63" required="" class="form-control required" value="${conceptoRetencionImpuestoRentaInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'porcentaje', 'error')} ">
            <span class="grupo">
                <label for="porcentaje" class="col-md-3 control-label text-info">
                    Porcentaje
                </label>
                <div class="col-md-3">
                    %{--<g:field name="porcentaje" type="number" value="${fieldValue(bean: conceptoRetencionImpuestoRentaInstance, field: 'porcentaje')}" class="number form-control  required" required=""/>--}%
                    <g:textField name="porcentaje" value="${conceptoRetencionImpuestoRentaInstance?.porcentaje}" class="form-control number required"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'modalidadPago', 'error')} ">
            <span class="grupo">
                <label for="modalidadPago" class="col-md-3 control-label text-info">
                    Modalidad de Pago
                </label>
                <div class="col-md-6">
                    <g:select id="modalidadPago" name="modalidadPago.id" from="${cratos.sri.ModalidadPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" required="" value="${conceptoRetencionImpuestoRentaInstance?.modalidadPago?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: conceptoRetencionImpuestoRentaInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-3 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-2">
                    <g:textField name="tipo" class="allCaps form-control" maxlength="1" value="${conceptoRetencionImpuestoRentaInstance?.tipo}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmConceptoRetencionImpuestoRenta").validate({
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