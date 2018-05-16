package cratos.utilitarios

class DomainFixController {

    def migracionService

    def index() {

    }

    def valoresDominios(){
        flash.message = migracionService.arreglaDominios(params.dominio)
        redirect(action: "index")
        return
    }


    def secuencias(){

        render    migracionService.arreglarSecuencias()
    }
}