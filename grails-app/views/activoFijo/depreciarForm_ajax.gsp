<div class="alert alert-danger" style="margin-top: 10px;">
    <h3>Alerta</h3>

    <p>
        Al hacer clic en el botón "Depreciar" se realizará la <b>depreciación de los activos fijos</b> de la empresa.
    </p>

    <p>
        <b>Esta acción no se puede deshacer.</b>
    </p>

    <p>
        Se generará automáticamente un proceso que debe ser <b>registrado para afectar la contabilidad</b>.
    </p>
</div>

<div class="row">
    <div class="col-md-6">
        Realizar depreciación del periodo
    </div>
</div>

<div class="row">
    <div class="col-md-7">
        <g:select name="periodoDep" from="${periodos}" optionKey="id" class="form-control"/>
    </div>
</div>
