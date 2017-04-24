<%@ page import="cratos.TipoComprobanteId" %>

<g:if test="${!tipoComprobanteIdInstance}">
    <elm:notFound elem="TipoComprobanteId" genero="o"/>
</g:if>
<g:else>

    <g:if test="${tipoComprobanteIdInstance?.tipoIdentificacion}">
        <div class="row">
            <div class="col-md-4 text-info">
                Tipo Identificación
            </div>

            <div class="col-md-5">
                ${tipoComprobanteIdInstance?.tipoIdentificacion?.descripcion?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

    <g:if test="${tipoComprobanteIdInstance?.tipoComprobanteSri}">
        <div class="row">
            <div class="col-md-4 text-info">
                Tipo Comprobante Sri
            </div>

            <div class="col-md-5">
                ${tipoComprobanteIdInstance?.tipoComprobanteSri?.descripcion?.encodeAsHTML()}
            </div>

        </div>
    </g:if>

</g:else>