<%@ page import="cratos.inventario.Bodega" contentType="text/html" %>

<html>
<head>
    <meta name="layout" content="main"/>
    <title>Reportes</title>

    <style type="text/css">

    .tab-content, .left, .right {
        height : 600px;
    }

    .tab-content {
        /*background  : #EFE4D1;*/
        background  : #EEEEEE;
        border      : solid 1px #DDDDDD;
        padding-top : 10px;
    }

    .descripcion {
        /*margin-left : 20px;*/
        font-size : 12px;
        border    : solid 2px cadetblue;
        padding   : 0 10px;
        margin    : 0 10px 0 0;
    }

    .info {
        font-style : italic;
        color      : navy;
    }

    .descripcion h4 {
        color      : cadetblue;
        text-align : center;
    }

    .left {
        width : 710px;
        /*background : red;*/
    }

    .right {
        width       : 300px;
        margin-left : 40px;
        /*background  : blue;*/
    }

    .fa-ul li {
        margin-bottom : 10px;
    }

    .uno {

        float      : left;
        width      : 150px;
        margin-top : 10px;
    }

    .dos {

        float      : left;
        width      : 250px;
        margin-top : 10px;
    }

    .fila {
        height : 40px;
    }

    .textoUno {
        float : left;
        width : 250px;

    }

    .textoDos {
        float : left;

    }

    </style>

</head>

