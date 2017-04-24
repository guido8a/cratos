<%@ page import="cratos.Item" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>


<g:if test="${!itemInstance}">
    <elm:notFound elem="Item" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmItem" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${itemInstance?.id}" />
        
        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'empresa', 'error')} required">
            <span class="grupo">
                <label for="empresa" class="col-md-3 control-label text-info">
                    Empresa
                </label>
                <div class="col-md-8">
                    <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}" optionKey="id" required="" value="${itemInstance?.empresa?.id}" class="many-to-one form-control"/>
                </div>
                 *
            </span>
        </div>


    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-3 control-label text-info">
                Nombre
            </label>
            <div class="col-md-8">
                <g:textField name="nombre" maxlength="127" required="" class=" form-control required" value="${itemInstance?.nombre}"/>
            </div>
            *
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-3 control-label text-info">
                Código
            </label>
            <div class="col-md-8">
                <g:textField name="codigo" maxlength="15" required="" class=" form-control required" value="${itemInstance?.codigo}"/>
            </div>
            *
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'grupo', 'error')} ">
        <span class="grupo">
            <label for="grupo" class="col-md-3 control-label text-info">
                Grupo
            </label>
            <div class="col-md-8">
                <g:select id="grupo" name="grupo.id" from="${cratos.Grupo.list()}" optionKey="id" value="${itemInstance?.grupo?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
            </div>

        </span>
    </div>


    <div class="col2">

      <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'precioVenta', 'error')} required">
    <span class="grupo">
        <label for="precioVenta" class="col-md-6 control-label text-info">
            Precio Venta
        </label>
        <div class="col-md-5">
            <g:field name="precioVenta" type="number" value="${fieldValue(bean: itemInstance, field: 'precioVenta')}" class="number form-control  required" required=""/>
        </div>
        *
    </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'precioCosto', 'error')} required">
        <span class="grupo">
            <label for="precioCosto" class="col-md-6 control-label text-info">
                Precio Costo
            </label>
            <div class="col-md-5">
                <g:field name="precioCosto" type="number"  value="${fieldValue(bean: itemInstance, field: 'precioCosto')}" class="number form-control  required" required=""/>
            </div>
            *
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'precioUnitario', 'error')} required">
        <span class="grupo">
            <label for="precioUnitario" class="col-md-6 control-label text-info">
                Precio Unitario
            </label>
            <div class="col-md-5">
                <g:field name="precioUnitario" type="number" value="${fieldValue(bean: itemInstance, field: 'precioUnitario')}" class="number form-control  required" required=""/>
            </div>
            *
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'peso', 'error')} required">
        <span class="grupo">
            <label for="peso" class="col-md-6 control-label text-info">
                Peso
            </label>
            <div class="col-md-5">
                <g:field name="peso" type="number" value="${fieldValue(bean: itemInstance, field: 'peso')}" class="number form-control  required" required=""/>
            </div>
            *
        </span>
    </div>


    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'stockMaximo', 'error')} required">
        <span class="grupo">
            <label for="stockMaximo" class="col-md-6 control-label text-info">
                Stock Maximo
            </label>
            <div class="col-md-5">
                <g:field name="stockMaximo" type="number" value="${fieldValue(bean: itemInstance, field: 'stockMaximo')}" class="number form-control  required" required=""/>
            </div>
            *
        </span>
    </div>

    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'stock', 'error')} required">
        <span class="grupo">
            <label for="stock" class="col-md-6 control-label text-info">
                Stock
            </label>
            <div class="col-md-5">
                <g:field name="stock" type="number" value="${fieldValue(bean: itemInstance, field: 'stock')}" class="number form-control  required" required=""/>
            </div>
            *
        </span>
    </div>


    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'estado', 'error')} ">
        <span class="grupo">
            <label for="estado" class="col-md-4 control-label text-info">
                Estado
            </label>
            <div class="col-md-5">
                %{--<g:textField name="estado" maxlength="1" class=" form-control" value="${itemInstance?.estado}"/>--}%
                <g:select from="['A': 'Activo', 'B': 'Dado de baja']" name="estado" class="input-medium" value="${itemInstance?.estado}" optionKey="key" optionValue="value"/>
            </div>

        </span>
    </div>


    <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'iva', 'error')} required">
            <span class="grupo">
                <label for="iva" class="col-md-4 control-label text-info">
                    Iva
                </label>
                <div class="col-md-7">
                    %{--<g:field name="iva" type="number" value="${itemInstance.iva}" class="digits form-control required" required=""/>--}%
                    <g:select from="[1: 'Con IVA', 0: 'Sin IVA']" name="iva" class="input-medium" value="${itemInstance?.iva}" optionKey="key" optionValue="value"/>
                </div>
                 *
            </span>
        </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'ice', 'error')} required">
            <span class="grupo">
                <label for="ice" class="col-md-4 control-label text-info">
                    Ice
                </label>
                <div class="col-md-7">
                    <g:field name="ice" type="number" value="${fieldValue(bean: itemInstance, field: 'ice')}" class="number form-control  required" required=""/>
                </div>
                 *
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'fecha', 'error')} ">
            <span class="grupo">
                <label for="fecha" class="col-md-4 control-label text-info">
                    Fecha
                </label>
                <div class="col-md-7">
                    <elm:datepicker name="fecha" title="fecha"  class="datepicker form-control" value="${itemInstance?.fecha}" default="none" noSelection="['': '']" />
                </div>
                
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'marca', 'error')} ">
            <span class="grupo">
                <label for="marca" class="col-md-4 control-label text-info">
                    Marca
                </label>
                <div class="col-md-7">
                    <g:select id="marca" name="marca.id" from="${cratos.Marca.list()}" optionKey="id" optionValue="descripcion" value="${itemInstance?.marca?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>

            </span>
        </div>


        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'unidad', 'error')} ">
            <span class="grupo">
                <label for="unidad" class="col-md-4 control-label text-info">
                    Unidad
                </label>
                <div class="col-md-7">
                    <g:select id="unidad" name="unidad.id" from="${cratos.Unidad.list()}" optionKey="id" value="${itemInstance?.unidad?.id}" class="many-to-one form-control" noSelection="['null': '']"/>
                </div>
                
            </span>
        </div>
        

    </div>
        
        <div class="form-group keeptogether ${hasErrors(bean: itemInstance, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-3 control-label text-info">
                    Observaciones
                </label>
                <div class="col-md-8">
                    %{--<g:textField name="observaciones" maxlength="127" class=" form-control" value="${itemInstance?.observaciones}"/>--}%

                    <g:textArea name="observaciones" maxlength="127" class="form-control" value="${itemInstance?.observaciones}" style="resize: none"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmItem").validate({
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
