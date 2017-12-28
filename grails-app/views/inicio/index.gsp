<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Cratos</title>
    <style type="text/css">

    * {
        margin: 0;
        padding: 0;
    }
    body {
        background: rgb(123, 158, 158);
        /*background: rgb(195, 145, 60);*/
    }
    #hexGrid {
        display: flex;
        flex-wrap: wrap;
        width: 90%;
        margin: 0 auto;
        overflow: hidden;
        font-family: 'Raleway', sans-serif;
        /*font-family: 'Tulpen One', cursive;*/
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
        color: #050666;
        font-weight: 300;
        -webkit-transition:  -webkit-transform .2s ease-out, opacity .1s ease-out;
        transition:          transform .2s ease-out, opacity .1s ease-out;
        /*font-family: 'Tulpen One', cursive;*/
        /*font-size: 28px;*/
        font-size: 18px;
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

%{--<h1 style="text-align: center; font-family: 'Tulpen One', cursive">${session.empresa.nombre}</h1>--}%

<p style="text-align: center; font-family: 'Tulpen One', cursive; font-size: 60px">${session.empresa.nombre}</p>

<ul id="hexGrid">

    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'proceso', action: 'buscarPrcs')}">
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
                <p>Plan de Cuentas de la Empresa</p>
            </a>
        </div>
    </li>
    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'proveedor', action: 'clientesList')}">
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
            <a class="hexLink" href="${createLink(controller: 'mantenimientoItems', action: 'arbol')}">
                <img src="${resource(dir: 'images',file: 'prod1.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                <h1>Artículos de Inventario</h1>
                <p>Artículos de Inventario</p>
            </a>
        </div>
    </li>
    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'gestorContable', action: 'buscarGstr')}">
                <img src="${resource(dir: 'images',file: 'gestor1.png')}" alt=""  style="width: 100%; height: 100%" />
                <h1>Gestor</h1>
                <p>Gestor contable o procesos tipo</p>
            </a>
        </div>
    </li>
    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'contabilidad', action: 'list')}">
                <img src="${resource(dir: 'images',file: 'contaImagen.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                <h1>Contabilidad</h1>
                <p>Contabilidad</p>
            </a>
        </div>
    </li>
    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'reportes', action: 'index')}">
                <img src="${resource(dir: 'images',file: 'reportesImagen.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                <h1>Reportes</h1>
                <p>Reportes</p>
            </a>
        </div>
    </li>

%{--
    <li class="hex">
        <div class="hexIn">
            <a class="hexLink" href="${createLink(controller: 'servicioSri', action: 'firmaSri')}">
                <img src="${resource(dir: 'images',file: 'firmaImagen.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                <h1>Firmar</h1>
                <p>Firmar xml</p>
            </a>
        </div>
    </li>
--}%
    <li class="hex">
        <div class="hexIn">
            <g:if test="${session.perfil.nombre == 'Administrador General'}">
                <a class="hexLink" href="${createLink(controller: 'inicio', action: 'parametros')}">
                    <img src="${resource(dir: 'images',file: 'param1.jpeg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Parámetros</h1>
                    <p>Parámetros</p>
                </a>
            </g:if>
            <g:if test="${session.perfil.nombre == 'Administrador'}">
                <a class="hexLink" href="${createLink(controller: 'inicio', action: 'parametrosEmpresa')}">
                    <img src="${resource(dir: 'images',file: 'param1.jpeg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Parámetros Empresa</h1>
                    <p>Parámetros</p>
                </a>
            </g:if>
        </div>
    </li>

    %{--<li class="hex">--}%
        %{--<div class="hexIn">--}%
            %{--<a class="hexLink" href="${createLink(controller: 'proceso', action: 'buscarPrcs')}">--}%
                %{--<img src="${resource(dir: 'images',file: 'ventas1.jpg')}" alt="" style="width: 100%; height: 100%"/>--}%
                %{--<h1>Facturación</h1>--}%
                %{--<p>Facturas</p>--}%
            %{--</a>--}%
        %{--</div>--}%
    %{--</li>--}%
    <li class="hex">
        <div class="hexIn">
            <g:if test="${session.perfil.nombre == 'Administrador General' || session.perfil.nombre == 'Administrador'}">
                <a class="hexLink" href="${createLink(controller: 'persona', action: 'list')}">
                    <img src="${resource(dir: 'images',file: 'usuariosImagen.jpg')}" alt=""  style="width: 100%; height: 100%"/>
                    <h1>Usuarios</h1>
                    <p>Usuarios</p>
                </a>
            </g:if>
        </div>
    </li>

</ul>

</body>
</html>