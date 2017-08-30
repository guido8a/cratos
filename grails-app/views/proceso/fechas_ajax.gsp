<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 29/08/17
  Time: 15:39
--%>

<div class="row">
    <div class="col-md-2 negrilla">
        Desde:
    </div>
    <div class="col-md-4">

        <elm:datepicker name="fechaDesde" title="Fecha desde"
                        class="datepicker form-control required col-md-4 fechaD"
                        maxDate="new Date()"
                        style="width: 80px; margin-left: 5px"/>
    </div>



    <div class="col-md-2 negrilla">
        Hasta:
    </div>
    <div class="col-md-4">

        <elm:datepicker name="fechaHasta" title="Fecha hasta"
                        class="datepicker form-control required col-md-4 fechaH"
                        maxDate="new Date()"
                        style="width: 80px; margin-left: 5px"/>
    </div>
</div>