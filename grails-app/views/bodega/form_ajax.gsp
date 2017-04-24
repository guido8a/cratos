<%@ page import="cratos.Bodega" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!bodegaInstance}">
    <elm:notFound elem="Bodega" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmBodega" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${bodegaInstance?.id}"/>


        <div class="form-group ${hasErrors(bean: bodegaInstance, field: 'codigo', 'error')} required">
            <span class="grupo">
                <label for="codigo" class="col-md-3 control-label text-info">
                    Código
                </label>

                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="8" class="allCaps form-control required"
                                 value="${bodegaInstance?.codigo}"/>
                </div>
                *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: bodegaInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="40" class="form-control required"
                                 value="${bodegaInstance?.descripcion}"/>
                </div>
               *
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: bodegaInstance, field: 'centroCosto', 'error')} ">
            <span class="grupo">
                <label for="centroCosto" class="col-md-3 control-label text-info">
                    Centro de Costo
                </label>

                <div class="col-md-6">
                    <g:select id="centroCosto" name="centroCosto.id" from="${cratos.CentroCosto.list()}" optionKey="id" optionValue="nombre"
                              value="${bodegaInstance?.centroCosto?.id}" class="many-to-one form-control"
                              noSelection="['null': '']"/>
                </div>

            </span>
        </div>



    </g:form>

    <script type="text/javascript">
        var validator = $("#frmBodega").validate({
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