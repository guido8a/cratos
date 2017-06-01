<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 01/06/17
  Time: 10:22
--%>

%{--<div class="col-md-8">--}%

    %{--<div class="col-md-2">--}%
    %{--<label>N. Establecimiento</label>--}%
    %{--</div>--}%

    %{--<div class="col-md-2">--}%
        %{--<label>N. Emisión</label>--}%
    %{--</div>--}%

%{--</div>--}%

%{--<div class="col-md-8">--}%

    <div class="col-md-3">
        <g:textField name="esta" id="numEsta" value="${libreta?.numeroEstablecimiento}" readonly="true" style="width: 100px"/>
    </div>
-
    <div class="col-md-2">
        <g:textField name="emi" id="numEmi" value="${libreta?.numeroEmision}" readonly="true" style="width: 100px"/>
    </div>

%{--</div>--}%