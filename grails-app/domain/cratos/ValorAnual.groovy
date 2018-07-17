package cratos

class ValorAnual implements Serializable{

    Periodo periodo
    int fraccionBasica
    int excesoHasta
    double impuesto
    int porcentaje

    static mapping = {
        table 'vlan'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'vlan__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'vlan__id'
            periodo column: 'prdo__id'
            fraccionBasica column: 'vlanfrbs'
            excesoHasta column: 'vlanexcs'
            impuesto column: 'vlanimps'
            porcentaje column: 'vlanpcnt'
        }
    }
    static constraints = {
        }
}
