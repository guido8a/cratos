<%@ page import="cratos.DocumentoEmpresa" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<div class="col2">

    <g:if test="${!documentoEmpresaInstance}">
        <elm:notFound elem="DocumentoEmpresa" genero="o" />
    </g:if>
    <g:else>
        <g:form class="form-horizontal" name="frmDocumentoEmpresa" role="form" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${documentoEmpresaInstance?.id}" />
            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'empresa', 'error')} ">
                <span class="grupo">
                    <label for="empresaNombre" class="col-md-4 control-label text-info">
                        Empresa
                    </label>
                    <div class="col-md-6">
                        <g:textField name="empresa.nombre" id="empresaNombre" value="${session.empresa}" class="form-control" readonly="true"/>
                    </div>
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'tipo', 'error')} ">
                <span class="grupo">
                    <label for="tipo" class="col-md-4 control-label text-info">
                        Tipo
                    </label>
                    <div class="col-md-6">
                        <g:select name="tipo" from="${lista}" optionKey="key" optionValue="value" class="form-control required" value="${documentoEmpresaInstance?.tipo}"/>
                    </div>
                </span>
            </div>


            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'autorizacion', 'error')} ">
                <span class="grupo">
                    <label for="autorizacion" class="col-md-4 control-label text-info">
                        Autorización
                    </label>
                    <div class="col-md-6">
                        <g:textField name="autorizacion" required="" class="allCaps form-control required validacionNumeroSinPuntos" value="${documentoEmpresaInstance?.autorizacion}"/>
                    </div>

                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroDesde', 'error')} ">
                <span class="grupo">
                    <label for="numeroDesde" class="col-md-4 control-label text-info">
                        Número Desde
                    </label>
                    <div class="col-md-6">
                        <g:textField name="numeroDesde" maxlength="15" value="${documentoEmpresaInstance.numeroDesde}" class="form-control validacionNumeroSinPuntos required" required=""/>
                    </div>

                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroHasta', 'error')} ">
                <span class="grupo">
                    <label for="numeroHasta" class="col-md-4 control-label text-info">
                        Número Hasta
                    </label>
                    <div class="col-md-6">
                        <g:textField name="numeroHasta" maxlength="15" value="${documentoEmpresaInstance.numeroHasta}" class="form-control validacionNumeroSinPuntos required" required=""/>
                    </div>
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEmision', 'error')} ">
                <span class="grupo">
                    <label for="numeroEmision" class="col-md-4 control-label text-info">
                        Número Emisión
                    </label>
                    <div class="col-md-3">
                        <g:textField name="numeroEmision" required="" maxlength="10" class="form-control validacionNumeroSinPuntos required" value="${documentoEmpresaInstance?.numeroEmision}"/>
                    </div>

                </span>
            </div>



            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEstablecimiento', 'error')} ">
                <span class="grupo">
                    <label for="numeroEstablecimiento" class="col-md-4 control-label text-info">
                        Número Establecimiento
                    </label>
                    <div class="col-md-3">
                        <g:textField name="numeroEstablecimiento" maxlength="10" required="" class="form-control validacionNumeroSinPuntos required" value="${documentoEmpresaInstance?.numeroEstablecimiento}"/>
                    </div>

                </span>
            </div>



            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'digitosEnSecuencial', 'error')} ">
                <span class="grupo">
                    <label for="digitosEnSecuencial" class="col-md-4 control-label text-info">
                        Dígitos En Secuencial
                    </label>
                    <div class="col-md-3">
                        <g:textField name="digitosEnSecuencial"  required="" class="form-control validacionNumeroSinPuntos required" value="${documentoEmpresaInstance?.digitosEnSecuencial}"/>

                    </div>

                </span>
            </div>


        %{--<div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaIngreso', 'error')} ">--}%
        %{--<span class="grupo">--}%
        %{--<label for="fechaIngreso" class="col-md-4 control-label text-info">--}%
        %{--Fecha Ingreso--}%
        %{--</label>--}%
        %{--<div class="col-md-4">--}%
        %{--<elm:datepicker name="fechaIngreso"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaIngreso}"  />--}%
        %{--</div>--}%

        %{--</span>--}%
        %{--</div>--}%

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaAutorizacion', 'error')} ">
                <span class="grupo">
                    <label for="fechaAutorizacion" class="col-md-4 control-label text-info">
                        Fecha Autorización
                    </label>
                    <div class="col-md-4">
                        <elm:datepicker name="fechaAutorizacion"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaAutorizacion}"  />
                    </div>

                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaInicio', 'error')} ">
                <span class="grupo">
                    <label for="fechaInicio" class="col-md-4 control-label text-info">
                        Válido Desde
                    </label>
                    <div class="col-md-4">
                        <elm:datepicker name="fechaInicio"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaInicio}"  />
                    </div>

                </span>
            </div>

            <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaFin', 'error')} ">
                <span class="grupo">
                    <label for="fechaFin" class="col-md-4 control-label text-info">
                        Válido Hasta
                    </label>
                    <div class="col-md-4">
                        <elm:datepicker name="fechaFin"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaFin}"  />
                    </div>
                </span>
            </div>
        </g:form>
    </g:else>
</div>

<script type="text/javascript">
    var validator = $("#frmDocumentoEmpresa").validate({
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


    function validarNumSinPuntos(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
        (ev.keyCode >= 96 && ev.keyCode <= 105) ||
        ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
        ev.keyCode == 37 || ev.keyCode == 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

</script>