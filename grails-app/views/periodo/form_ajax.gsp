<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 09/08/22
  Time: 14:50
--%>

<%@ page import="cratos.Contabilidad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
%{--<g:if test="${!contabilidadInstance}">--}%
    %{--<elm:notFound elem="Contabilidad" genero="o"/>--}%
%{--</g:if>--}%
%{--<g:else>--}%
    <g:form class="form-horizontal" name="frmPeriodo" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${periodoInstance?.id}"/>

            <div class="form-group ${hasErrors(bean: periodoInstance, field: 'fechaInicio', 'error')} required">
                <span class="grupo">
                    <label for="fechaInicio" class="col-md-4 control-label text-info">
                        Fecha Inicio
                    </label>

                    <div class="col-md-4">
                        <elm:datepicker name="fechaInicio" title="Fecha de inicio del período" class="datepicker form-control required" value="${periodoInstance?.fechaInicio}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: periodoInstance, field: 'fechaFin', 'error')} ">
                <span class="grupo">
                    <label for="fechaCierre" class="col-md-4 control-label text-info">
                        Fecha Cierre
                    </label>

                    <div class="col-md-4">
                        <elm:datepicker name="fechaCierre" title="Fecha de cierre del período" class="datepicker form-control required" value="${periodoInstance?.fechaFin}"/>
                    </div>
                    *
                </span>
            </div>


        <div class="form-group ${hasErrors(bean: periodoInstance, field: 'numero', 'error')} ">
            <span class="grupo">
                <label for="numero" class="col-md-4 control-label text-info">
                    Número del período
                </label>

                <div class="col-md-2">
                    <g:textField name="numero" maxlength="2" class="form-control required digits" value="${periodoInstance?.numero}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPeriodo").validate({
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

%{--</g:else>--}%