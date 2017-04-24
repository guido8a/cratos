<%@ page import="cratos.Proveedor" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!proveedorInstance}">
    <elm:notFound elem="Proveedor" genero="o"/>
</g:if>
<g:else>
<g:form class="form-horizontal" name="frmProveedor" role="form" action="save_ajax" method="POST">
<g:hiddenField name="id" value="${proveedorInstance?.id}"/>



<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'ruc', 'error')} required">
    <span class="grupo">
        <label for="ruc" class="col-md-3 control-label text-info">
            Ruc
        </label>

        <div class="col-md-2">
            <g:textField name="ruc" maxlength="13" required="" class=" form-control required"
                         value="${proveedorInstance?.ruc}"/>
        </div>
        *
    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombre', 'error')} ">
    <span class="grupo">
        <label for="nombre" class="col-md-3 control-label text-info">
            Nombre
        </label>

        <div class="col-md-8">
            <g:textField name="nombre" maxlength="63" class=" form-control"
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
            <g:textField name="direccion" maxlength="127" class=" form-control"
                         value="${proveedorInstance?.direccion}"/>
        </div>

    </span>
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
                      noSelection="['null': '']"/>
        </div>

    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoPersona', 'error')} required">
    <span class="grupo">
        <label for="tipoPersona" class="col-md-6 control-label text-info">
            Tipo Persona
        </label>

        <div class="col-md-5">
            <g:select id="tipoPersona" name="tipoPersona.id" from="${cratos.TipoPersona.list()}" optionKey="id"
                      required="" value="${proveedorInstance?.tipoPersona?.id}" optionValue="descripcion" class="many-to-one form-control"/>
        </div>
        *
    </span>
</div>


<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'tipoIdentificacion', 'error')} ">
    <span class="grupo">
        <label for="tipoIdentificacion" class="col-md-6 control-label text-info">
            Tipo Identificación
        </label>

        <div class="col-md-5">
            <g:select id="tipoIdentificacion" name="tipoIdentificacion.id" from="${cratos.TipoIdentificacion.list()}"
                      optionKey="id" value="${proveedorInstance?.tipoIdentificacion?.id}"
                      class="many-to-one form-control" optionValue="descripcion" noSelection="['null': '']"/>
        </div>

    </span>
</div>


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

%{--<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'empresa', 'error')} ">--}%
    %{--<span class="grupo">--}%
        %{--<label for="empresa" class="col-md-6 control-label text-info">--}%
            %{--Empresa--}%
        %{--</label>--}%

        %{--<div class="col-md-5">--}%
           %{--<g:textField name="empresa" value="${session.empresa}" class="form-control" readonly="true"/>--}%
        %{--</div>--}%

    %{--</span>--}%
%{--</div>--}%

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombreContacto', 'error')} required">
    <span class="grupo">
        <label for="nombreContacto" class="col-md-6 control-label text-info">
            Nombre Contacto
        </label>

        <div class="col-md-5">
            <g:textField name="nombreContacto" maxlength="40" required="" class=" form-control required"
                         value="${proveedorInstance?.nombreContacto}"/>
        </div>
        *
    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'apellidoContacto', 'error')} required">
    <span class="grupo">
        <label for="apellidoContacto" class="col-md-6 control-label text-info">
            Apellido Contacto
        </label>

        <div class="col-md-5">
            <g:textField name="apellidoContacto" maxlength="40" required="" class=" form-control required"
                         value="${proveedorInstance?.apellidoContacto}"/>
        </div>
        *
    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'pais', 'error')}">
    <span class="grupo">
        <label for="pais" class="col-md-6 control-label text-info">
            País
        </label>

        <div class="col-md-5">
            <g:textField name="pais" class=" form-control" value="${proveedorInstance?.pais}"/>
        </div>

    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'canton', 'error')} ">
    <span class="grupo">
        <label for="canton" class="col-md-6 control-label text-info">
            Cantón
        </label>

        <div class="col-md-5">
            <g:select id="canton" name="canton.id" from="${cratos.Canton.list()}" optionKey="id"
                      value="${proveedorInstance?.canton?.id}" optionValue="nombre" class="many-to-one form-control"
                      noSelection="['null': '']"/>
        </div>

    </span>
