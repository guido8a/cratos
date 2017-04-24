<%@ page import="cratos.ActivoFijo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<g:if test="${!activoFijoInstance}">
    <elm:notFound elem="ActivoFijo" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmActivoFijo" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${activoFijoInstance?.id}"/>
        <g:hiddenField name="proceso.id" value="${activoFijoInstance?.proceso?.id}"/>

        <div class="col2">
            %{--<div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'proceso', 'error')} required">--}%
            %{--<span class="grupo">--}%
            %{--<label for="proceso" class="col-md-2 control-label text-info">--}%
            %{--Proceso--}%
            %{--</label>--}%

            %{--<div class="col-md-6">--}%
            %{--<g:select id="proceso" name="proceso.id" from="${cratos.Proceso.list()}" optionKey="id" required="" value="${activoFijoInstance?.proceso?.id}" class="many-to-one form-control"/>--}%
            %{--</div>--}%
            %{--*--}%
            %{--</span>--}%
            %{--</div>--}%

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'codigo', 'error')} required">
                <span class="grupo">
                    <label for="codigo" class="col-md-2 control-label text-info">
                        Código
                    </label>

                    <div class="col-md-6">
                        <g:textField name="codigo" required="" class="allCaps form-control required" value="${activoFijoInstance?.codigo}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'grupo', 'error')} required">
                <span class="grupo">
                    <label for="grupo" class="col-md-2 control-label text-info">
                        Grupo
                    </label>

                    <div class="col-md-6">
                        <g:select id="grupo" name="grupo.id" from="${cratos.Grupo.list()}" optionKey="id" required="" value="${activoFijoInstance?.grupo?.id}"
                                  class="many-to-one form-control" optionValue="descripcion"/>
                    </div>
                    *
                </span>
            </div>

            %{--<div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'estado', 'error')} required">--}%
            %{--<span class="grupo">--}%
            %{--<label for="estado" class="col-md-2 control-label text-info">--}%
            %{--Estado--}%
            %{--</label>--}%

            %{--<div class="col-md-6">--}%
            %{--<g:textField name="estado" maxlength="1" required="" class="allCaps form-control required" value="${activoFijoInstance?.estado}"/>--}%
            %{--<g:select name="estado" from="['A': 'Activo', 'B': 'Dado de baja']" class="form-control required"--}%
            %{--value="${activoFijoInstance?.estado}" optionKey="key" optionValue="value"/>--}%
            %{--</div>--}%
            %{--*--}%
            %{--</span>--}%
            %{--</div>--}%

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'nombre', 'error')} required">
                <span class="grupo">
                    <label for="nombre" class="col-md-2 control-label text-info">
                        Nombre
                    </label>

                    <div class="col-md-6">
                        <g:textField name="nombre" maxlength="63" required="" class="allCaps form-control required" value="${activoFijoInstance?.nombre}"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'marca', 'error')} required">
                <span class="grupo">
                    <label for="marca" class="col-md-2 control-label text-info">
                        Marca
                    </label>

                    <div class="col-md-6">
                        <g:select id="marca" name="marca.id" from="${cratos.Marca.list()}" optionKey="id" required="" value="${activoFijoInstance?.marca?.id}"
                                  class="many-to-one form-control" optionValue="descripcion"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'custodio', 'error')} required">
                <span class="grupo">
                    <label for="custodio" class="col-md-2 control-label text-info">
                        Custodio
                    </label>

                    <div class="col-md-6">
                        <g:select id="custodio" name="custodio.id" from="${cratos.seguridad.Persona.findAllByEmpresa(session.empresa)}" optionKey="id" required=""
                                  value="${activoFijoInstance?.custodio?.id}" class="many-to-one form-control" optionValue="${{
                            it.nombre + ' ' + it.apellido
                        }}" noSelection="['': '']"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'proveedor', 'error')} required">
                <span class="grupo">
                    <label for="proveedor" class="col-md-2 control-label text-info">
                        Proveedor
                    </label>

                    <div class="col-md-6">
                        <g:select id="proveedor" name="proveedor.id" from="${cratos.Proveedor.findAllByEmpresa(session.empresa)}" optionKey="id" required=""
                                  value="${activoFijoInstance?.proveedor?.id}" class="many-to-one form-control"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'precio', 'error')} required">
                <span class="grupo">
                    <label for="precio" class="col-md-2 control-label text-info">
                        Precio
                    </label>

                    <div class="col-md-3">
                        <div class="input-group">
                            <g:field name="precio" type="number" value="${fieldValue(bean: activoFijoInstance, field: 'precio')}" class="number form-control  required" required=""/>
                            <span class="input-group-addon"><i class="fa fa-dollar"></i></span>
                        </div>
                    </div>
                    *
                </span>
            </div>

            %{--<div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'fechaRegistro', 'error')} required">--}%
            %{--<span class="grupo">--}%
            %{--<label for="fechaRegistro" class="col-md-2 control-label text-info">--}%
            %{--Registro--}%
            %{--</label>--}%

            %{--<div class="col-md-4">--}%
            %{--<elm:datepicker name="fechaRegistro" title="fecha registro" class="datepicker form-control required" value="${activoFijoInstance?.fechaRegistro}"/>--}%
            %{--</div>--}%
            %{--*--}%
            %{--</span>--}%
            %{--</div>--}%

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'aniosVidaUtil', 'error')} required">
                <span class="grupo">
                    <label for="aniosVidaUtil" class="col-md-2 control-label text-info">
                        Vida útil
                    </label>

                    <div class="col-md-4">
                        <div class="input-group">
                            <g:field name="aniosVidaUtil" type="number" value="${activoFijoInstance.aniosVidaUtil}" class="digits form-control required" required=""/>
                            <span class="input-group-addon">años</span>
                        </div>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'numeroSerie', 'error')} ">
                <span class="grupo">
                    <label for="numeroSerie" class="col-md-2 control-label text-info">
                        Número de Serie
                    </label>

                    <div class="col-md-6">
                        <g:textField name="numeroSerie" maxlength="20" class="allCaps form-control" value="${activoFijoInstance?.numeroSerie}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'modelo', 'error')} ">
                <span class="grupo">
                    <label for="modelo" class="col-md-2 control-label text-info">
                        Modelo
                    </label>

                    <div class="col-md-6">
                        <g:textField name="modelo" maxlength="20" class="allCaps form-control" value="${activoFijoInstance?.modelo}"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'color', 'error')} ">
                <span class="grupo">
                    <label for="color" class="col-md-2 control-label text-info">
                        Color
                    </label>

                    <div class="col-md-6">
                        <g:select id="color" name="color.id" from="${cratos.Color.list()}" optionKey="id" value="${activoFijoInstance?.color?.id}"
                                  class="many-to-one form-control" noSelection="['': '']" optionValue="descripcion"/>
                    </div>

                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'fechaInicioDepreciacion', 'error')} ">
                <span class="grupo">
                    <label for="fechaInicioDepreciacion" class="col-md-2 control-label text-info">
                        Inicio Depreciación
                    </label>

                    <div class="col-md-4">
                        <elm:datepicker name="fechaInicioDepreciacion" title="fecha inicio de depreciación" class="datepicker form-control"
                                        value="${activoFijoInstance?.fechaInicioDepreciacion}"/>
                    </div>

                </span>
            </div>
        </div>

    %{--<div class="row">--}%
        <div class="form-group keeptogether ${hasErrors(bean: activoFijoInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-1 control-label text-info">
                    Observacio-<br/>nes
                </label>

                <div class="col-md-9">
                    <g:textArea name="observaciones" maxlength="63" class="allCaps form-control" value="${activoFijoInstance?.observaciones}"/>
                </div>

            </span>
        </div>
    %{--</div>--}%
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmActivoFijo").validate({
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