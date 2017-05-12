<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/05/17
  Time: 15:42
--%>

<g:if test="${asiento}">
    <div class="row">
        <div class="col-md-2">
            <label>Código:</label>
        </div>
        <div class="col-md-2">
            <g:textField name=""
            ${asiento?.cuenta?.numero}
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Nombre:</label>
        </div>
        <div class="col-md-4">
            ${asiento?.cuenta?.descripcion}
        </div>
    </div>

</g:if>
<g:else>

</g:else>

