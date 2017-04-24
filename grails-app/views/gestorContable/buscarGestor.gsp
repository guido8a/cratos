<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
%{--<table border="0" class="table table-bordered ">--}%
<table class="table table-bordered table-hover table-condensed">

        %{--<thead>--}%
        %{--<tr>--}%
            %{--<th>--}%
                %{--Nombre--}%
            %{--</th>--}%
            %{--<th>--}%
                %{--Descripcion--}%
            %{--</th>--}%
            %{--<th>--}%
                %{--Observaciones--}%
            %{--</th>--}%
            %{--<th style="width: 100px">Acciones</th>--}%
        %{--</tr>--}%
        %{--</thead>--}%
        <tbody>
    <g:if test="${lista.size()>0}">
        <g:each var="gestor" in="${lista}">
            <tr>
                <td>${gestor.nombre}</td>
                <td>${gestor.descripcion}</td>
                <td>${gestor.observaciones}</td>
                <td style="width: 100px">
                    <a href="${g.createLink(action: 'verGestor',id:gestor.id)}" class="btn btn-small btn-info" title="Ver">
                        <i class="fa fa-laptop" title="Ver"></i>
                    </a>
                    <a href="${g.createLink(action: 'nuevoGestor',id:gestor.id)}" class="btn btn-small btn-success" title="Editar">
                        <i class="fa fa-pencil"></i>
                    </a>

                </td>
            </tr>
        </g:each>
        </tbody>
    </g:if>
    <g:else>
        <tr>
            <td>No se encontraron gestores</td>
        </tr>
    </g:else>
</table>
