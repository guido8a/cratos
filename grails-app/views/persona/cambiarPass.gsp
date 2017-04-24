<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:form class="form-horizontal" name="frmPass" role="form" action="savePass_ajax" method="POST">
    <g:hiddenField name="id" value="${personaInstance?.id}"/>
    <g:hiddenField name="tipo" value="${tipo}"/>

    <div class="form-group">
        <span class="grupo">
            <label for="actu" class="col-md-4 control-label text-info">
                ${tipo == "pass" ? "Password" : "Autorización"} actual
            </label>

            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-unlock"></i></span>
                    <g:passwordField name="actu" class="form-control"/>
                </div>
            </div>
            *
        </span>
    </div>

    <div class="form-group">
        <span class="grupo">
            <label for="nuevo" class="col-md-4 control-label text-info">
                ${tipo == "pass" ? "Password" : "Autorización"} nuev${tipo == "pass" ? "o" : "a"}
            </label>

            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <g:passwordField name="nuevo" class="form-control"/>
                </div>
            </div>
            *
        </span>
    </div>

    <div class="form-group">
        <span class="grupo">
            <label for="nuevo2" class="col-md-4 control-label text-info">
                Repita ${tipo == "pass" ? "Password" : "Autorización"}
            </label>

            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    <g:passwordField name="nuevo2" equalTo="#nuevo" class="form-control"/>
                </div>
            </div>
            *
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmPass").validate({
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
        },
        rules          : {
            actu : {
                remote : {
                    url  : "${createLink(action: 'validarPass_ajax')}",
                    type : "post",
                    data : {
                        tipo : "${tipo}"
                    }
                }
            }
        },
        messages       : {
            actu : {
                remote : '${tipo == "pass" ? "Password" : "Autorización"} no coincide.'
            }
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitFormPass();
            return false;
        }
        return true;
    });
</script>