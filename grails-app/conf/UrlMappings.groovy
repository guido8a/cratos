class UrlMappings {

	static mappings = {
/*
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')
*/

        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "inicio", action: "index")
        "500"(view: '/error')
        "403"(controller: "shield",action: "error403")
        "404"(controller: "shield",action: "error404")
	}
}
