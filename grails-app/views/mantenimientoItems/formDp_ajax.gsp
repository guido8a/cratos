<%@ page import="cratos.inventario.DepartamentoItem" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:form class="form-horizontal" name="frmItem" role="form" action="saveDp_ajax" method="POST">
    <g:hiddenField name="id" value="${departamentoItemInstance?.id}"/>
    <g:hiddenField name="subgrupo.id" value="${subgrupo?.id}"/>

    <h3 style="text-align: center">${subgrupo.descripcion}</h3>
    <br>

    <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'codigo', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Código
            </label>

            <g:set var="cd1" value="${subgrupo.codigo.toString().padLeft(3, '0')}"/>

            <div class="col-md-5 grupo">

                <g:if test="${departamentoItemInstance.id}">
                    ${cd1}.${departamentoItemInstance?.codigo?.toString()?.padLeft(3, '0')}
                </g:if>
                <g:else>
                    <span class="col-md-2">${cd1}.</span>
                    <span class="col-md-5">
                    <g:textField name="codigo" class="form-control required" maxlength="3"
                                 value="${departamentoItemInstance.id ? departamentoItemInstance.codigo.toString().padLeft(3, '0') : ''}"/>
                    <p class="help-block ui-helper-hidden"></p>
                    </span>
                </g:else>
            </div>

        </span>
    </div>

    <div class="form-group ${hasErrors(bean: departamentoItemInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Subgrupo
            </label>

            <div class="col-md-9">
                <g:textField name="descripcion" class="form-control required"
                             value="${departamentoItemInstance?.descripcion}" maxlength="63"
                             style="width: 360px;"/>

            </div>
        </span>
    </div>

</g:form>

%{--


<div id="create" class="span" role="main">
    <g:form class="form-horizontal" name="frmSave" action="saveDp_ajax">
        <g:hiddenField name="id" value="${departamentoItemInstance?.id}"/>

        <div class="control-group">
            <div>
                <span class="control-label label label-inverse">
                    Descripción
                </span>
            </div>

            <div class="controls">
                <g:textArea cols="5" rows="3" name="descripcion" style="resize: none; height: 50px" maxlength="63" class="allCaps required input-xxlarge" value="${departamentoItemInstance?.descripcion}"/>
                <span class="mandatory">*</span>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </div>

    </g:form>
</div>
--}%

<script type="text/javascript">

    //    $(".allCaps").keyup(function () {
    //        this.value = this.value.toUpperCase();
    //    });

    $("#frmSave").validate({
        rules          : {
            codigo      : {
                remote : {
                    url  : "${createLink(action:'checkCdDp_ajax')}",
                    type : "post",
                    data : {
                        id : "${departamentoItemInstance?.id}",
                        sg : "${subgrupo.id}"
                    }
                }
            },
            descripcion : {
                remote : {
                    url  : "${createLink(action:'checkDsDp_ajax')}",
                    type : "post",
                    data : {
                        id : "${departamentoItemInstance?.id}"
                    }
                }
            }
        },
        messages       : {
            codigo      : {
                remote : "El código ya se ha ingresado para otro item"
            },
            descripcion : {
                remote : "La descripción ya se ha ingresado para otro item"
            }
        },
        errorPlacement : function (error, element) {
            element.parent().find(".help-block").html(error).show();
        },
        success        : function (label) {
            label.parent().hide();
        },
        errorClass     : "label label-important"
    });
</script>