</div>

<div class="form-group">
    <span class="grupo">
       <label>

       </label>
        <div></div>
    </span>

</div>


<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'fecha', 'error')} ">
    <span class="grupo">
        <label for="fecha" class="col-md-4 control-label text-info">
            Fecha
        </label>

        <div class="col-md-5">
            <elm:datepicker name="fecha" title="fecha" class="datepicker form-control"
                            value="${proveedorInstance?.fecha}"/>
        </div>

    </span>
</div>



<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'descuento', 'error')}">
    <span class="grupo">
        <label for="descuento" class="col-md-4 control-label text-info">
            Descuento
        </label>

        <div class="col-md-5">
            <g:field name="descuento"  type="number" maxlength="12" value="${fieldValue(bean: proveedorInstance, field: 'descuento')}"
                     class="number form-control"/>

        </div>
    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'estado', 'error')} ">
    <span class="grupo">
        <label for="estado" class="col-md-4 control-label text-info">
            Estado
        </label>

        <div class="col-md-5">

            <g:select name="estado" from="['1':'Activo', '0': 'No Activo']" optionValue="value" optionKey="key" class="form-control" value="${proveedorInstance?.estado}"/>

        </div>

    </span>
</div>



<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'telefono', 'error')} ">
    <span class="grupo">
        <label for="telefono" class="col-md-4 control-label text-info">
            Teléfono
        </label>

        %{--<div class="col-md-5">--}%
            %{--<g:textField name="telefono" maxlength="63" class=" form-control"--}%
                         %{--value="${proveedorInstance?.telefono}"/>--}%
        %{--</div>--}%

        <div class="col-md-5">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-phone"></i></span>
                <g:textField name="telefono" maxlength="63" class=" form-control"
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
        <div class="col-md-5">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>

                <g:textField name="email" email="true" class=" form-control" value="${proveedorInstance?.email}"/>

            </div>
        </div>


    </span>
</div>



<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'actividad', 'error')} ">
    <span class="grupo">
        <label for="actividad" class="col-md-4 control-label text-info">
            Actividad
        </label>

        <div class="col-md-5">
            <g:textField name="actividad" class=" form-control" value="${proveedorInstance?.actividad}"/>
        </div>

    </span>
</div>





<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'nombreCheque', 'error')} ">
    <span class="grupo">
        <label for="nombreCheque" class="col-md-4 control-label text-info">
            Nombre Cheque
        </label>

        <div class="col-md-5">
            <g:textField name="nombreCheque" class=" form-control" value="${proveedorInstance?.nombreCheque}"/>
        </div>

    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'autorizacionSri', 'error')} ">
    <span class="grupo">
        <label for="autorizacionSri" class="col-md-4 control-label text-info">
            Autorización Sri
        </label>

        <div class="col-md-5">
            <g:textField name="autorizacionSri" maxlength="40" class=" form-control"
                         value="${proveedorInstance?.autorizacionSri}"/>
        </div>

    </span>
</div>

<div class="form-group ${hasErrors(bean: proveedorInstance, field: 'fechaCaducidad', 'error')} ">
    <span class="grupo">
        <label for="fechaCaducidad" class="col-md-4 control-label text-info">
            Fecha de Caducidad
        </label>

        <div class="col-md-5">
            <elm:datepicker name="fechaCaducidad" class="datepicker form-control"
                            value="${proveedorInstance?.fechaCaducidad}"/>
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

            <g:textArea name="observaciones" maxlength="127" class="form-control" value="${proveedorInstance?.observaciones}" style="resize: none"/>

        </div>

    </span>
</div>

</g:form>


<script type="text/javascript">



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

            });

    $("#autorizacionSri").keydown(function (ev) {

        return validarNum(ev);
    }).keyup(function () {

            });

    $("#telefono").keydown(function (ev) {

        return validarNum(ev);
    }).keyup(function () {

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
        rules          : {
            ruc : {
                rangelength: [13, 13],
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
                remote : "RUC ya ingresado",
                rangelength: "Ingrese un número RUC válido"
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