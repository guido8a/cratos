<%@ page import="cratos.inventario.SubgrupoItems" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!subgrupoItemsInstance}">
    <elm:notFound elem="SubgrupoItems" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmSubgrupoItems" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${subgrupoItemsInstance?.id}" />
        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'empresa', 'error')} ">
            <span class="grupo">
                <label for="empresa" class="col-md-2 control-label text-info">
                    Empresa
                </label>
                <div class="col-md-6">
                    <g:if test="${session.perfil.nombre == 'Administrador'}">
                        <g:textField name="empresa.id" id="empresa" readonly="true" class="form-control" value="${session.empresa}"/>

                    </g:if>
                    <g:else>
                        <g:select id="empresa" name="empresa.id" from="${cratos.Empresa.list()}"
                                  optionKey="id" required="" value="${subgrupoItemsInstance?.empresa?.id}" class="many-to-one form-control"/>
                    </g:else>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'grupo', 'error')} ">
            <span class="grupo">
                <label for="grupo" class="col-md-2 control-label text-info">
                    Grupo
                </label>
                <div class="col-md-6">
                    <g:select id="grupo" name="grupo.id" from="${cratos.inventario.Grupo.list()}" optionKey="id" required="" value="${subgrupoItemsInstance?.grupo?.id}" class="many-to-one form-control"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Codigo
                </label>
                <div class="col-md-6">
                    <g:textField name="codigo" maxlength="20" required="" class="allCaps form-control required" value="${subgrupoItemsInstance?.codigo}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: subgrupoItemsInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripcion
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" required="" class="allCaps form-control required" value="${subgrupoItemsInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        

        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmSubgrupoItems").validate({
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