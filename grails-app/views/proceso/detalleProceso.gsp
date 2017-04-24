<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${comprobantes}">
    <g:set var="totalD" value="${0}"/>
    <g:set var="totalH" value="${0}"/>
    <g:each in="${comprobantes}" var="comp" status="k">
        <div class="btn-toolbar toolbar">
            <div class="btn-group">
                <g:if test="${comp.registrado != 'S'}">
                    <a href="#" class="btn registrar btn-success" id="reg_${comp?.id}" idComp="${comp?.id}" style="margin-bottom: 10px;">
                        <i class="fa fa-pencil-square-o"></i>
                        Mayorizar
                    </a>
                </g:if>
                <g:else>
                    <g:if test="${!aux}">
                        <a href="#" class="btn btn-danger" id="desmayo" idComp="${comp?.id}" style="margin-bottom: 10px;">
                            <i class="fa fa-pencil-square-o "></i>
                            Desmayorizar
                        </a>
                    </g:if>
                    <a href="#" class="btn btn-default" id="imprimir" iden="${comp?.proceso?.id}" nombre="${comp.prefijo + comp.numero}" style="margin-bottom: 10px;">
                        <i class="fa fa-print"></i>
                        Imprimir
                    </a>
                </g:else>
                <g:if test="${cratos.Retencion.countByProceso(comp?.proceso) > 0}">
                    <g:link
                            class="btn btn-default"
                            action="detalleSri" id="${comp?.proceso?.id}">
                        SRI
                    </g:link>
                    <g:if test="${cratos.Retencion.findByProceso(comp?.proceso).numeroSecuencial}">
                        <g:link controller="reportes3" action="imprimirRetencion"
                                class="btn btn-default btnRetencion" id="${comp?.proceso?.id}" params="[empresa: session.empresa.id]">
                            <i class="fa fa-print"></i>
                            Imprimir retención
                        </g:link>
                    </g:if>
                </g:if>

                <g:set var="activo" value="${false}"/>
                <g:each var="asiento" in="${asientos}" status="i">
                    <g:if test="${asiento.cuenta.resultado == 'A'}">
                        <g:set var="activo" value="${true}"/>
                    </g:if>
                </g:each>

                <g:if test="${activo}">
                %{--<g:link controller="activoFijo" action="form_ajax" params="['proceso.id': comp?.proceso?.id]" class="btn btn-info btnActivoFijo">--}%
                %{--<i class="fa fa-desktop"></i>--}%
                %{--Registrar activo fijo--}%
                %{--</g:link>--}%
                    <g:link controller="activoFijo" action="list" params="['proceso.id': comp?.proceso?.id]" class="btn btn-info">
                        <i class="fa fa-desktop"></i>
                        Registrar activos fijos
                    </g:link>
                </g:if>

            </div>
        </div>

        <div class="etiqueta">Tipo:</div> ${comp.tipo.descripcion}<br>

        <div class="etiqueta">Número:</div> ${comp?.prefijo}${comp?.numero}<br>

        <div class="etiqueta">Descripción:</div> ${comp?.descripcion}     <br>

        <div class="etiqueta">Fecha:</div> ${comp?.fecha?.format('dd-MM-yyyy')}<br>
        <table class="table table-striped"  style="margin-top: 15px">
        <thead >
          <tr>
            <th ></th>
            <th>Asientos contables</th>
            <th style="width: 140px; text-align: center;">Debe</th>
            <th style="width: 140px; text-align: center;">Haber</th>
            <th>&nbsp;</th>
          </tr>
          <tr style="background: #818A91;">
            <th style="width: 20px;">Auxiliar</th>
            <th>C&oacute;digo(nombre)</th>
            <th style="width: 120px; text-align: center;">Valor</th>
            <th style="width: 120px; text-align: center;">Valor</th>
            <th></th>
          </tr>
        </thead>
        <tbody>

        <g:set var="val" value="${0}"/>
        <g:set var="valH" value="${0}"/>
        <g:each var="asiento" in="${asientos}" status="i">
            <g:set var="aux" value="${asiento.suma()}"/>
            <g:if test="${asiento.comprobante == comp}">
                <tr>
                    <td style="width: 40px;" class="auxltd">
                        <g:if test="${asiento.cuenta.auxiliar == 'S' && proceso.tipoProceso != 'P' && comp.registrado == 'S'}">
                            <div style="float: left; margin-left: 15px;" class="auxbtn btnpq ui-state-default ui-corner-all" id="axul_${asiento.cuenta.id}"
                                 idAs="${asiento.id}" reg="${comp.registrado}" max="${Math.abs(asiento.debe - asiento.haber)}" aux="${aux ?: 0}"
                                 data-debe="${asiento.debe ?: 0}" data-haber="${asiento.haber ?: 0}">
                                <span class="ui-icon ui-icon-circle-plus"></span>
                            </div>
                        </g:if>
                    </td>
                    <td>
                        <input type="hidden" id="hid_${i}" name="idAsientos" value="${asiento.id}">
                        <g:if test="${asiento.comprobante.registrado == 'S'}">
                            ${asiento.cuenta.numero + '(' + asiento.cuenta.descripcion + ')'}
                        </g:if>
                        <g:else>
                            <g:select name="cuentas" from="${cratos.Cuenta.findAllByEmpresaAndMovimiento(session.empresa, '1')}" id="select_${i}" value="${asiento.cuenta.id}" optionKey="id" class="cuentas form-control" style="width:300px"></g:select>
                        </g:else>
                    </td>
                    <g:if test="${comp.registrado != 'S'}">
                        <td>
                            <input type="text" name="valor" id="vald_${i}" class="txt_valor debe number form-control" style="width: 100px;float: right;text-align: right" value="${asiento.debe ? g.formatNumber(number: asiento.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2, currencyCode: 'USD', groupingUsed: " ") : 0.00}"/>
                        </td>
                        <td>
                            <input type="text" name="valor" id="valh_${i}" class="txt_valor haber number form-control" style="width: 100px;float: right;text-align: right" value="${asiento.haber ? g.formatNumber(number: asiento.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2, currencyCode: 'USD', groupingUsed: " ") : 0.00}"/>
                        </td>
                        <td>
                            <div style="float: left; margin-right: 5px;" class="guardarDatos btnpq ui-state-default ui-corner-all" id="guardar_${i}" posicion="${i}">
                                <span class="ui-icon ui-icon-circle-check"></span>
                            </div>

                        </td>
                    </g:if>
                    <g:else>
                        <td>
                            <input type="text" name="valor" id="vald_${i}" class="form-control" style="width: 100px;float: right;color: black;text-align: right" value="${asiento.debe ? g.formatNumber(number: asiento.debe, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2, locale: 'US') : 0.00}" disabled/>
                        </td>
                        <td>
                            <input type="text" name="valor" id="valh_${i}" class="form-control" style="width: 100px;float: right;color: black;text-align: right" value="${asiento.haber ? g.formatNumber(number: asiento.haber, format: '##,##0', minFractionDigits: 2, maxFractionDigits: 2, locale: 'US') : 0.00}" disabled/>
                        </td>
                        <td>

                        </td>
                    </g:else>
                    <g:set var="val" value="${val + asiento.debe ?: 0}"/>
                    <g:set var="valH" value="${valH + asiento.haber ?: 0}"/>

                </tr>
            </g:if>
        </g:each>
        <tr>
            <td></td>
            <td><b>TOTAL COMPROBANTE:</b></td>

            <td style="background-color: ${(val.toFloat().round(2) == valH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}; text-align: right" id="total_debe">
                <g:formatNumber number="${val.toFloat().round(2)}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td style="background-color: ${(val.toFloat().round(2) == valH.toFloat().round(2)) ? '#d0ffd0' : '#ffd0d0'}; text-align: right" id="total_haber">
                <g:formatNumber number="${valH.toFloat().round(2)}" minFractionDigits="2" maxFractionDigits="2"/>
            </td>
            <td>&nbsp;</td>
        </tr>
        </tbody>
          </tbody>
        </table>

        <g:set var="totalD" value="${totalD + val}"/>
        <g:set var="totalH" value="${totalH + valH}"/>
    </g:each>

    <!-- Modal -->
    <div class="modal fade longModal" id="modal-auxiliares" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content ">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <b>Plan de pagos</b>
                </div>

                <div class="modal-body">
                    <input type="hidden" id="idAsiento">

                    <div class="row">
                        <div class="col-xs-2 negrilla">
                            Asiento:
                        </div>

                        <div class="col-xs-2 ">
                            <span id="spAsiento"></span>
                        </div>

                        <div class="col-xs-2 negrilla">
                            Registrado:
                        </div>

                        <div class="col-xs-2 ">
                            <span id="spAsignado"></span>
                        </div>

                        <div class="col-xs-2 negrilla">
                            Por registrar:
                        </div>

                        <div class="col-xs-2 ">
                            <span id="spAsignar"></span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-2 negrilla">
                            Descripción:
                        </div>

                        <div class="col-xs-8">
                            <textarea style="height: 40px;" name="descripcionAux" class="form-control"></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-2 negrilla">
                            Fecha de pago:
                        </div>

                        <div class="col-xs-3 negrilla">
                            %{--pilas con el ida de esta vaina--}%
                            <elm:datepicker name="fecha-aux" title="Fecha de pago" class="datepicker  axlr_fecha form-control required"/>
                            %{--<elm:datePicker class="field ui-corner-all" title="Fecha" name="fecha" id="axlr_fecha" style="width:100px;"/>  <br>--}%
                        </div>

                        <div class="col-xs-2 negrilla">
                            Proveedor:
                        </div>

                        <div class="col-xs-4 ">
                            <g:if test="${!proceso?.proveedor}">
                                <g:select id="pr" name="proveedor.id" from="${cratos.Proveedor.findAllByEmpresa(session.empresa)}" label=" Proveedor: " class="form-control" value="" optionKey="id"></g:select>
                            </g:if>
                            <g:else>
                                <input type="hidden" id="pr" value="${proceso.proveedor.id}">
                                ${proceso?.proveedor}
                            </g:else>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-xs-2 negrilla">
                            Valor  <span class="spRazon"></span>:
                        </div>

                        <div class="col-xs-2">
                            <input type="text" class=" form-control number required" name="valor" id="valor" value="0.00">
                        </div>

                        <div class="col-xs-2">
                            <a href="#" id="agregar_axul" class="btn btn-azul" title="Agregar al plan de pagos">
                                <i class="fa fa-plus"></i>
                                Agregar
                            </a>
                        </div>
                    </div>

                    <div style="width: 800px;margin-top: 25px;margin-bottom: 15px;">
                        <fieldset style="width: 780px;">
                            <legend>Plan de pagos / cobros:</legend>

                            <div id="listaAuxl" style="width:770px;">
                                %{--<img src="${resource(dir: 'images', file: 'loading_bg.gif')}" alt="Cargando...."/>--}%
                            </div>
                        </fieldset>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</g:if>

