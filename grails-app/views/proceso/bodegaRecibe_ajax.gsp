<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/07/17
  Time: 10:22
--%>

<g:select class="form-control required cmbRequired tipoProcesoSel" name="bodegaRecibe" id="bodegaRecibe"
          from="${bodegas}" value="${proceso?.bodegaRecibe?.id}" optionKey="id" optionValue="descripcion"
          title="Bodega que recibe" disabled="${(proceso?.estado == 'R') ? true : false}" />