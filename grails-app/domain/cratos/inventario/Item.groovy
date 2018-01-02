package cratos.inventario

import cratos.sri.TarifaIVA

class Item implements Serializable {
    Unidad unidad
    TipoItem tipoItem
    DepartamentoItem departamento
    String codigo
    String nombre
    double peso
    Date fecha = new Date()
    Date fechaRegistro
    Date fechaModificacion
    String estado

    double stockMaximo
    double stockMinimo
    double precioVenta
    double precioCosto
    Marca marca
    TipoIVA tipoIVA

    double ice = 0 //porcentaje de ice q paga el item en decimal: 0.35 para 35%

    String observaciones
    String foto

    static auditable = true

    static mapping = {
        table 'item'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'item__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'item__id'
            unidad column: 'undd__id'
            tipoItem column: 'tpit__id'
            departamento column: 'dprt__id'
            codigo column: 'itemcdgo'
            nombre column: 'itemnmbr'
            peso column: 'itempeso'
            fecha column: 'itemfcha'
            fechaRegistro column: 'itemfcrg'
            fechaModificacion column: 'itemfcmd'
            estado column: 'itemetdo'

            stockMaximo column: 'itemstmx'
            stockMinimo column: 'itemstmn'
            precioVenta column: 'itempcvn'
            precioCosto column: 'itempccs'
            marca column: 'mrca__id'
            tipoIVA column: 'tpiv__id'
            ice column: 'item_ice'

            observaciones column: 'itemobsr'
            foto column: 'itemfoto'
        }
    }
    static constraints = {
        nombre(size: 1..160, blank: false, attributes: [title: 'nombre'])
        codigo(size: 1..30, blank: false, unique: true, attributes: [title: 'numero'])
        unidad(blank: true, nullable: true, attributes: [title: 'unidad'])
        tipoItem(blank: true, nullable: true, attributes: [title: 'tipoItem'])
        peso(blank: true, nullable: true, attributes: [title: 'peso'])
        departamento(blank: true, nullable: true, attributes: [title: 'departamento'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        fechaRegistro(blank: true, nullable: true, attributes: [title: 'fecha de registro'])
        fechaModificacion(blank: true, nullable: true, attributes: [title: 'fecha de ultima modificacion'])

        ice(blank: false, nullable: false, attributes: [title: '% de ice'])
        tipoIVA(blank: false, nullable: false, attributes: [title: '% de ice'])

        stockMaximo(blank: true, nullable: true, attributes: [title: 'stock máximo'])
        stockMinimo(blank: true, nullable: true, attributes: [title: 'stock mínimo'])
        precioVenta(blank: true, nullable: true, attributes: [title: 'precio de venta'])
        precioCosto(blank: true, nullable: true, attributes: [title: 'precio de costo'])
        marca(blank: true, nullable: true, attributes: [title: 'Marca'])

        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        foto(size: 1..100, blank: true, nullable: true)
    }

    String toString() {
        "${this.codigo} - ${this.nombre}"
    }
}