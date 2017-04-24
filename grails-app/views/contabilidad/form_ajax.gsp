<%@ page import="cratos.Contabilidad" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!contabilidadInstance}">
    <elm:notFound elem="Contabilidad" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmContabilidad" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${contabilidadInstance?.id}"/>

        <g:if test="${contabilidadInstance?.id}">
        %{--<div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'fechaInicio', 'error')} required">--}%
        %{--<span class="grupo">--}%
        %{--<label for="fechaInicio" class="col-md-2 control-label text-info">--}%
        %{--Fecha Inicio--}%
        %{--</label>--}%

        %{--<div class="col-md-4">--}%
        %{--<elm:datepicker name="fechaInicio" title="Fecha de inicio del periodo comtable" class="datepicker form-control required" value="${contabilidadInstance?.fechaInicio}"/>--}%
        %{--</div>--}%
        %{--*--}%
        %{--</span>--}%
        %{--</div>--}%

        %{--<div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'fechaCierre', 'error')} ">--}%
        %{--<span class="grupo">--}%
        %{--<label for="fechaCierre" class="col-md-2 control-label text-info">--}%
        %{--Fecha Cierre--}%
        %{--</label>--}%

        %{--<div class="col-md-4">--}%
        %{--<elm:datepicker name="fechaCierre" title="Fecha de cierre del periodo comtable" class="datepicker form-control" value="${contabilidadInstance?.fechaCierre}"/>--}%
        %{--</div>--}%

        %{--</span>--}%
        %{--</div>--}%

            <div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'prefijo', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        Año
                    </label>

                    <div class="col-md-6">
                        <p class="form-control-static">
                            <g:formatDate date="${contabilidadInstance?.fechaInicio}" format="yyyy"/>
                            (de <g:formatDate date="${contabilidadInstance?.fechaInicio}" format="dd-MM-yyyy"/> a
                            <g:formatDate date="${contabilidadInstance?.fechaCierre}" format="dd-MM-yyyy"/>)

                        </p>
                    </div>

                </span>
            </div>
        </g:if>
        <g:else>

            <div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'prefijo', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        Año
                    </label>

                    <div class="col-md-2">
                        <g:textField name="anio" maxlength="4" class="digits form-control" value=""/>
                    </div>

                </span>
            </div>

        </g:else>
        <div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'prefijo', 'error')} ">
            <span class="grupo">
                <label for="prefijo" class="col-md-2 control-label text-info">
                    Prefijo
                </label>

                <div class="col-md-3">
                    <g:textField name="prefijo" maxlength="8" class="allCaps form-control" value="${contabilidadInstance?.prefijo}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: contabilidadInstance, field: 'descripcion', 'error')} required">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" required="" class="allCaps form-control required" value="${contabilidadInstance?.descripcion}"/>
                </div>
                *
            </span>
        </div>
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmContabilidad").validate({
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