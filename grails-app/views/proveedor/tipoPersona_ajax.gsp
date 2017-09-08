<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 08/09/17
  Time: 10:43
--%>

<g:select id="tipoPersona" name="tipoPersona.id" from="${lista}" optionKey="id"
          required="" value="${proveedorInstance?.tipoPersona?.id}" optionValue="descripcion" class="many-to-one form-control"/>