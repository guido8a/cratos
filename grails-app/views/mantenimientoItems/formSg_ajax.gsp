<%@ page import="cratos.inventario.SubgrupoItems" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:form class="form-horizontal" name="frmItem" role="form" action="saveSg_ajax" method="POST">
    <g:hiddenField name="id" value="${subgrupoItemsInstance?.id}"/>
    <g:hiddenField name="grupo.id" value="${grupo.id}"/>
    <h3 style="text-align: center">${grupo.descripcion}</h3>
    <br>

    <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'codigo', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Código
            </label>

            <div class="col-md-9">
            %{--<p class="form-control-static">${cuentaInstance?.padre ?: "No tiene padre"}</p>--}%
                <g:if test="${subgrupoItemsInstance?.id}">
                    ${subgrupoItemsInstance.codigo.toString().padLeft(3, '0')}
                </g:if>
                <g:else>
                    <g:textField name="codigo" class="form-control allCaps required input-small" style="width: 60px;"
                                 value="${subgrupoItemsInstance?.id ? subgrupoItemsInstance.codigo.toString().padLeft(3, '0') : ''}"
                                 maxlength="4"/>
                    <p class="help-block ui-helper-hidden"></p>
                </g:else>
            </div>

        </span>
    </div>

    <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Nombre del grupo
            </label>

            <div class="col-md-9">
                <g:textField name="descripcion" class="form-control required"
                             value="${subgrupoItemsInstance?.descripcion}" maxlength="63"
                             style="width: 360px;"/>
            </div>

        </span>
    </div>

</g:form>


<script type="text/javascript">

    //    $(".allCaps").keyup(function () {
    //        this.value = this.value.toUpperCase();
    //    });

    var validator = $("#frmItem").validate({
        errorClass: "help-block",
        rules: {
            descripcion: {
                remote: {
                    url: "${createLink(action:'checkDsSg_ajax')}",
                    type: "post",
                    data: {
                        id: "${subgrupoItemsInstance?.id}"
                    }
                }
            }
        },
        messages: {
            descripcion: {
                remote: "La descripción ya se ha ingresado para otro item"
            }
        },
        errorPlacement: function (error, element) {
            element.parent().find(".help-block").html(error).show();
        },
        success: function (label) {
            label.parent().hide();
        },
        errorClass: "label label-important"
    });



</script>
