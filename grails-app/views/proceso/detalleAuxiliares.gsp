<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${msn}">
    <div class="errors" style="padding-left: 10px;">
        ${msn}
    </div>
</g:if>
<g:if test="${auxiliares.size() > 0}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>
    <table class="table table-striped" style="font-size: 12px" border="1px">
        <thead>
        <tr style="background: #818A91;">
            <th>Descripcion</th>
            <th>Fecha a pagar / cobrar</th>
            <th>Razón</th>
            <th style="width: 120px;">Monto</th>
            <th>Eliminar</th>
            <th >Pagos</th>
        </tr>
        </thead>
        <tbody style="border:1px solid black">
        <g:set var="val" value="${0}"/>
        <g:set var="valH" value="${0}"/>
        <g:each var="aux" in="${auxiliares}" status="i">
            <tr>
                <td style=";">
                    ${aux?.descripcion}
                    <input type="hidden" id="hid_${i}" name="idAuxiliares" value="${aux?.id}">
                </td>
                <td>${aux.fechaPago.format("dd-MM-yyyy")}</td>
                <td>${aux.debe != 0 ? "Debe" : "Haber"}</td>
                <td style="text-align: right;">
                    <g:formatNumber number="${aux?.debe != 0 ? aux.debe : aux.haber}" minFractionDigits="2" maxFractionDigits="2"/>
                </td>
                <td style="text-align: center;">
                    %{--<g:if test="${asiento?.comprobante?.registrado!='R'}">--}%
                    <div style="margin:auto;width: 18px;cursor: pointer" class="borrar btnpq ui-state-default ui-corner-all" id="borrar_${i}" idaux="${aux?.id}" posicion="${i}"
                         data-valor="${aux?.debe != 0 ? aux.debe : aux.haber}">
                        <span class="ui-icon ui-icon-circle-close"></span>
                    </div>
                    %{--</g:if>--}%
                </td>

                <g:set var="valH" value="${valH + aux?.haber ?: 0}"/>
                <td style="text-align: center;">
                    <a href="#" class="pagos" id="${aux.id}" max="${aux.haber}"
                       data-fecha="${aux.fechaPago.format("dd-MM-yyyy")}"
                       data-valor="${aux?.debe != 0 ? aux.debe : aux.haber}"
                       data-pagos="${cratos.PagoAux.findAllByAuxiliar(aux).monto.sum() ?: 0}">
                        Pagos
                    </a>
                </td>
            </tr>
        </g:each>
        </tbody>
        <tfoot>
        <tr>
            <td>TOTAL:</td>
            <td></td>
            <td></td>
            <td style="background-color: #d0ffd0;text-align: right">
                <g:formatNumber number="${valH}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td>&nbsp;</td>
        </tr>
        </tfoot>
    </table>

