<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 11/05/17
  Time: 10:35
--%>


<ul>
    <strong>Formas de Pago</strong>
    <g:each in="${formasPago}" var="pago" >
        <li>${pago?.descripcion}</li>
    </g:each>
</ul>