<body>
<div class="tab-content ui-corner-all">
    <div class="tab-pane active" id="reporte">
        <div class="left pull-left">
            <ul class="fa-ul">
                <li>
                    <span id="ats">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#modalAts">
                                    ATS
                                </a>
                            </div>
                            <div class="col-md-8">
                                Anexo transaccional simplificado
                            </div>
                        </div>
                    </span>

                    <div class="descripcion hide">
                        <h4>ATS</h4>

                        <p>Permite la generació del ATS en un período determinado.
                        </p>

                        <p>Se genera el anexo en xml conforme las especificaciones del SRI.</p>

                        <p>El sistema requiere que se seleccione la contabilidad o período contable.</p>
                    </div>
                </li>
                <li>
                    <span id="planDeCuentas">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#planCuentas">
                                    Plan de Cuentas
                                </a>
                            </div>
                            <div class="col-md-8">
                                Plan de cuentas o catálogo de cuentas de la contabilidad.
                            </div>
                        </div>
                    </span>

                    <div class="descripcion hide">
                        <h4>Plan de cuentas</h4>

                        <p>Se fija un catálogo de cuentas para cada periodo contable. Usualmente, el catálogo se conserva
                        de un período a otro, si hubieran cambios, se debe indicar las nuevas cuentas y su relación con las
                        cuentas del periodo anterior.
                        </p>

                        <p>Reporta el plan de cuentas con sus números de cuenta, cuenta padre, nivel y descripción o nombre de la cuenta.</p>

                        <p>El sistema requiere que se seleccione la contabilidad o período contable.</p>
                    </div>
                </li>
                <li>
                    <span id="gestor">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#gestorContable">
                                    Gestor Contable
                                </a>
                            </div>
                            <div class="col-md-8">
                                Determina las cuentas que son afectadas en un proceso contable

                            </div>
                        </div>
                    </span>

                    <div class="descripcion hide">
                        <h4>Gestor</h4>

                        <p>Para cada proceso contable es necesario definir las cuentas que van a participar.</p>

                        <p>El gestor permite la creación de comprobantes y asientos contables en forma automática.</p>

                        <p>Se reprotan todos los gestores contables que se hallen activos en el sistema.</p>
                    </div>
                </li>

                <li><span id="libroD">
                    <div class="row">
                        <div class="col-md-4">
                            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#libroDiario">
                                Libro Diario
                            </a>
                        </div>
                        <div class="col-md-8">
                            Libro Diario
                        </div>
                    </div>
                </span>

                    <div class="descripcion hide">
                        <h4>Libro Diario</h4>
                        <p>Libro Diario.</p>
                    </div>
                </li>


                <li><span id="situacionFi">
                    <div class="row">
                        <div class="col-md-4">
                            <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#situacionN">
                                Estado de Situación
                            </a>
                        </div>
                        <div class="col-md-8">
                            Estado de Situación
                        </div>
                    </div>
                </span>

                    <div class="descripcion hide">
                        <h4>Estado de Situación</h4>
                        <p>Estado de Situación financiera a una fecha determinada.</p>
                    </div>
                </li>

                <li>
                    <span id="balanceComprobacion">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#balance">
                                    Balance de Comprobación
                                </a>
                            </div>
                            <div class="col-md-8">
                                Muestra el balance de comprobaci&oacute;n en detalle a todos los niveles

                            </div>
                        </div>
                    </span>

                    <div class="descripcion hide">
                        <h4>Balance de Comprobaci&oacute;n</h4>

                        <p>Reporte del Balance de Comprobación para un mes determinado.</p>

                        <p>Este reporte muestra el total de los movimientos al debe y haber de todas las cuentas de movimiento, y
                        presenta también los saldos deudor o acreedor de cada una de ellas.</p>

                        <p>El reporte es hasta la fecha final del periodo seleccionado.</p>
                    </div>
                </li>
                <li>
                    <span id="estadoResultado">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#integral">
                                    Estado del Resultado Integral
                                </a>
                            </div>


                            <div class="col-md-8">
                                Este reporte se conocía como Estado de Pérdidas y Ganancias
                            </div>
                        </div>
                    </span>

                    <div class="descripcion hide">
                        <h4>Resultado Integral</h4>

                        <p>En este reporte se detallan todos los ingresos y egresos que han existido dentro del periodo contable, con lo
                        cual se llega de determinar la utilidad del período</p>

                        <p>El valor final reportado es el resultado de utilidades</p>
                    </div>
                </li>
                <li>
                    <span id="libroMayor">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-target="#auxiliar" data-toggle="modal">
                                    Libro Mayor
                                </a>
                            </div>
                            <div class="col-md-8">
                                Auxiliar Contable
                            </div>
                        </div>
                    </span>
                    <div class="descripcion hide">
                        <h4>Auxiliares Contables</h4>
                        <p>Auxiliares Contables</p>
                    </div>
                </li>
                <li>
                    <span id="reporteRetenciones">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-target="#retenciones" data-toggle="modal">
                                    Retenciones
                                </a>
                            </div>
                            <div class="col-md-8">
                                Retenciones
                            </div>
                        </div>
                    </span>
                    <div class="descripcion hide">
                        <h4>Retenciones</h4>
                        <p>Reporte de las retenciones generadas entre las fechas seleccionadas.</p>
                    </div>
                </li>
                <li>
                    <span id="reporteKardex">
                        <div class="row">
                            <div class="col-md-4">
                                <a href="#" class="link btn btn-info btn-ajax" data-target="#kardex" data-toggle="modal">
                                    Kardex
                                </a>
                            </div>
                            <div class="col-md-8">
                                Kardex
                            </div>
                        </div>
                    </span>
                    <div class="descripcion hide">
                        <h4>Kardex</h4>
                        <p>Reporte de las existencias de items dentro de cada bodega</p>
                    </div>
                </li>
                %{--<li>--}%
                %{--<span id="auxiliarCliente">--}%
                %{--<div class="row">--}%
                %{--<div class="col-md-4">--}%
                %{--<a href="#" class="link btn btn-info btn-ajax" data-target="#cliente" data-toggle="modal">--}%
                %{--Auxiliar por Cliente--}%
                %{--</a>--}%
                %{--</div>--}%
                %{--<div class="col-md-8">--}%
                %{--Auxiliar por cliente--}%

                %{--</div>--}%
                %{--</div>--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Auxiliares por Cliente</h4>--}%
                %{--<p>Auxiliares por Cliente</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                %{--<li>--}%
                %{--<span id="balanceGeneralAuxiliares">--}%
                %{--<div class="row">--}%
                %{--<div class="col-md-4">--}%
                %{--<a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#balanceAuxiliares">--}%
                %{--Balance general con auxiliares--}%
                %{--</a>--}%
                %{--</div>--}%
                %{--<div class="col-md-8">--}%
                %{--Balance general con auxiliares, o Estado de situación financiera--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Balance general con auxiliares</h4>--}%

                %{--<p>Balance general con auxiliares, o estado de situación financiera</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                %{--<li>--}%
                %{--<span id="balanceGeneral">--}%
                %{--<div class="row">--}%
                %{--<div class="col-md-4">--}%
                %{--<a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#general">--}%
                %{--Balance General--}%
                %{--</a>--}%
                %{--</div>--}%
                %{--<div class="col-md-8">--}%
                %{--Balance General--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Balance general</h4>--}%

                %{--<p>Balance general</p>--}%
                %{--</div>--}%
                %{--</li>--}%
                %{--<li>--}%
                %{--<span id="balanceGeneralCierre">--}%
                %{--<div class="row">--}%
                %{--<div class="col-md-4">--}%
                %{--<a href="#" class="link btn btn-info btn-ajax" data-toggle="modal" data-target="#generalCierre">--}%
                %{--Balance de cierre--}%
                %{--</a>--}%
                %{--</div>--}%
                %{--<div class="col-md-8">--}%
                %{--Balance de cierre--}%
                %{--</div>--}%
                %{--</div>--}%
                %{--</span>--}%

                %{--<div class="descripcion hide">--}%
                %{--<h4>Balance de cierre del periodo contable</h4>--}%

                %{--<p>Balance de cierre del periodo contable</p>--}%
                %{--</div>--}%
                %{--</li>--}%
            </ul>
        </div>

        <div class="reporte right pull-right">
        </div>
    </div>
</div>

<!-------------------------------------------- MODALES ----------------------------------------------------->
%{--//dialog de contabilidad--}%
<div class="modal fade" id="planCuentas" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Plan de Cuentas - Elegir Contabilidad</h4>
            </div>

            <div class="modal-body fila" style="margin-bottom: 30px">
                <label class="uno">Contabilidad:</label>
                <g:select name="contCuentas" id="contCuentas"
                          from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                          optionKey="id" optionValue="descripcion"
                          class="form-control dos"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarPlan btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog de gestor contable--}%
<div class="modal fade" id="gestorContable" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalGestor">Gestor Contable - Elegir Contabilidad</h4>
            </div>

            <div class="modal-body fila" style="margin-bottom: 30px">
                <label class="uno">Contabilidad:</label>
                <g:select name="contContable" id="contContable"
                          from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                          optionKey="id" optionValue="descripcion"
                          class="form-control dos"/>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarGestor btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog comprobante--}%
<div class="modal fade" id="comprobante" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalComprobante">Comprobante</h4>
            </div>

            <div class="modal-body">
                <div class="fila" style="margin-bottom: 10px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contComp" id="contComp"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion"
                              class="form-control dos"/>
                </div>

                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Tipo:</label>
                    <g:select class="form-control dos" name="compTipo" from="${cratos.TipoComprobante.list()}"  optionKey="id" optionValue="descripcion"/>
                </div>

                <div class="fila">
                    <label class="uno">Número:</label>
                    <div class="col-md-2" id="divNumComp" style="margin-left: -10px"></div>
                    <g:textField type="text" class="form-control dos number" name="compNum" maxlength="25" style="width: 200px; margin-top: -1px"/>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarComprobante btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog libro diario--}%
<div class="modal fade" id="libroDiario" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalLibroDiario">Libro Diario</h4>
            </div>

            <div class="modal-body" id="bodyLibro">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP11" id="contP11"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo11" class="fila">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarLibro btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog ATS--}%
<div class="modal fade" id="modalAts" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Generar ATS</h4>
            </div>

            <div class="modal-body">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contAts" id="contP20"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos" value="-1"/>
                </div>

                <div class="fila" id="divPeriodo20">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarAts btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog situación--}%
