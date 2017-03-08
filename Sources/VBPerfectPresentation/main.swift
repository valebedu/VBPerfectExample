//
//  main.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import VBPerfectArchitecture
import VBPerfectBusiness

// Create HTTP server.
let server = HTTPServer()

// Create routers
let userRouter = VBPerfectRessourceRouter(endpoint: UserConfigurator.sharedInstance.endpoint, id: UserConfigurator.sharedInstance.id, controller: UserController())

// Register your own routes
var routes = Routes(baseUri: "v1")
routes.add(userRouter.routes)

// Add the routes to the server.
server.addRoutes(routes)

// Set a listen port of 8181
server.serverPort = 8181

do
{
    // Launch the HTTP server.
    try server.start()
}
catch
{
    Log.terminal(message: "\(error)")
}
