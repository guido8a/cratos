<%@ page import="cratos.TipoComprobanteId" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoComprobanteIdInstance}">
    <elm:notFound elem="TipoComprobanteId" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoComprobanteId" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoComprobanteIdInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoComprobanteIdInstance, field: 'tipoIdentificacion', 'error')} required">
            <span class="grupo">
                <label for="tipoIdentificacion" class="col-md-5 control-label text-info">
                    Tipo de Identificación
                </label>

                <div class="col-md-6">
                    <g:select id="tipoIdentificacion" name="tipoIdentificacion.id" from="${cratos.TipoIdentificacion.list()}" optionKey="id" required="" optionValue="descripcion" value="${tipoComprobanteIdInstance?.tipoIdentificacion?.id}" class="many-to-one form-control"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoComprobanteIdInstance, field: 'tipoComprobanteSri', 'error')} required">
            <span class="grupo">
                <label for="tipoComprobanteSri" class="col-md-5 control-label text-info">
                    Tipo de Comprobante Sri
                </label>

                <div class="col-md-6">
                    <g:select id="tipoComprobanteSri" name="tipoComprobanteSri.id" from="${cratos.TipoComprobanteSri.list()}" optionKey="id" required="" optionValue="descripcion" value="${tipoComprobanteIdInstance?.tipoComprobanteSri?.id}" class="many-to-one form-control"/>
                </div>
                *
            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoComprobanteId").validate({
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