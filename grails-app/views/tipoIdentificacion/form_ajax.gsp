<%@ page import="cratos.TipoIdentificacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoIdentificacionInstance}">
    <elm:notFound elem="TipoIdentificacion" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipoIdentificacion" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${tipoIdentificacionInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: tipoIdentificacionInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-3 control-label text-info">
                    Código
                </label>

                <div class="col-md-7">
                    <g:textField name="codigo" maxlength="4" required="" class="allCaps form-control required"
                                 value="${tipoIdentificacionInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoIdentificacionInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-7">
                    <g:textField name="descripcion" maxlength="63" required="" class="allCaps form-control required"
                                 value="${tipoIdentificacionInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoIdentificacionInstance, field: 'tipoAnexo', 'error')} ">
            <span class="grupo">
                <label for="tipoAnexo" class="col-md-3 control-label text-info">
                    Tipo de Anexo
                </label>

                <div class="col-md-7">
                    <g:select name="tipoAnexo" from="${tipoIdentificacionInstance.constraints.tipoAnexo.inList}"
                              class="form-control" value="${tipoIdentificacionInstance?.tipoAnexo}"
                              valueMessagePrefix="tipoIdentificacion.tipoAnexo" noSelection="['': '']"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: tipoIdentificacionInstance, field: 'codigoSri', 'error')} ">
            <span class="grupo">
                <label for="codigoSri" class="col-md-3 control-label text-info">
                    Codigo SRI
                </label>

                <div class="col-md-7">
                    <g:textField name="codigoSri" maxlength="2" class="allCaps form-control"
                                 value="${tipoIdentificacionInstance?.codigoSri}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipoIdentificacion").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
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