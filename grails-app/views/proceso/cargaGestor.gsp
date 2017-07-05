<div class="col-xs-2 negrilla">
    Gestor a utilizar:
</div>
<div class="col-xs-10 negrilla">
    <g:select class="form-control required" name="gestor"
              from="${gstr}"
              value="${proceso?.gestor?.id}" optionKey="id" optionValue="nombre"
              title="Proceso tipo" disabled="${registro ? true : false}"/>
</div>
