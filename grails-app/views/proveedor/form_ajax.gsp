<%@ page import="cratos.Proveedor" %>


<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!proveedorInstance}">
    <elm:notFound elem="Proveedor" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmProveedor" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${proveedorInstance?.id}"/>
    %{--<div class="col2">--}%
        <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoIdentificacion', 'error')} ">
            <span class="grupo">
                <label for="tipoIdentificacion" class="col-md-3 control-label text-info">
                    Tipo Identificación
                </label>

                <div class="col-md-3">
                    <g:select id="tipoIdentificacion" name="tipoIdentificacion.id" from="${tipoIdentificacion}"
                              optionKey="id" value="${proveedorInstance?.tipoIdentificacion?.id}"
                              class="many-to-one form-control" optionValue="descripcion"/>
                </div>
            </span>
        </div>
    %{--</div>--}%
        <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'ruc', 'error')} required">
            <span class="grupo">
                <label for="ruc" class="col-md-3 control-label text-info">
                    Ruc
                </label>

                <div class="col-md-3" id="divRuc">
                    <g:textField name="ruc" maxlength="13" minlength="10" required="" class=" form-control required"
                                 value="${proveedorInstance?.ruc}" readonly="${lectura}"/>
                </div>
            </span>
        </div>
        <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-3 control-label text-info">
                    Nombre
                </label>

                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="63" class=" form-control required"
                                 value="${proveedorInstance?.nombre}"/>
                </div>
            </span>
        </div>
        <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'direccion', 'error')} ">
            <span class="grupo">
                <label for="direccion" class="col-md-3 control-label text-info">
                    Dirección
                </label>

                <div class="col-md-8">
                    <g:textField name="direccion" maxlength="127" class=" form-control required"
                                 value="${proveedorInstance?.direccion}"/>
                </div>

            </span>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'telefono', 'error')} ">
                <span class="grupo">
                    <label for="telefono" class="col-md-6 control-label text-info">
                        Teléfono
                    </label>

                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                            <g:textField name="telefono" maxlength="63" class=" form-control required"
                                         value="${proveedorInstance?.telefono}"/>
                        </div>
                    </div>
                </span>
            </div>


            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'email', 'error')} required ">
                <span class="grupo">
                    <label for="email" class="col-md-4 control-label text-info">
                        Email
                    </label>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-envelope"></i></span>

                            <g:textField name="email" email="true" class=" form-control" value="${proveedorInstance?.email}"/>

                        </div>
                    </div>
                </span>
            </div>

        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoProveedor', 'error')} ">
                <span class="grupo">
                    <label for="tipoProveedor" class="col-md-6 control-label text-info">
                        Tipo Proveedor
                    </label>

                    <div class="col-md-5">
                        <g:select id="tipoProveedor" name="tipoProveedor.id" from="${cratos.TipoProveedor.list()}" optionKey="id"
                                  value="${proveedorInstance?.tipoProveedor?.id}" optionValue="descripcion" class="many-to-one form-control"
                                  noSelection="['null': 'Seleccione...']"/>
                    </div>

                </span>
            </div>
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoPersona', 'error')} required">
                <span class="grupo">
                    <label for="tipoPersona" class="col-md-4 control-label text-info">
                        Tipo Persona
                    </label>

                    <div class="col-md-5" id="divTipoPersona">
                        %{--<g:select id="tipoPersona" name="tipoPersona.id" from="${cratos.TipoPersona.list()}" optionKey="id"--}%
                                  %{--required="" value="${proveedorInstance?.tipoPersona?.id}" optionValue="descripcion" class="many-to-one form-control"/>--}%
                    </div>
                    *
                </span>
            </div>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoRelacion', 'error')} required">
                <span class="grupo">
                    <label for="tipoRelacion" class="col-md-6 control-label text-info">
                        Tipo Relación
                    </label>

                    <div class="col-md-5">
                        <g:select id="tipoRelacion" name="tipoRelacion.id" from="${cratos.TipoRelacion.list()}" optionKey="id"
                                  required="" optionValue="descripcion" value="${proveedorInstance?.tipoRelacion?.id}" class="many-to-one form-control"/>
                    </div>
                    *
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'estado', 'error')} ">
                <span class="grupo">
                    <label for="estado" class="col-md-4 control-label text-info">
                        Estado
                    </label>

                    <div class="col-md-3">
                        <g:select name="estado" from="['1':'Activo', '0': 'No Activo']" optionValue="value" optionKey="key" class="form-control" value="${proveedorInstance?.estado}"/>
                    </div>
                </span>
            </div>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombreContacto', 'error')}">
                <span class="grupo">
                    <label for="nombreContacto" class="col-md-6 control-label text-info">
                        Nombre Contacto
                    </label>

                    <div class="col-md-6">
                        <g:textField name="nombreContacto" maxlength="40"  class=" form-control"
                                     value="${proveedorInstance?.nombreContacto}"/>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'descuento', 'error')}">
                <span class="grupo">
                    <label for="descuento" class="col-md-4 control-label text-info">
                        Descuento
                    </label>

                    <div class="col-md-3">
                        <div class="input-group">
                            <g:textField name="descuento" class="number form-control" maxlength="3" value="${fieldValue(bean: proveedorInstance, field: 'descuento')}"/>
                            <span class="input-group-addon"><i class="fa fa-percent"></i>%</span>
                        </div>
                    </div>
                </span>
            </div>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'apellidoContacto', 'error')}">
                <span class="grupo">
                    <label for="apellidoContacto" class="col-md-6 control-label text-info">
                        Apellido Contacto
                    </label>

                    <div class="col-md-6">
                        <g:textField name="apellidoContacto" maxlength="40" class=" form-control"
                                     value="${proveedorInstance?.apellidoContacto}"/>
                    </div>
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'relacionado', 'error')}">
                <span class="grupo">
                    <label for="relacionado" class="col-md-4 control-label text-info">
                        Relacionado
                    </label>

                    <div class="col-md-3">
                        <g:select id="relacionado" name="relacionado.id" from="${['NO','SI']}"
                                  value="${proveedorInstance?.relacionado}" class="many-to-one form-control"/>
                    </div>
                </span>
            </div>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'autorizacionSri', 'error')} ">
                <span class="grupo">
                    <label for="autorizacionSri" class="col-md-6 control-label text-info">
                        Autorización del Sri
                    </label>

                    <div class="col-md-6">
                        <g:textField name="autorizacionSri" maxlength="40" class=" form-control"
                                     value="${proveedorInstance?.autorizacionSri}"/>
                    </div>
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'pais', 'error')}">
                <span class="grupo">
                    <label for="pais" class="col-md-4 control-label text-info">
                        País
                    </label>

                    <div class="col-md-6">
                        <g:select id="pais" name="pais.id" from="${paises}"
                                  value="${proveedorInstance?.pais}" class="many-to-one form-control"
                                  noSelection="['null': 'Seleccione...']"/>
                    </div>
                </span>
            </div>
        </div>

        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'actividad', 'error')} ">
                <span class="grupo">
                    <label for="actividad" class="col-md-6 control-label text-info">
                        Actividad
                    </label>

                    <div class="col-md-6">
                        <g:textField name="actividad" class=" form-control" value="${proveedorInstance?.actividad}"/>
                    </div>

                </span>
            </div>
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'canton', 'error')} ">
                <span class="grupo">
                    <label for="canton" class="col-md-4 control-label text-info">
                        Cantón
                    </label>

                    <div class="col-md-6">
                        <g:select id="canton" name="canton.id" from="${cratos.Canton.list().sort{it.nombre}}" optionKey="id"
                                  value="${proveedorInstance?.canton?.id}" optionValue="nombre" class="many-to-one form-control"
                                  noSelection="['null': 'Seleccione...']"/>
                    </div>
                    %{--<div class="col-md-1">--}%
                        %{--<a href="#" class="btn btn-info btn-sm" id="btnCanton" title="Agregar Cantón">--}%
                            %{--<i class="fa fa-plus"></i>--}%
                        %{--</a>--}%
                    %{--</div>--}%
                </span>
            </div>
        </div>
        <div class="col2">
            <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombreCheque', 'error')} ">
                <span class="grupo">
                    <label for="nombreCheque" class="col-md-6 control-label text-info">
                        Cheque a nombre de
                    </label>

                    <div class="col-md-6">
                        <g:textField name="nombreCheque" class=" form-control" value="${proveedorInstance?.nombreCheque}"/>
                    </div>
                </span>
            </div>
        </div>


        <div class="form-group ${hasErrors(bean: proveedorInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-3 control-label text-info">
                    Observaciones
                </label>

                <div class="col-md-8">
                    <g:textArea name="observaciones" maxlength="127" class="form-control"
                                value="${proveedorInstance?.observaciones}" style="resize: none"/>
                </div>
            </span>
        </div>
    </g:form>


    <script type="text/javascript">


        cargarTipoPersona($("#tipoIdentificacion").val())

        function cargarTipoPersona (tipo) {
            $.ajax({
               type: 'POST',
                url: '${createLink(controller: 'proveedor', action: 'tipoPersona_ajax')}',
                data:{
                    id: '${proveedorInstance?.id}',
                    tipo: tipo
                },
                success: function(msg) {
                    $("#divTipoPersona").html(msg)
                }
            });
        }

        revisarLongitud($("#tipoIdentificacion").val())

        function revisarLongitud (tipo) {
            if(tipo == '1'){
//                $("#ruc").removeProp("minlength")
                $("#ruc").attr("minlength",13)
            }else{
//                $("#ruc").removeProp("maxlength")
                $("#ruc").attr("minlength",10)
            }
        }


        $("#tipoIdentificacion").change(function () {
            var vl = $(this).val()
            revisarLongitud(vl)
            cargarTipoPersona(vl)
        });



        function validarNum(ev) {
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
            ev.keyCode == 37 || ev.keyCode == 39);
        }


        function validarNumDec(ev) {
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
            ev.keyCode == 37 || ev.keyCode == 39 || ev.keyCode == 190 || ev.keyCode == 110);
        }



        $("#ruc").keydown(function (ev) {
            return validarNum(ev);
        }).keyup(function () {
//            return validarNum(ev);
        });

        $("#autorizacionSri").keydown(function (ev) {
            return validarNum(ev);
        }).keyup(function () {

        });

        $("#telefono").keydown(function (ev) {
            return validarNum(ev);
        }).keyup(function () {

        });


        $("#tipoPersona").change(function () {
            console.log($(this).val())
        });


        $("#descuento").keydown(function (ev) {
            var val = $(this).val();
            var dec = 2;
            if (ev.keyCode == 110 || ev.keyCode == 190) {
                if (!dec) {
                    return false;
                } else {
                    if (val.length == 0) {
                        $(this).val("0");
                    }
                    if (val.indexOf(".") > -1) {
                        return false;
                    }
                }
            } else {
                if (val.indexOf(".") > -1) {
                    if (dec) {
                        var parts = val.split(".");
                        var l = parts[1].length;
                        if (l >= dec) {
//                                return false;
                        }
                    }
                } else {
                    return validarNumDec(ev);
                }
            }
            return validarNumDec(ev);
        }).keyup(function () {

        });

        var validator = $("#frmProveedor").validate({
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
            },
            rules      : {
                ruc : {
                    remote : {
                        url  : "${createLink(action: 'validarCedula_ajax')}",
                        type : "post",
                        data : {
                            id : "${proveedorInstance.id}"
                        }
                    }
                }
            },
            messages       : {
                ruc : {
                    remote : "RUC ya ingresado"
                }
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