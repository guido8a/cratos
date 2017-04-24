<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 1/20/14
  Time: 4:03 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main">
        <title>Inicio</title>
        <style type="text/css">

        * {
            margin: 0;
            padding: 0;
        }
        body {
            background: rgb(123, 158, 158);
        }
        #hexGrid {
            display: flex;
            flex-wrap: wrap;
            width: 90%;
            margin: 0 auto;
            overflow: hidden;
            font-family: 'Raleway', sans-serif;
            font-size: 15px;
            list-style-type: none;
        }

        .hex {
            position: relative;
            visibility:hidden;
            outline:1px solid transparent; /* fix for jagged edges in FF on hover transition */

        }
        .hex::after{
            content:'';
            display:block;
            padding-bottom: 86.602%;  /* =  100 / tan(60) * 1.5 */

        }
        .hexIn{
            position: absolute;
            width:96%;
            padding-bottom: 110.851%; /* =  width / sin(60) */
            margin:0 2%;
            overflow: hidden;
            visibility: hidden;
            outline:1px solid transparent; /* fix for jagged edges in FF on hover transition */
            -webkit-transform: rotate3d(0,0,1,-60deg) skewY(30deg);
            -ms-transform: rotate3d(0,0,1,-60deg) skewY(30deg);
            transform: rotate3d(0,0,1,-60deg) skewY(30deg);
        }
        .hexIn * {
            position: absolute;
            visibility: visible;
            outline:1px solid transparent; /* fix for jagged edges in FF on hover transition */
        }
        .hexLink {
            display:block;
            width: 100%;
            height: 100%;
            text-align: center;
            color: #fff;
            overflow: hidden;
            -webkit-transform: skewY(-30deg) rotate3d(0,0,1,60deg);
            -ms-transform: skewY(-30deg) rotate3d(0,0,1,60deg);
            transform: skewY(-30deg) rotate3d(0,0,1,60deg);
        }

        /*** HEX CONTENT **********************************************************************/
        .hex img {
            left: -100%;
            right: -100%;
            width: auto;
            height: 100%;
            margin: 0 auto;
            -webkit-transform: rotate3d(0,0,0,0deg);
            -ms-transform: rotate3d(0,0,0,0deg);
            transform: rotate3d(0,0,0,0deg);
        }

        .hex h1, .hex p {
            width: 100%;
            padding: 5%;
            box-sizing:border-box;
            /*background-color: rgba(0, 128, 128, 0.8);*/
            background-color: #ffbd4c;
            font-weight: 300;
            -webkit-transition:  -webkit-transform .2s ease-out, opacity .3s ease-out;
            transition:          transform .2s ease-out, opacity .3s ease-out;
        }
        .hex h1 {
            bottom: 50%;
            padding-top:50%;
            font-size: 1.5em;
            z-index: 1;
            -webkit-transform:translate3d(0,-100%,0);
            -ms-transform:translate3d(0,-100%,0);
            transform:translate3d(0,-100%,0);
        }
        .hex h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 45%;
            width: 10%;
            text-align: center;
            border-bottom: 1px solid #fff;
        }
        .hex p {
            top: 50%;
            padding-bottom:50%;
            -webkit-transform:translate3d(0,100%,0);
            -ms-transform:translate3d(0,100%,0);
            transform:translate3d(0,100%,0);
        }


        /*** HOVER EFFECT  **********************************************************************/
        .hexLink:hover h1, .hexLink:focus h1,
        .hexLink:hover p, .hexLink:focus p{
            -webkit-transform:translate3d(0,0,0);
            -ms-transform:translate3d(0,0,0);
            transform:translate3d(0,0,0);
        }

        /*** HEXAGON SIZING AND EVEN ROW INDENTATION *****************************************************************/
        @media (min-width:1201px) { /* <- 5-4  hexagons per row */
            #hexGrid{
                padding-bottom: 4.4%
            }
            .hex {
                width: 20%; /* = 100 / 5 */
            }
            .hex:nth-child(9n+6){ /* first hexagon of even rows */
                margin-left:10%;  /* = width of .hex / 2  to indent even rows */
            }
        }

        @media (max-width: 1200px) and (min-width:901px) { /* <- 4-3  hexagons per row */
            #hexGrid{
                padding-bottom: 5.5%
            }
            .hex {
                width: 25%; /* = 100 / 4 */
            }
            .hex:nth-child(7n+5){ /* first hexagon of even rows */
                margin-left:12.5%;  /* = width of .hex / 2  to indent even rows */
            }
        }

        @media (max-width: 900px) and (min-width:601px) { /* <- 3-2  hexagons per row */
            #hexGrid{
                padding-bottom: 7.4%
            }
            .hex {
                width: 33.333%; /* = 100 / 3 */
            }
            .hex:nth-child(5n+4){ /* first hexagon of even rows */
                margin-left:16.666%;  /* = width of .hex / 2  to indent even rows */
            }
        }

        @media (max-width: 600px) { /* <- 2-1  hexagons per row */
            #hexGrid{
                padding-bottom: 11.2%
            }
            .hex {
                width: 50%; /* = 100 / 3 */
            }
            .hex:nth-child(3n+3){ /* first hexagon of even rows */
                margin-left:25%;  /* = width of .hex / 2  to indent even rows */
            }
        }

        @media (max-width: 400px) {
            #hexGrid {
                font-size: 13px;
            }
        }

        </style>

    </head>

    <body>


    <ul id="hexGrid">
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink"  href="${createLink(controller: 'ordenCompra', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'orden1.jpg')}" style="width: 100%; height: 100%"/>
                    <h1>Orden de Compra</h1>
                    <p>Orden de Compra</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'factura', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'ventas1.jpg')}" alt="" style="width: 100%; height: 100%"/>
                    <h1>Ventas</h1>
                    <p>Ventas</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'ordenCompra', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'adquisiciones1.jpg')}" alt="" style="width: 100%; height: 100%"/>
                    <h1>Adquisiciones</h1>
                    <p>Adquisiciones</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'proceso', action: 'lsta')}">
                    <img src="${resource(dir: 'images',file: 'conta1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Contabilidad</h1>
                    <p>Contabilidad</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'gestorContable', action: 'index')}">
                    <img src="${resource(dir: 'images',file: 'gestor1.png')}" alt=""  style="width: 100%; height: 100%" />
                    <h1>Gestor</h1>
                    <p>Gestor</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'proceso', action: 'nuevoProceso')}">
                    <img src="${resource(dir: 'images',file: 'transa1.jpeg')}" alt=""  style="width: 100%; height: 100%" />
                    <h1>Transacciones</h1>
                    <p>Transacciones</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'cuenta', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'plan2.jpeg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Plan de Cuentas</h1>
                    <p>Plan de Cuentas</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'proveedor', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'clientes1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Clientes</h1>
                    <p>Clientes</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'proveedor', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'prove1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Proveedores</h1>
                    <p>Proveedores</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'item', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'prod1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Productos</h1>
                    <p>Productos</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'inicio', action: 'parametros')}">
                    <img src="${resource(dir: 'images',file: 'param1.jpeg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Parámetros</h1>
                    <p>Parámetros</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'persona', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'usu1.jpeg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Usuarios</h1>
                    <p>Usuarios</p>
                </a>
            </div>
        </li>
        <li class="hex">
            <div class="hexIn">
                <a class="hexLink" href="${createLink(controller: 'reportes', action: 'index')}">
                    <img src="${resource(dir: 'images',file: 'reportes1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Reportes</h1>
                    <p>Reportes</p>
                </a>
            </div>
        </li>
    </ul>




    %{--<div style="width: 920px;height: 600px;margin: 27px;position: relative;">--}%

        %{--<div class="item ui-corner-all" style="position: absolute;top:10px;left: 200px;" accion="list" controlador="ordenCompra">--}%
            %{--<g:link action="list" controller="ordenCompra">--}%
                %{--<img src="${resource(dir: 'images',file: 'ordenCompra.gif')}" alt="" >--}%
                %{--Ordenes de compra--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:180px;left: 200px;">--}%
            %{--<g:link action="list" controller="ordenCompra">--}%
                %{--<img src="${resource(dir: 'images',file: 'adq.png')}" alt="" >--}%
                %{--Adquisiciones--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:180px;left: 600px;">--}%
            %{--<g:link action="list" controller="factura">--}%
                %{--<img src="${resource(dir: 'images',file: 'ventas.gif')}" alt="" >--}%
                %{--Ventas--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:390px;left: 400px;">--}%
            %{--<g:link action="lsta" controller="proceso">--}%
                %{--<img src="${resource(dir: 'images',file: 'contabilidad2.jpeg')}" alt="" >--}%
                %{--Contabilidad--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:390px;left: 5px;">--}%
            %{--<g:link action="index" controller="gestorContable">--}%
                %{--<img src="${resource(dir: 'images',file: 'gestor.jpeg')}" alt="" >--}%
                %{--Gestor--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:390px;left: 200px;">--}%
            %{--<g:link action="nuevoProceso" controller="proceso">--}%
                %{--<img src="${resource(dir: 'images',file: 'contabilidad.jpeg')}" alt="" >--}%
                %{--Transacciones--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:565px;left: 400px;">--}%
            %{--<g:link action="index" controller="reportes">--}%
                %{--<img src="${resource(dir: 'images',file: 'reportes.jpeg')}" alt="" >--}%
                %{--Reportes--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:180px;left: 5px;">--}%
            %{--<g:link action="list" controller="cuenta">--}%
                %{--<img src="${resource(dir: 'images',file: 'plan_cuentas.png')}" alt="" >--}%
                %{--Plan de cuentas--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:180px;left: 800px;">--}%
            %{--<g:link action="list" controller="proveedor">--}%
                %{--<img src="${resource(dir: 'images',file: 'clientes.jpeg')}" alt="" >--}%
                %{--Clientes--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:10px;left: 800px;">--}%
            %{--<g:link action="modificar" controller="persona">--}%
                %{--<img src="${resource(dir: 'images',file: 'usuarios.jpeg')}" alt="" >--}%
                %{--Usuarios--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:390px;left: 800px;">--}%
            %{--<g:link action="parametros" controller="inicio">--}%
                %{--<img src="${resource(dir: 'images',file: 'parametros.jpeg')}" alt="" >--}%
                %{--Parámetros--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:180px;left: 400px;">--}%
            %{--<g:link action="list" controller="proveedor">--}%
                %{--<img src="${resource(dir: 'images',file: 'proveedor.jpeg')}" alt="" >--}%
                %{--Proveedores--}%
            %{--</g:link>--}%
        %{--</div>--}%
        %{--<div class="item ui-corner-all" style="position: absolute;top:10px;left: 400px;">--}%
            %{--<g:link action="list" controller="item">--}%
                %{--<img src="${resource(dir: 'images',file: 'item.jpeg')}" alt="" >--}%
                %{--Productos--}%
            %{--</g:link>--}%
        %{--</div>--}%



        %{--Flechas--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:110px;left: 200px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_se.png')}" alt="" style="position: absolute;top:300px;left: 270px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_sw.png')}" alt="" style="position: absolute;top:300px;left: 540px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_e.png')}" alt="" style="position: absolute;top:410px;left: 105px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_e.png')}" alt="" style="position: absolute;top:410px;left: 305px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:490px;left: 400px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_s.png')}" alt="" style="position: absolute;top:300px;left: 5px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_n.png')}" alt="" style="position: absolute;top:115px;left: 400px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_w.png')}" alt="" style="position: absolute;top:190px;left: 700px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_w.png')}" alt="" style="position: absolute;top:20px;left: 300px">--}%
        %{--<img src="${resource(dir: 'images',file: 'flecha_se.png')}" alt="" style="position: absolute;top:50px;left: 520px">--}%
    %{--</div>--}%



    <script type="text/javascript">



//        $(".item").hover(function(){
//            var d =  $(this).find("img")
//            d.width(d.width()+10)
//            d.height(d.height()+10)
//        },function(){
//            var d =  $(this).find("img")
//            d.width(d.width()-10)
//            d.height(d.height()-10)
//        })


    </script>




    </body>
</html>