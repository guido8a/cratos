<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<table style="width: 100%" class="table table-striped" >
    <thead>
    <tr>
        <th>Tipo</th>
        <th>Descripción</th>
        <th>Porcentaje</th>
        <th>Valor</th>
        <th>IESS</th>
        <th>Gravable</th>
        <th>Decimo</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${rubros}" var="r">
        <tr id="${r.id}" class="tr_rubro" >
            <td style="text-align: center">${r.tipoRubro.codigo}</td>
            <td>${r.descripcion}</td>
            <td style="text-align: right">${r.porcentaje}</td>
            <td  style="text-align: right">${r.valor}</td>
            <td style="text-align: center">${(r.iess=="1")?"Si":"No"}</td>
            <td  style="text-align: center">${(r.gravable=="1")?"Si":"No"}</td>
            <td  style="text-align: center">${(r.decimo=="1")?"Si":"No"}</td>
            <td>
                <a href="#" class="btn btn-small btn-azul edit" title="editar" iden="${r.id}" desc="${r.descripcion}" porc="${r.porcentaje}" valor="${r.valor}" iess="${r.iess}" grav="${r.gravable}" dec="${r.decimo}" >
                    <i class="fa fa-pencil"></i>
                </a>
                <a href="#" class="btn btn-small btn-danger delete" title="Borrar" iden="${r.id}"  >
                    <i class="fa fa-trash-o"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".edit").click(function(){

        $("#id").val($(this).attr("iden"))
        $("#porcentaje").val($(this).attr("porc"))
        $("#valor").val($(this).attr("valor"))
        $("#descripcion").val($(this).attr("desc"))
        var iess = $(this).attr("iess")
        var grav = $(this).attr("grav")
        var dec = $(this).attr("dec")
        if(iess*1==1){
            $("#iess").attr("checked","checked")
        }else {
            $("#iess").removeAttr("checked")
        }
        if(dec*1==1) {
            $("#decimo").attr("checked","checked")
        }else {
            $("#decimo").removeAttr("checked")
        }
        if(grav*1==1)
            $("#gravable").attr("checked","checked")
        else
            $("#gravable").removeAttr("checked")

    });
    $(".delete").click(function(){
        $.ajax({
            type    : "POST",
            url     : "${g.createLink(controller: 'rubro',action: 'delete_ajax')}",
            data    : "id=" +$(this).attr("iden"),
            success : function (msg) {
                if(msg="ok")
                $("#tipoRubro").change()
                else{
                    bootbox.alert("El rubro no se puede eleminar puesto que esta asignado a un tipo de contrato")
                }

            }
        });
    })
</script>