<div class="modal fade" id="situacionN" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalSituacionN">Situación</h4>
            </div>

            <div class="modal-body" id="bodySituacionN">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP15" id="contP15"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo15" class="fila" style="margin-bottom: 20px">
                    <label class="uno">Período:</label>
                </div>

                <div id="divNivel" class="fila">
                    <label class="uno">Nivel:</label>
                    <g:select name="nivel_name" from="${niveles}" optionKey="key" optionValue="value" id="nivelSituacion" class="form-control col-md-2" style="width: 100px"/>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarSituacionN btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog balance--}%
<div class="modal fade" id="balance" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalBalance">Balance</h4>
            </div>

            <div class="modal-body" id="bodyBalance">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP" id="contP"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo" class="fila">
                    <label class="uno">Período:</label>

                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarBalance btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog situacion financiera--}%
<div class="modal fade" id="situacion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalSituacion">Situación Financiera</h4>
            </div>

            <div class="modal-body" id="bodySituacion">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contP8" id="contP8"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos" />
                </div>

                <div id="divPeriodo8" class="fila">
                    <label class="uno">Período:</label>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarSituacion btn-success"><i class="fa fa-print"></i> Aceptar
                </button>
            </div>
        </div>
    </div>
</div>

%{--dialog resultado Integral--}%
<div class="modal fade" id="integral" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalIntegral">Estado del Resultado Integral</h4>
            </div>

            <div class="modal-body" id="bodyIntegral">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contP9" id="contP9"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>

                <div id="divPeriodo9" class="fila">
                    <label class="uno">Período:</label>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                </button>
                <button type="button" class="btn btnAceptarIntegral btn-success"><i class="fa fa-print"></i> Imprimir
                </button>
            </div>
        </div>
    </div>
</div>


%{--dialog libro mayor--}%
<div class="modal fade" id="auxiliar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalAuxiliar">Libro Mayor</h4>
            </div>

            <div class="modal-body" id="bodyAuxiliar">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contP3" id="contP3"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaD" class="datepicker form-control fechaDe"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaH" class="datepicker form-control fechaHa"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div id="divCuenta3" class="fila">

                    <div class="col-md-3">
                        <label class="uno">Cuenta:</label>
                    </div>

                    <g:hiddenField name="idCntaLibro" value="" />
                    <div class="col-md-6">
                        <g:textField name="cntaLibro" value="" class="form-control" />
                    </div>

                    <div class="col-md-2">
                        <a href="#" class="link btn btn-info btn-ajax" id="buscarCuenta">
                            <i class="fa fa-search"></i> Buscar
                        </a>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarAuxiliar btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


%{--dialog retenciones--}%
<div class="modal fade" id="retenciones" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalRetenciones">Retenciones</h4>
            </div>

            <div class="modal-body" id="bodyRetenciones">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>

                    <g:select name="contR" id="contR"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDR" class="datepicker form-control fechaDeR"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHR" class="datepicker form-control fechaHaR"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarRetenciones btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

%{--dialog retenciones--}%
<div class="modal fade" id="kardex" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="modalKardex">Kardex</h4>
            </div>

            <div class="modal-body" id="bodyKardex">
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Contabilidad:</label>
                    <g:select name="contK" id="contK"
                              from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"
                              class="form-control dos"/>
                </div>
                <div class="fila" style="margin-bottom: 15px">
                    <label class="uno">Bodega:</label>
                    <g:select name="bode_name" id="bode"
                              from="${cratos.inventario.Bodega.findAllByEmpresa(session.empresa, [sort: 'codigo'])}"
                              optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la bodega']"
                              class="form-control dos"/>
                </div>
                <div class="fila">
                    <div class="col-md-3">
                        <label>Desde: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaDesde" title="Fecha desde" id="fechaDK" class="datepicker form-control fechaDeK"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div class="fila">
                    <div class="col-md-3">
                        <label>Hasta: </label>
                    </div>
                    <div class="col-md-5">
                        <elm:datepicker name="fechaHasta" title="Fecha hasta" id="fechaHK" class="datepicker form-control fechaHaK"
                                        maxDate="new Date()"/>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar
                    </button>
                    <button type="button" class="btn btnAceptarKardex btn-success"><i class="fa fa-print"></i> Imprimir
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>




