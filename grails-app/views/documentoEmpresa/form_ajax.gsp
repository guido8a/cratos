<%@ page import="cratos.DocumentoEmpresa" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!documentoEmpresaInstance}">
    <elm:notFound elem="DocumentoEmpresa" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDocumentoEmpresa" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${documentoEmpresaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'empresa', 'error')} ">
            <span class="grupo">
                <label for="empresa" class="col-md-3 control-label text-info">
                    Empresa
                </label>
                <div class="col-md-6">
                    %{--<g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id"--}%
                              %{--required="" value="${documentoEmpresaInstance?.empresa?.id}" class="many-to-one form-control"/>--}%

                    <g:textField name="empresa.id" id="empresa" value="${session.empresa}" class="form-control" readonly="true"/>

                </div>
                
            </span>
        </div>
        

        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'autorizacion', 'error')} ">
            <span class="grupo">
                <label for="autorizacion" class="col-md-3 control-label text-info">
                    Autorizacion
                </label>
                <div class="col-md-6">
                    <g:textField name="autorizacion" required="" class="allCaps form-control required" value="${documentoEmpresaInstance?.autorizacion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroDesde', 'error')} ">
            <span class="grupo">
                <label for="numeroDesde" class="col-md-3 control-label text-info">
                    Numero Desde
                </label>
                <div class="col-md-6">
                    <g:field name="numeroDesde" type="number" value="${documentoEmpresaInstance.numeroDesde}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroHasta', 'error')} ">
            <span class="grupo">
                <label for="numeroHasta" class="col-md-3 control-label text-info">
                    Numero Hasta
                </label>
                <div class="col-md-6">
                    <g:field name="numeroHasta" type="number" value="${documentoEmpresaInstance.numeroHasta}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>
        

        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-3 control-label text-info">
                    Tipo
                </label>
                <div class="col-md-6">
                    <g:textField name="tipo" required="" class="allCaps form-control required" value="${documentoEmpresaInstance?.tipo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEstablecimiento', 'error')} ">
            <span class="grupo">
                <label for="numeroEstablecimiento" class="col-md-3 control-label text-info">
                    Numero Establecimiento
                </label>
                <div class="col-md-6">
                    <g:textField name="numeroEstablecimiento" required="" class="allCaps form-control required" value="${documentoEmpresaInstance?.numeroEstablecimiento}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEmision', 'error')} ">
            <span class="grupo">
                <label for="numeroEmision" class="col-md-3 control-label text-info">
                    Numero Emision
                </label>
                <div class="col-md-6">
                    <g:textField name="numeroEmision" required="" class="allCaps form-control required" value="${documentoEmpresaInstance?.numeroEmision}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'digitosEnSecuencial', 'error')} ">
            <span class="grupo">
                <label for="digitosEnSecuencial" class="col-md-3 control-label text-info">
                    Digitos En Secuencial
                </label>
                <div class="col-md-6">
                    <g:field name="digitosEnSecuencial" type="number" value="${documentoEmpresaInstance.digitosEnSecuencial}" class="digits form-control required" required=""/>
                </div>
                
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaAutorizacion', 'error')} ">
            <span class="grupo">
                <label for="fechaAutorizacion" class="col-md-3 control-label text-info">
                    Fecha Autorizacion
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaAutorizacion"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaAutorizacion}"  />
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaIngreso', 'error')} ">
            <span class="grupo">
                <label for="fechaIngreso" class="col-md-3 control-label text-info">
                    Fecha Ingreso
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaIngreso"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaIngreso}"  />
                </div>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaInicio', 'error')} ">
            <span class="grupo">
                <label for="fechaInicio" class="col-md-3 control-label text-info">
                    Fecha Inicio
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaInicio"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaInicio}"  />
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaFin', 'error')} ">
            <span class="grupo">
                <label for="fechaFin" class="col-md-3 control-label text-info">
                    Fecha Fin
                </label>
                <div class="col-md-4">
                    <elm:datepicker name="fechaFin"  class="datepicker form-control required" value="${documentoEmpresaInstance?.fechaFin}"  />
                </div>
                
            </span>
        </div>
        
    </g:form>

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
    </script>

</g:else>