</g:if>
<div class="modal fade " id="modal-pagos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="overflow: hidden">
    <div class="modal-dialog ">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <b>Registrar pago  --   <label>Total a pagar:</label> <span id="tdPago"></span> -- Pagado <span id="tdPagado"></span> -- Por pagar:  <span id="tdPagar"></span></b>
            </div>
            <div class="modal-body">
                <input type="hidden" id="iden_aux">
                <input type="hidden" id="max_aux">
                <table  class="table" style="border-spacing: 0">
                    <tr>
                        <td>
                            <label>Gestor contable:</label>
                        </td>
                        <td>
                            <g:select name="pgo_gestor" from="${cratos.Gestor.findAllByEstadoAndEmpresa('A',session.empresa)}" id="pgo_gestor" class="required form-control" noSelection="['-1': 'Seleccione']" optionKey="id" optionValue="descripcion"/>
                        </td>
                        <td>
                            <label>Fecha:</label>
                        </td>
                        <td style="width: 170px">
                            <elm:datepicker name="pgo_fecha"  title="Fecha" class="datepicker form-control required"   maxDate="new Date()"  />
                            %{--<elm:datePicker class="required field ui-corner-all" title="Fecha" name="fecha" id="pgo_fecha" style="width:90px;"/>--}%
                        </td>
                        <td class="monto">
                            <label>Monto:</label>
                        </td>
                        <td class="monto">
                            <input type="text" class="required form-control number" id="pgo_monto" style="width:100px;text-align: right"/>
                        </td>
                        <td colspan="2" class="datos-notas" style="display: none"></td>
                    </tr>
                    <tr>
                        <td>
                            <label>Forma de pago:</label>
                        </td>
                        <td>
                            <g:select id="cmb-pago-fp" name="formaDePago.id" from="${formas}" class="required form-control" value="" optionKey="key" optionValue="value" />
                        </td>
                        <td class="referencia">
                            <label>Referencia:</label>
                        </td>
                        <td colspan="3" class="referencia">
                            <input type="text" class="required form-control" name="referencia" id="ref" maxlength="30"/>
                        </td>
                        <td class="base" style="display: none">
                            <label>Base imponible:</label>
                        </td>
                        <td class="base" style="display: none">
                            <input type="text" class="required form-control number" id="pgo_base" style="width:100px;text-align: right"  value="0.00"/>
                        </td>
                        <td class="base" style="display: none">
                            <label>IVA:</label>
                        </td>
                        <td class="base" style="display: none">
                            <input type="text" class="required form-control number" id="pgo_iva" style="width:100px;text-align: right" value="0.00"/>
                        </td>
                    </tr>
                    <tr class="datos-notas" style="display: none">
                        <td>
                            <label>Fecha emision:</label>
                        </td>
                        <td style="width: 170px">
                            <elm:datepicker name="nota_emision"  title="Fecha de emision" class="datepicker form-control required"   maxDate="new Date()"  />
                            %{--<elm:datePicker class="required field ui-corner-all" title="Fecha" name="fecha" id="pgo_fecha" style="width:90px;"/>--}%
                        </td>
                        <td>
                            <label>
                                Número:
                            </label>
                        </td>
                        <td colspan="3">
                            <input type="text" name="pagoEstablecimiento" id="pagoEst" size="3" maxlength="3"  class=" digits form-control label-shared " validate=" number"
                                   title="El número de establecimiento del documento "  />
                            <input type="text" name="pagoPuntoEmision" id="pagoEmi" size="3" maxlength="3" class=" digits form-control label-shared " validate=" number"
                                   title="El número de punto de emisión del documento"  />
                            <input type="text" name="pagoSecuencial" id="pagoSec" size="10" maxlength="9"  class=" digits form-control label-shared  " validate=" number"
                                   title="El número de secuencia del documento"  />

                        </td>
                    </tr>
                    <tr class="datos-notas" style="display: none">
                        <td>
                            <label>#Autorizacion:</label>
                        </td>
                        <td colspan="2">
                            <input type="text" id="pago-aut" class="form-control" maxlength="30">
                        </td>
                        <td>
                            <a href="#" id="pgo_save_nota" style="margin-left: 10px" class="btn btn-azul">
                                <i class="fa fa-save"></i>
                                Guardar
                            </a>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>

                <div class="fieldcontain  " id="div-btn-guardar" style="margin-top: 0px;">
                    <a href="#" id="pgo_save" style="margin-left: 10px" class="btn btn-azul">
                        <i class="fa fa-save"></i>
                        Guardar
                    </a>
                </div>
                <fieldset style="width: 710px;">
                    <legend>Pagos:</legend>
                    <div id="pgo_ajax" style="width: 810px;margin: auto;overflow: auto;height: 350px;margin-top: 10px">
                    </div>
                </fieldset>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript">
    $(function () {


        $(".pagos").click(function () {
            openLoader()
            $("#iden_aux").val($(this).attr("id"));
            $("#max_aux").val($(this).attr("max"));
            var data = {
                max      : parseFloat($(this).data("valor")),
                pagos    : parseFloat($(this).data("pagos")),
                restante : parseFloat($(this).data("valor")) - parseFloat($(this).data("pagos")),
                boton    : $(this)
            };
            $("#tdPago").text(number_format(data.max, 2, ".", ""));
            $("#tdPagado").text(number_format(data.pagos, 2, ".", ""));
            $("#tdPagar").text(number_format(data.restante, 2, ".", ""));
            $("#pgo_fecha_input").val($(this).data("fecha"));

            $("#pgo_monto").val(number_format($(this).data("valor")*1 - $(this).data("pagos")*1, 2, ".", ""));

            $("#pgo_save").data(data);

            $.ajax({
                type    : "POST",
                url     : "${g.createLink(action: 'detallePagos')}",
                data    : "id=" + $(this).attr("id"),
                success : function (msg) {
                    $("#pgo_ajax").html(msg).show("slide")
                }
            });
            closeLoader()
            $("#modal-pagos").modal("show");
        });

        $("#cmb-pago-fp").change(function(){
            if($(this).val()=="-1" || $(this).val()=="-2"){
                $(".monto").hide()
                $(".referencia").hide()
                $(".base").show()
                $(".datos-notas").show()
                $("#div-btn-guardar").hide()
            }else{
                $(".monto").show()
                $(".referencia").show()
                $(".base").hide()
                $(".datos-notas").hide()
                $("#div-btn-guardar").show()
            }
        });

        $("#pgo_save_nota").click(function(){
            var errores = "";
            var base=$("#pgo_base").val()
            var iva=$("#pgo_iva").val()
            var monto=base*1+iva*1
            if(isNaN(monto))
                monto=0
            else
                monto=number_format(monto, 2, ".", "")*1

            if ($("#pgo_gestor").val() == -1) {
                errores += "<li>Seleccione un gestor</li>";
            }
            if (isNaN(base)) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>La base imponible debe ser un número válido</li>";
            } else {
                if (base*1 <= 0) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>La base imponible debe ser mayor que 0</li>";
                }
                if (iva*1 < 0) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>La valor del impuesto debe ser un número positivo</li>";
                }

                if (monto > parseFloat($(this).data("restante"))) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>La suma de los pagos no debe exceder " + number_format($(this).data("max"), 2, ".", "") + "<br/>";
                    errores += "&nbsp;&nbsp;&nbsp(valor máximo para esta nota de débito / crédito: " + number_format($(this).data("restante"), 2, ".", "") + ")</li>";
                }
            }
            if ($.trim($("#pago-aut").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número de autorizacion del documento</li>"
            }
            if ($.trim($("#pagoEst").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número de establecimiento del documento</li>"
            }
            if ($.trim($("#pagoEmi").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número de emision del documento</li>"
            }
            if ($.trim($("#pagoSec").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número secuencial del documento</li>"
            }

            if ($.trim($("#nota_emision_input").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese la fecha de emision del documento</li>"
            }

            if (errores == "") {
                openLoader()
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(action: 'savePagoNota')}",
                    data    : {
                        "auxiliar.id"      : $("#iden_aux").val(),
                        fecha              : $("#pgo_fecha_input").val(),
                        gestor             : $("#pgo_gestor").val(),
                        fechaEmision       : $("#nota_emision_input").val(),
                        monto :base,
                        impuesto:iva,
                        establecimiento :$("#pagoEst").val(),
                        emision:$("#pagoEmi").val(),
                        secuencial:$("#pagoSec").val(),
                        autorizacion:$("#pago-aut").val(),
                        tipo:$("#cmb-pago-fp").val()

                    },
                    success : function (msg) {
                        if (msg == "ok") {
                            $.ajax({
                                type    : "POST",
                                url     : "${g.createLink(action: 'detallePagos')}",
                                data    : "id=" + $("#iden_aux").val(),
                                success : function (msg) {
                                    closeLoader()
                                    $("#pgo_ajax").html(msg).show("slide");
                                    var monto = parseFloat($.trim($("#pgo_monto").val()));
                                    var pagos = parseFloat($btn.data("pagos")) + monto;
                                    var restante = parseFloat($btn.data("restante")) - monto;
                                    var $boton = $btn.data("boton");
                                    $boton.data("pagos", pagos);
                                    $btn.data("pagos", pagos);
                                    $btn.data("restante", restante);
                                    $("#pgo_monto").val("");
                                    $("#ref").val("");
                                    $("#pgo_factura").val("");
                                    $("#tdPagado").text(number_format(pagos, 2, ".", ""));
                                    $("#tdPagar").text(number_format(restante, 2, ".", ""));
                                }
                            });
                        }

                    }
                });
            } else {
                bootbox.alert("Por favor corrija lo siguiente:<br/><ul>" + errores + "</ul>")
            }
        })

        $("#pgo_save").unbind("click")
        $("#pgo_save").bind("click", function () {
            var $btn = $("#pgo_save");
            var errores = "";

            if ($("#pgo_gestor").val() == -1) {
                errores += "<li>Seleccione un gestor</li>";
            }
//            if ($.trim($("#pgo_factura").val()) == "") {
//                if (errores != "") {
//                    errores += "\<br/>";
//                }
//                errores += "<li>Ingrese el número de factura</li>"
//            }
            if ($.trim($("#ref").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el número de referencia del documento</li>"
            }
            if (isNaN($("#pgo_monto").val())) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>El monto del pago debe ser un número válido</li>";
            } else {
                if (parseFloat($.trim($("#pgo_monto").val())) <= 0) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>El monto del pago debe ser mayor que 0</li>";
                }

                if (parseFloat($.trim($("#pgo_monto").val())) > parseFloat($(this).data("restante"))) {
                    if (errores != "") {
                        errores += "<br/>";
                    }
                    errores += "<li>La suma de los pagos no debe exceder " + number_format($(this).data("max"), 2, ".", "") + "<br/>";
                    errores += "&nbsp;&nbsp;&nbsp(valor máximo para este pago: " + number_format($(this).data("restante"), 2, ".", "") + ")</li>";
                }
            }
            console.log($("#pgo_fecha_input").val(),$("#pgo_fecha_input"))
            if ($.trim($("#pgo_fecha_input").val()) == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese la fecha del pago</li>"
            }

            if (errores == "") {
                openLoader()
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(action: 'savePago')}",
                    data    : {
                        "auxiliar.id"      : $("#iden_aux").val(),
                        fecha              : $("#pgo_fecha_input").val(),
                        monto              : $("#pgo_monto").val(),
                        factura            : $("#pgo_factura").val(),
                        gestor             : $("#pgo_gestor").val(),
                        "formaDePago.id" : $("#cmb-pago-fp").val(),
                        referencia         : $("#ref").val()
                    },
                    success : function (msg) {
                        if (msg == "ok") {
                            $.ajax({
                                type    : "POST",
                                url     : "${g.createLink(action: 'detallePagos')}",
                                data    : "id=" + $("#iden_aux").val(),
                                success : function (msg) {
                                    closeLoader()
                                    $("#pgo_ajax").html(msg).show("slide");
                                    var monto = parseFloat($.trim($("#pgo_monto").val()));
                                    var pagos = parseFloat($btn.data("pagos")) + monto;
                                    var restante = parseFloat($btn.data("restante")) - monto;
                                    var $boton = $btn.data("boton");
                                    $boton.data("pagos", pagos);
                                    $btn.data("pagos", pagos);
                                    $btn.data("restante", restante);
                                    $("#pgo_monto").val("");
                                    $("#ref").val("");
                                    $("#pgo_factura").val("");
                                    $("#tdPagado").text(number_format(pagos, 2, ".", ""));
                                    $("#tdPagar").text(number_format(restante, 2, ".", ""));
                                }
                            });
                        }

                    }
                });
            } else {
                bootbox.alert("Por favor corrija lo siguiente:<br/><ul>" + errores + "</ul>")
            }

        });

        $(".borrar").click(function () {
            openLoader()
            var resultado = false;
            var id = $(this).attr("idaux");
            var asientoId = $("#idAsiento").val();
            var valor = $(this).data("valor")*1;

            $.ajax({
                type    : "POST",
                url     : "${g.createLink(action: 'borrarAuxiliar')}",
                data    : "id=" + id + "&idAs=" + asientoId,
                success : function (msg) {
                    if(msg!="error"){
                        $("#listaAuxl").html(msg).show("slide");//
                        var enAux = $("#agregar_axul").data("enAux")*1;
                        var restante = $("#agregar_axul").data("restante")*1;
                        enAux -= valor;
                        restante += valor;
                        $("#agregar_axul").data("enAux", enAux);
                        $("#agregar_axul").data("restante", restante);
                        $("#spAsignado").text(number_format(enAux, 2, ".", ""));
                        $("#spAsignar").text(number_format(restante, 2, ".", ""));
                    }else{
                        bootbox.alert("No se puede borrar un plan de pagos que tiene un pago registrado en el sistema")
                    }
                    closeLoader()
                }
            });
        });

    });
</script>