%{--dialog auxiliar por cliente--}%
%{--<div class="modal fade" id="cliente" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
    %{--<div class="modal-dialog">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header">--}%
                %{--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
                %{--<h4 class="modal-title" id="modalAuxCliente">Auxiliar por Cliente</h4>--}%
            %{--</div>--}%

            %{--<div class="modal-body" id="bodyAuxCliente">--}%
                %{--<div class="fila">--}%
                    %{--<label class="uno">Contabilidad:</label>--}%
                    %{--<g:select name="contP4" id="contP4"--}%
                              %{--from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"--}%
                              %{--optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"--}%
                              %{--class="ui-widget-content ui-corner-all dos"/>--}%
                %{--</div>--}%

                %{--<div id="divPeriodo4" class="fila">--}%
                    %{--<label class="uno">Periodo:</label>--}%
                %{--</div>--}%

                %{--<div id="divCliente" class="fila">--}%
                    %{--<label class="uno">Clientes:</label>--}%
                    %{--<g:select name="listaClientes" from="${clientes}" optionValue="nombre" optionKey="id"--}%
                              %{--class="dos" noSelection="['-1': 'Todos']"/>--}%

                %{--</div>--}%
            %{--</div>--}%

            %{--<div class="modal-footer">--}%
                %{--<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar--}%
                %{--</button>--}%
                %{--<button type="button" class="btn btnAceptarAuxCliente btn-success"><i class="fa fa-print"></i> Aceptar--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

%{--dialog balance x auxiliares--}%
%{--<div class="modal fade" id="balanceAuxiliares" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
    %{--<div class="modal-dialog">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header">--}%
                %{--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
                %{--<h4 class="modal-title" id="modalBalanceAux">Auxiliar por Cliente</h4>--}%
            %{--</div>--}%

            %{--<div class="modal-body" id="bodyBalanceAux">--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Contabilidad:</label>--}%
                    %{--<g:select name="contP0" id="contP0"--}%
                              %{--from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"--}%
                              %{--optionKey="id" optionValue="descripcion" noSelection="['': 'Seleccione la contabilidad']"--}%
                              %{--class="ui-widget-content ui-corner-all dos"/>--}%
                %{--</div>--}%

                %{--<div id="divPeriodo0" class="fila">--}%
                    %{--<label class="uno">Periodo:</label>--}%
                %{--</div>--}%

            %{--</div>--}%

            %{--<div class="modal-footer">--}%
                %{--<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar--}%
                %{--</button>--}%
                %{--<button type="button" class="btn btnAceptarBalanceAux btn-success"><i class="fa fa-print"></i> Aceptar--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

%{--dialog balance general--}%
%{--<div class="modal fade" id="general" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
    %{--<div class="modal-dialog">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header">--}%
                %{--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
                %{--<h4 class="modal-title" id="modalGeneral">Balance General</h4>--}%
            %{--</div>--}%

            %{--<div class="modal-body" id="bodyGeneral">--}%

                %{--<div style="margin-bottom: 10px;">--}%
                    %{--Antes de generar este reporte asegurese de configurar las cuentas para el cálculo de resultados <a href="${g.createLink(controller: 'cuenta', action: 'cuentaResultados')}" style="color: blue">Aquí</a>--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Contabilidad:</label>--}%
                    %{--<g:select name="contP6" id="contP6"--}%
                              %{--from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"--}%
                              %{--optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"--}%
                              %{--class="ui-widget-content ui-corner-all dos"/>--}%
                %{--</div>--}%

                %{--<div id="divPeriodo6" class="fila">--}%
                    %{--<label class="uno">Periodo:</label>--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Nivel:</label>--}%
                    %{--<select id="nivel" class="dos">--}%
                        %{--<option value="1,2">DOS</option>--}%
                        %{--<option value="1,2,3">TRES</option>--}%
                        %{--<option value="1,2,3,4">CUATRO</option>--}%
                        %{--<option value="1,2,3,4,5">CINCO</option>--}%
                    %{--</select>--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--Mostrar cuentas con saldo cero? <input type="checkbox" id="cero" value="1" checked="true">--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Firma:</label>--}%
                    %{--<input type="text" id="firma1" class="dos">--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Firma:</label>--}%
                    %{--<input type="text" id="firma2" class="dos">--}%
                %{--</div>--}%

            %{--</div>--}%

            %{--<div class="modal-footer">--}%
                %{--<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar--}%
                %{--</button>--}%
                %{--<button type="button" class="btn btnAceptarGeneral btn-success"><i class="fa fa-print"></i> Aceptar--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

%{--<div class="modal fade" id="generalCierre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--}%
    %{--<div class="modal-dialog">--}%
        %{--<div class="modal-content">--}%
            %{--<div class="modal-header">--}%
                %{--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--}%
                %{--<h4 class="modal-title" id="modalGeneralCierre">Balance General de cierre </h4>--}%
            %{--</div>--}%

            %{--<div class="modal-body" id="bodyGeneralCierre">--}%

                %{--<div style="margin-bottom: 10px;">--}%
                    %{--Antes de generar este reporte asegurese de configurar las cuentas para el cálculo de resultados <a href="${g.createLink(controller: 'cuenta', action: 'cuentaResultados')}" style="color: blue">Aquí</a>--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Contabilidad:</label>--}%
                    %{--<g:select name="contP6" id="contP6Cierre"--}%
                              %{--from="${cratos.Contabilidad.findAllByInstitucion(session.empresa, [sort: 'fechaInicio'])}"--}%
                              %{--optionKey="id" optionValue="descripcion" noSelection="['-1': 'Seleccione la contabilidad']"--}%
                              %{--class="ui-widget-content ui-corner-all dos"/>--}%
                %{--</div>--}%


                %{--<div class="fila">--}%
                    %{--<label class="uno">Nivel:</label>--}%
                    %{--<select id="nivelCierre" class="dos">--}%
                        %{--<option value="1,2">DOS</option>--}%
                        %{--<option value="1,2,3">TRES</option>--}%
                        %{--<option value="1,2,3,4">CUATRO</option>--}%
                        %{--<option value="1,2,3,4,5">CINCO</option>--}%
                    %{--</select>--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--Mostrar cuentas con saldo cero? <input type="checkbox" id="ceroCierre" value="1" checked="true">--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Firma:</label>--}%
                    %{--<input type="text" id="firma1Cierre" class="dos">--}%
                %{--</div>--}%

                %{--<div class="fila">--}%
                    %{--<label class="uno">Firma:</label>--}%
                    %{--<input type="text" id="firma2Cierre" class="dos">--}%
                %{--</div>--}%

            %{--</div>--}%

            %{--<div class="modal-footer">--}%
                %{--<button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> Cancelar--}%
                %{--</button>--}%
                %{--<button type="button" class="btn btnAceptarGeneralCierre btn-success"><i class="fa fa-print"></i> Aceptar--}%
                %{--</button>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

<!-------------------------------------------- MODALES ----------------------------------------------------->

<script type="text/javascript">

    $("#cntaLibro").dblclick(function () {
        buscarCuentas();
    });

    $("#buscarCuenta").click(function () {
        buscarCuentas();
    });

    function buscarCuentas () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'cuenta', action: 'buscadorCuentas_ajax')}',
            data:{

            },
            success: function (msg){
                bootbox.dialog({
                    title: 'Buscar cuenta',
                    message: msg,
                    class: 'long',
                    buttons:{
                        cancelar: {
                            label: "<i class='fa fa-times'></i> Cancelar",
                            className: "btn-primary",
                            callback: function () {
//                                bootbox.hideAll();
                            }
                        }
                    }
                })
            }
        });
    }


    cargarSelComprobante($("#compTipo option:selected").val());

    $("#compTipo").change(function () {
        var tipo = $("#compTipo option:selected").val();
        cargarSelComprobante(tipo)
    });

    function cargarSelComprobante (sel) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'prefijo_ajax')}',
            data:{
                tipo: sel
            },
            success: function (msg){
                $("#divNumComp").html(msg)
            }
        });
    }


    function prepare() {
        $(".fa-ul li span").each(function () {
            var id = $(this).parents(".tab-pane").attr("id");
            var thisId = $(this).attr("id");
            $(this).siblings(".descripcion").addClass(thisId).addClass("ui-corner-all").appendTo($(".right." + id));
        });
    }

    var actionUrl = "";

    function updateCuenta() {
        var per = $("#periodo2").val();
        ////console.log(per);
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'reportes2', action:'updateCuenta')}",
            data    : {
                per : per
            },
            success : function (msg) {
                $("#divCuenta").html(msg);
            }
        });
    }

    function updatePeriodo(cual) {
        var cont = $("#contP" + cual).val();

//                console.log("cont" + cont);

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'updatePeriodo')}",
            data    : {
                cont : cont,
                cual : cual
            },
            success : function (msg) {
                $("#divPeriodo" + cual).html(msg);
            }
        });
    }

    function updatePeriodoSinTodo(cual) {
        var cont = $("#contP" + cual).val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'updatePeriodoSinTodo')}",
            data    : {
                cont : cont,
                cual : cual
            },
            success : function (msg) {
                $("#divPeriodo" + cual).html(msg);
            }
        });

    }

    $(function () {
        prepare();
        $(".fa-ul li span").hover(function () {
            var thisId = $(this).attr("id");
            $("." + thisId).removeClass("hide");
        }, function () {
            var thisId = $(this).attr("id");
            $("." + thisId).addClass("hide");
        });

        /* ******************************** DIALOGS ********************************************* */

        %{--$(".link").hover(--}%
        %{--function () {--}%
        %{--$(this).addClass("linkHover");--}%
        %{--$(".notice").hide();--}%
        %{--var id = $(this).parent().attr("text");--}%
        %{--$("#" + id).show();--}%
        %{--},--}%
        %{--function () {--}%
        %{--$(this).removeClass("linkHover");--}%
        %{--$(".notice").hide();--}%
        %{--}).click(function () {--}%
        %{--var url = $(this).attr("href");--}%
        %{--var file = $(this).attr("file");--}%

        %{--var dialog = $.trim($(this).attr("dialog"));--}%

        %{--var cont = $.trim($(this).text());--}%

        %{--$("#" + dialog).dialog("option", "title", cont);--}%
        %{--$("#" + dialog).dialog("open");--}%

        %{--actionUrl = "${createLink(controller:'pdf',action:'pdfLink')}?filename=" + file + "&url=" + url;--}%
        %{--return false;--}%
        %{--});--}%

        $("#contP").change(function () {
            updatePeriodoSinTodo("");
        });
        $("#contP2").change(function () {
            updatePeriodoSinTodo("2");
        });

        $("#contP5").change(function () {
            updatePeriodoSinTodo("5");
        });
        $("#contP6").change(function () {
            updatePeriodoSinTodo("6");
        });

        $("#contP7").change(function () {
            updatePeriodoSinTodo("7");
        });
        $("#contP8").change(function () {
            updatePeriodoSinTodo("8");
        });
        $("#contP9").change(function () {
            updatePeriodoSinTodo("9");
        });

        $("#contP0").change(function () {
            updatePeriodoSinTodo("0");
        });

        $("#contP3").change(function () {
            updatePeriodo("3");
        });
        $("#contP4").change(function () {
            updatePeriodo("4");
        });
        $("#contP11").change(function () {
            updatePeriodoSinTodo("11");
        });

        $("#contP15").change(function () {
            updatePeriodoSinTodo("15");
        });

        $("#contP20").change(function () {
            updatePeriodoSinTodo("20");
        });

        $(".btnAceptarPlan").click(function () {
            var cont = $("#contCuentas").val()
            url = "${g.createLink(controller:'reportes' , action: 'planDeCuentas')}?cont=" + cont + "Wempresa=${session.empresa.id}";
            location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=planDeCuentas.pdf"

        });

        $(".btnAceptarGestor").click(function () {
            openLoader("Imprimiendo...")
            var cont = $("#contContable").val()
            url = "${g.createLink(controller:'reportes' , action: 'gestorContable')}?cont=" + cont + "Wempresa=${session.empresa.id}";
            location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=gestorContable.pdf"
            closeLoader()
        });

        %{--$(".btnAceptarComprobante").click(function () {--}%
        %{--var cont = $("#contComp").val();--}%
        %{--var tipo = $("#compTipo").val();--}%
        %{--var num = $("#compNum").val();--}%
        %{--$.ajax({--}%
        %{--type    : "POST",--}%
        %{--url     : "${createLink(controller: 'reportes3', action: 'reporteComprobante')}",--}%
        %{--data    : {--}%
        %{--cont : cont,--}%
        %{--tipo : tipo,--}%
        %{--num  : num--}%
        %{--},--}%
        %{--success : function (msg) {--}%
        %{--var parts = msg.split("_");--}%
        %{--if (parts[0] != "NO") {--}%
        %{--var url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompraGasto')}?id=" + msg + "Wempresa=${session.empresa.id}";--}%
        %{--location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobante.pdf"--}%
        %{--} else {--}%
        %{--bootbox.alert(parts[1])--}%
        %{--}--}%
        %{--}--}%
        %{--});--}%
        %{--});--}%


        $(".btnAceptarComprobante").click(function () {
            var cont = $("#contComp").val();
            var tipo = $("#compTipo").val();
            var url
            console.log("tipo " + tipo)
            var num = $("#compNum").val();
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'reportes3', action: 'reporteComprobante')}",
                data    : {
                    cont : cont,
                    tipo : tipo,
                    num  : num
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] != "NO") {
                        switch (tipo) {
                            case '1':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${session.empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteIngreso.pdf";
                                break;
                            case '2':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${session.empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteEgreso.pdf";
                                break;
                            case '3':
                                url = "${g.createLink(controller: 'reportes3', action: 'imprimirCompDiario')}?id=" + msg + "Wempresa=${session.empresa.id}";
                                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=comprobanteDiario.pdf";
                                break;
                        }
                    } else {
                        bootbox.alert(parts[1])
                    }
                }
            });
        });


        %{--$("#excelPrueba").click(function () {--}%
            %{--location.href = "${g.createLink(controller: 'reportes3', action: 'reporteExcel')}"--}%
        %{--});--}%


        $(".btnAceptarBalance").click(function () {
            var cont = $("#contP").val();
            var per = $("#periodo").val();
            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                url = "${g.createLink(controller:'reportes2' , action: 'balanceComprobacion')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wperiodo=" + per;
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=balanceComprobacion.pdf"

            }
        });

        $(".btnAceptarSituacion").click(function () {
            var cont = $("#contP8").val();
            var per = $("#periodo8").val();

            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                url = "${g.createLink(controller:'reportes2' , action: 'situacionFinanciera')}?cont=" + cont + "Wempresa=${session.empresa.id}" + "Wper=" + per;
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=situacionFinanciera.pdf"
            }
        });

        $(".btnAceptarIntegral").click(function () {
            var cont = $("#contP9").val();
            var per = $("#periodo9").val();

            if (cont == '-1') {
                bootbox.alert("Debe elegir una contabilidad!")
            } else {
                url = "${g.createLink(controller:'reportes2' , action: 'estadoDeResultados')}?cont=" + cont + "Wempresa=${session.empresa.id}" + "Wper=" + per;
                location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=resultadoIntegral.pdf"
            }
        });

        $(".btnAceptarAuxiliar").click(function () {
            var cont = $("#contP3").val();
            var per = $("#periodo3").val();
            var cnta = $("#idCntaLibro").val();
            var fechaDesde = $(".fechaDe").val();
            var fechaHasta = $(".fechaHa").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(cnta == ''){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una cuenta!")
                }else{
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    url = "${g.createLink(controller:'reportes2' , action: 'libroMayor')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wper=" + per + "Wcnta=" + cnta + "Wdesde=" + fechaDesde + "Whasta=" + fechaHasta;
                                    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=libroMayor.pdf"
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });

                    }
                }

            }
        });

        $(".btnAceptarRetenciones").click(function () {
            var cont = $("#contR").val();
            var fechaDesde = $(".fechaDeR").val();
            var fechaHasta = $(".fechaHaR").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    url = "${g.createLink(controller:'reportes2' , action: 'retenciones')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wdesde=" + fechaDesde + "Whasta=" + fechaHasta;
                                    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=retenciones.pdf"
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });

                    }
            }
        });

        $(".btnAceptarKardex").click(function () {
            var cont = $("#contK").val();
            var fechaDesde = $(".fechaDeK").val();
            var fechaHasta = $(".fechaHaK").val();
            var bodega = $("#bode").val();

            if (cont == '-1') {
                bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una contabilidad!")
            } else {
                if(bode == '-1'){
                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione una bodega!")
                }else{
                    if(fechaDesde == '' || fechaHasta == ''){
                        bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i>  Seleccione las fechas!")
                    }else{
                        $.ajax({
                            type: 'POST',
                            url: '${createLink(controller: 'proceso', action: 'revisarFecha_ajax')}',
                            data:{
                                desde: fechaDesde,
                                hasta: fechaHasta
                            },
                            success: function (msg){
                                if(msg == 'ok'){
                                    url = "${g.createLink(controller:'reportes2' , action: 'kardex')}?cont=" + cont + "Wemp=${session.empresa.id}" + "Wdesde=" + fechaDesde + "Whasta=" + fechaHasta + "Wbodega=" + bodega;
                                    location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=kardex.pdf"
                                }else{
                                    bootbox.alert("<i class='fa fa-exclamation-circle fa-3x pull-left text-warning text-shadow'></i> La fecha ingresada en 'Hasta' es menor a la fecha ingresada en 'Desde' ");
                                    return false;
                                }
                            }
                        });

                    }
                }
            }
        });


        %{--$(".btnAceptarAuxCliente").click(function () {--}%
            %{--var cont = $("#contP4").val();--}%
            %{--var per = $("#periodo4").val();--}%
            %{--var cli = $("#listaClientes").val();--}%

            %{--if (cont == '-1') {--}%
                %{--bootbox.alert("Debe elegir una contabilidad!")--}%
            %{--} else {--}%
                %{--var url = "${g.createLink(controller:'reportesNew' , action: 'auxiliarPorCliente')}?cont=" + cont + "&emp=${session.empresa.id}" + "&per=" + per + "&cli=" + cli + "&filename=auxiliaresXcliente";--}%
                %{--location.href = url--}%
            %{--}--}%

        %{--});--}%

        %{--$(".btnAceptarBalanceAux").click(function () {--}%
            %{--var cont = $("#contP0").val();--}%
            %{--var per = $("#periodo0").val();--}%

            %{--if (cont == '-1') {--}%
                %{--bootbox.alert("Debe elegir una contabilidad!")--}%
            %{--} else {--}%
                %{--url = "${g.createLink(controller:'reportes4' , action: 'balanceGeneralAux')}?cont=" + cont + "&emp=${session.empresa.id}" + "&per=" + per + "&filename=balancexAuxiliar";--}%
                %{--location.href = url--}%
            %{--}--}%
        %{--});--}%

        %{--$(".btnAceptarGeneral").click(function () {--}%
            %{--var cont = $("#contP6").val();--}%
            %{--var per = $("#periodo6").val();--}%
            %{--var ceros = "1"--}%
            %{--var firma1 = $("#firma1").val()--}%
            %{--var firma2 = $("#firma2").val()--}%
            %{--firma1 = $.trim(firma1)--}%
            %{--firma1 = firma1.replace(new RegExp(" ", "g"), "_");--}%
            %{--firma2 = $.trim(firma2)--}%
            %{--firma2 = firma2.replace(new RegExp(" ", "g"), "_");--}%
            %{--if ($("#cero").prop("checked")==false) {--}%
                %{--ceros = "0"--}%
            %{--}--}%
            %{--if (cont == '-1') {--}%
                %{--bootbox.alert("Debe elegir una contabilidad!")--}%
            %{--} else {--}%
                %{--url = "${g.createLink(controller:'reportes' , action: 'balanceG')}?contabilidad=" + cont + "Wperiodo=" + per + "Wempresa=${session.empresa.id}Wnivel=" + $("#nivel").val() + "Wceros=" + ceros + "Wfirma1=" + firma1 + "Wfirma2=" + firma2;--}%
                %{--location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=BalanceG.pdf"--}%
            %{--}--}%

        %{--});--}%
        %{--$(".btnAceptarGeneralCierre").click(function () {--}%
            %{--var cont = $("#contP6Cierre").val();--}%
            %{--//var per = $("#periodo6").val();--}%
            %{--var ceros = "1"--}%
            %{--var firma1 = $("#firma1Cierre").val()--}%
            %{--var firma2 = $("#firma2Cierre").val()--}%
            %{--firma1 = $.trim(firma1)--}%
            %{--firma1 = firma1.replace(new RegExp(" ", "g"), "_");--}%
            %{--firma2 = $.trim(firma2)--}%
            %{--firma2 = firma2.replace(new RegExp(" ", "g"), "_");--}%
            %{--if ($("#ceroCierre").prop("checked")==false) {--}%
                %{--ceros = "0"--}%
            %{--}--}%

            %{--if (cont == '-1') {--}%
                %{--bootbox.alert("Debe elegir una contabilidad!")--}%
            %{--} else {--}%
                %{--url = "${g.createLink(controller:'reportes' , action: 'balanceCierre')}?contabilidad=" + cont + "Wempresa=${session.empresa.id}Wnivel=" + $("#nivelCierre").val() + "Wceros=" + ceros + "Wfirma1=" + firma1 + "Wfirma2=" + firma2;--}%
                %{--location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=BalanceCierre.pdf"--}%
            %{--}--}%

        %{--});--}%

        $("#btnTodosPrv").button().click(function () {
            $("#hidVal").val("-1");
            $("#txtValor").val("Todos");
            return false;
        });

        $(".btnAceptarLibro").click(function () {
            var cont = $("#contP11").val();
            var per = $("#periodo11").val();
            var url = "${g.createLink(controller: 'reportes3', action: 'imprimirLibroDiario')}?cont=" + cont + "Wperiodo=" + per + "Wempresa=${session.empresa.id}";
            location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=libroDiario.pdf";
        });

        $(".btnAceptarAts").click(function () {
            var cont = $("#contP20").val();
            var prms = $("#periodo20").val();
            console.log('cont', cont, 'mes', prms)
            crearXML(prms, cont, 0);
        });

        $(".btnAceptarSituacionN").click(function () {
            var cont = $("#contP15").val();
            var per = $("#periodo15").val();
            var nivel = $("#nivelSituacion").val();
            var url = "${g.createLink(controller: 'reportes3', action: 'reporteSituacion')}?cont=" + cont + "Wperiodo=" + per + "Wempresa=${session.empresa.id}" + "Wnivel=" + nivel;
            location.href = "${g.createLink(action: 'pdfLink',controller: 'pdf')}?url=" + url + "&filename=situacion.pdf";
        });

        function crearXML(mes, anio, override) {
            $.ajax({
                type    : "POST",
                url     : "${createLink(controller: 'xml', action: 'createXml')}",
                data    : {
                    mes      : mes,
                    anio     : anio,
                    override : override
                },
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "NO") {
                        if (parts[1] == "1") {
                            var msgs = "Ya existe un archivo XML para el periodo " + mes + "-" + anio + "." +
                                "<ul><li>Si desea <strong>sobreescribir el archivo existente</strong>, haga click en el botón <strong>'Sobreescribir'</strong></li>" +
                                "<li>Si desea <strong>descargar el archivo previamente generado</strong>, haga click en el botón <strong>'Descargar'</strong></li>" +
                                "<li>Si desea <strong>ver la lista de archivos generados</strong>, haga cilck en el botón <strong>'Archivos'</strong></li></ul>";
                            bootbox.dialog({
                                title   : "Alerta",
                                message : msgs,
                                buttons : {
                                    sobreescribir : {
                                        label     : "<i class='fa fa-pencil'></i> Sobreescribir",
                                        className : "btn-primary",
                                        callback  : function () {
                                            crearXML(mes, anio, 1);
                                        }
                                    },
                                    descargar     : {
                                        label     : "<i class='fa fa-download'></i> Descargar",
                                        className : "btn-success",
                                        callback  : function () {
                                            location.href = "${createLink(controller: 'xml', action:'downloadFile')}?mes=" + mes;
                                        }
                                    },
                                    archivos      : {
                                        label     : "<i class='fa fa-files-o'></i> Archivos",
                                        className : "btn-default",
                                        callback  : function () {
                                            location.href = "${createLink(controller: 'xml', action:'downloads')}";
                                        }
                                    },
                                    cancelar      : {
                                        label     : "Cancelar",
                                        className : "btn-default",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    } else if (parts[0] == "OK") {
                        bootbox.dialog({
                            title   : "Descargar archivo",
                            message : "Archivo generado exitosamente",
                            buttons : {
                                descargar : {
                                    label     : "<i class='fa fa-download'> Descargar",
                                    className : "btn-success",
                                    callback  : function () {
                                        location.href = "${createLink(controller: 'xml', action:'downloadFile')}?mes=" + mes;
                                    }
                                }
                            }
                        });
                    }
                }
            });
        }


    });
</script>

</body>
</html>