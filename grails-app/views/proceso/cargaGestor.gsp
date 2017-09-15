<div class="col-xs-2 negrilla">
    Gestor a utilizar:
</div>
<div class="col-xs-10 negrilla">
    <g:select class="form-control required" name="gestor"
              from="${gstr}"
              value="${gstr_id}" optionKey="id" optionValue="nombre"
              title="Proceso tipo" disabled="${rgst == 'R' ? true : false}" readonly="${detalle ? true : false}" />
              %{--title="Proceso tipo" disabled="${rgst == 'R' ? true : ( detalle ? true : false)}" />--}%
</div>