<script type="text/javascript">
    %{--var urlLoading = "${resource(dir: 'images', file: 'loading_bg.gif')}";--}%
    //    var loading = $('<img src="' + urlLoading + '" alt="Cargando...."/>');
    function submitForm() {
        var $form = $("#frmActivoFijo");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Grabando");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
//                        location.reload(true);
                        closeLoader();
                        spinner.replaceWith($btn);
                        return false;
                    } else {
                        closeLoader();
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    function calcularTotales() {

        var debe = 0
        var haber = 0
        $(".txt_valor").each(function () {
//            console.log($(this))
            if ($(this).hasClass("debe")) {
                debe += $(this).val() * 1
            }
            if ($(this).hasClass("haber")) {
                haber += $(this).val() * 1
            }
        });

        debe = number_format(debe, 2, ".", "")
        haber = number_format(haber, 2, ".", "")
        $("#total_debe").html(debe)
        $("#total_haber").html(haber)
        if (debe == haber) {
            $("#total_debe").css("background-color", "#d0ffd0")
            $("#total_haber").css("background-color", "#d0ffd0")
        } else {
            $("#total_debe").css("background-color", "#ffd0d0")
            $("#total_haber").css("background-color", "#ffd0d0")
        }

    }
    $(function () {

        $(".btnActivoFijo").click(function () {
            var url = $(this).attr("href");

            $.ajax({
                type    : "POST",
                url     : url,
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEdit",
                        title   : "Registrar Activo Fijo",
                        class   : "long",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            guardar  : {
                                id        : "btnSave",
                                label     : "<i class='fa fa-save'></i> Guardar",
                                className : "btn-success",
                                callback  : function () {
                                    return submitForm();
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").not(".datepicker").first().focus()
                    }, 500);
                } //success
            }); //ajax

            return false;
        });

        $(".btnRetencion").click(function () {
            var file = "retencion.pdf";
            var url = $(this).attr("href");
            var actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;
            location.href = actionUrl;
            return false;
        });

        $("#imprimir").click(function () {

            var url = "${g.createLink(controller: 'reportes',action: 'comprobante')}/" + $(this).attr("iden")
            location.href = "${g.createLink(controller: 'pdf',action: 'pdfLink')}?url=" + url + "&filename=" + $(this).attr("nombre") + ".pdf"

        });

        $("#desmayo").click(function () {
            var id = $(this).attr("idComp")
            bootbox.confirm("Esta seguro de desmayorizar este comprobante? Esta acción modificará los saldos", function (result) {
                if (result) {
                    openLoader("Desmayorizando")
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'proceso',action: 'desmayorizar')}",
                        data    : "id=" + id,
                        success : function (msg) {
                            if (msg == "ok") {
                                window.location.reload("true")
                            } else {
                                closeLoader()
                                bootbox.alert(msg)
                            }
                        }
                    });
                }
            });
        });

        $(".guardarDatos").click(function () {
            openLoader()
            var btn = $(this)
            var vd = $("#vald_" + $(this).attr("posicion")).val()
            var error = ""
            if (isNaN(vd)) {
                vd = 0
                error = "Error: por favor ingrese solo números en los campos debe y haber. Formato : 1234.56, use el punto para separar los decimales"
            }
            var vh = $("#valh_" + $(this).attr("posicion")).val()
            if (isNaN(vh)) {
                vh = 0
                error = "Error: por favor ingrese solo números en los campos debe y haber. Formato : 1234.56, use el punto para separar los decimales"
            }
            var combo = $("#select_" + $(this).attr("posicion"))
            var cuenta = combo.val()
            var cont = 0
            if (error != "") {
                closeLoader()
                bootbox.alert(error)
            } else {
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'proceso',action: 'valorAsiento')}",
                    data    : "proceso=" + $("#idProceso").val() + "&vd=" + vd + "&vh=" + vh + "&id=" + $("#hid_" + $(this).attr("posicion")).val() + "&cnta=" + combo.val(),
                    success : function (msg) {
//                    console.log($("#valh_" + btn.attr("posicion")))
                        if (msg == "ok") {
                            var valor = vd - vh
                            var boton = $("#valh_" + btn.attr("posicion")).parent().parent().find(".auxltd").find(".auxbtn")
//                        console.log( $("#valh_" + btn.attr("posicion")).parent().parent().find(".auxltd").find(".auxbtn"))
                            boton.attr("max", valor)
                            boton.data("debe", vd)
                            boton.data("haber", vh)
                            boton.attr("data-haber", vh)
                            boton.attr("data-debe", vd)
                            $("#valh_" + btn.attr("posicion")).css("background", "rgba(225, 242, 182,0.6)")
                            $("#vald_" + btn.attr("posicion")).css("background", "rgba(225, 242, 182,0.6)")
                            calcularTotales();
                            closeLoader()
                        }

//                    $("#registro").html(msg).show("slide");
//                    location.reload(true);
                    }
                });
            }

        });
        $(".registrar").click(function () {
            var id = $(this).attr("idComp");
            bootbox.confirm("Esta seguro de mayorizar este comprobante? Esta acción modificará los saldos", function (result) {
                if (result) {
                    openLoader("Mayorizando")
                    $.ajax({
                        type    : "POST",
                        url     : "${g.createLink(controller: 'proceso',action: 'registrarComprobante')}",
                        data    : "id=" + id,
                        success : function (msg) {
//                    $("#registro").html(msg).show("slide");
                            if (msg == "ok")
                                location.reload(true);
                            else {
                                closeLoader()
                                bootbox.alert("Error al mayorizar")
                            }
                        }
                    });
                }
            })
        });
        function cargarAuxiliares() {
            openLoader("Cargando")
            var id = $("#idAsiento").val();
            $.ajax({
                type    : "POST",
                url     : "${g.createLink(controller: 'proceso',action: 'cargarAuxiliares')}",
                data    : "id=" + id,
                success : function (msg) {
                    closeLoader()
                    $("#listaAuxl").html(msg).show();
                }
            });
        }

//        $("#auxiliares").dialog({
//            autoOpen  : false,
//            resizable : false,
//            title     : 'Auxiliares',
//            modal     : true,
//            draggable : false,
//            width     : 940,
//            position  : 'center',
//            open      : function (event, ui) {
//                $(".ui-dialog-titlebar-close").hide();
//            },
//            buttons   : {
//                "Cerrar" : function () {
//                    $(this).dialog("close");
//                }
//            }
//        });

        $(".auxbtn").click(function () {
            var data = {};
            data.max = parseFloat($(this).attr("max"));
            data.enAux = parseFloat($(this).attr("aux"));
            data.restante = data.max - data.enAux;

            if ($(this).data("debe") * 1 != 0) {
                $(".spRazon").text("Haber");
                $("#spAsiento").text(number_format($(this).data("debe"), 2, ".", ""));
            } else {
                $(".spRazon").text("Debe");
                $("#spAsiento").text(number_format($(this).data("haber"), 2, ".", ""));
            }
            $("#spAsignado").text(number_format(data.enAux, 2, ".", ""));
            $("#spAsignar").text(number_format(data.restante, 2, ".", ""));

            data.debe = $(this).data("debe");
            data.haber = $(this).data("haber");

            $("#agregar_axul").data(data);
            $("#agregar_axul").attr("debe", $(this).data("debe"));
            $("#agregar_axul").attr("haber", $(this).data("haber"));

            var id = $(this).attr("idAs");
            $("#idAsiento").val(id);
            $("#cab").show();

            cargarAuxiliares();
            $('#modal-auxiliares').modal('show')
        });
        $("#agregar_axul").click(function () {
            var $btn = $(this);
            var btnRestante = $btn.data("restante");
            btnRestante = number_format(btnRestante, 2, ".", "") * 1
            var btnMax = $btn.data("max");
            var btnEnAux = $btn.data("enAux");
            var errores = "";
            var valor = $.trim($("#valor").val());
            var asientoId = $("#idAsiento").val();
            var td = $("#td option:selected").val();
            var referencia = $.trim($("#ref").val());
            var razon;
            if (parseFloat($(this).data("debe")) != 0)
                razon = "H";
            else
                razon = "D";
//            //console.log($(".auxbtn").data("debe"),$(".auxbtn").data("haber"),razon,$(this))
            var des = $.trim($("[name=descripcionAux]").val());
            var pro = $("#pr option:selected").val();
            var fecha = $.trim($("#fecha-aux_input").val());
            if (pro == undefined) {
                pro = "-1";
            }

            if (des == "") {
                errores += "<li>Ingrese la descripción</li>";
            }
            if (fecha == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese la fecha</li>";
            }
            if (valor == "") {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ingrese el valor</li>";
            }
            if (btnRestante == 0 || btnMax == btnEnAux) {
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ya ha ingresado el valor total de este asiento.</li>"
            } else if (parseFloat(valor) > btnRestante * 1) {
                console.log(valor, btnRestante)
                if (errores != "") {
                    errores += "<br/>";
                }
                errores += "<li>Ha sobrepasado el valor límite. La sumatoria de los pagos progamados no debe exceder " + number_format(btnMax, 2, ".", "");
                errores += "<br/>(Valor máximo para este asiento: " + number_format(btnRestante, 2, ".", "") + ")</li>";
            }

            if (isNaN(valor)) {
                valor = 0;
            }

            if (parseFloat(valor) <= 0) {
                if (errores != "") {
                    errores += "\n";
                }
                errores += "<li>Ingrese un valor superior a 0</li>";
            }

            if (errores == "") {

                openLoader()
                $.ajax({
                    type    : "POST",
                    url     : "${g.createLink(controller: 'proceso',action: 'nuevoAuxiliar')}",
                    data    : "asiento.id=" + asientoId + "&tipoDocumento.id=" + td + "&valor=" + valor + "&razon=" + razon + "&descripcion=" + des + "&proceso=" + $("#idProceso").val() + "&proveedor.id=" + pro + "&fechaPago=" + fecha + "&referencia=" + referencia,
                    success : function (msg) {
                        closeLoader()
                        $("#listaAuxl").html("");
                        $("#listaAuxl").html(msg).show("slide", 700);
                        $("#td option:first").attr("selected", "selected");
                        $("#valor").val("0.00");
                        $('input[name=tipo]').attr('checked', true);
                        $("[name=descripcionAux]").val("");
                        $("#pr option:first").attr("selected", true);
                        $("#fecha-aux_input").val("");
                        $btn.data("enAux", btnEnAux + parseFloat(valor));
                        $btn.data("restante", btnRestante - parseFloat(valor));
                        $("#spAsignado").text(number_format($btn.data("enAux"), 2, ".", ""));
                        $("#spAsignar").text(number_format($btn.data("restante"), 2, ".", ""));
                    }
                });
            } else {
                closeLoader()
                bootbox.alert("Por favor corrija lo siguiente:<br/><ul>" + errores + "</ul>")
            }

        });
//        $(".bs").buttonset();
    });
</script>