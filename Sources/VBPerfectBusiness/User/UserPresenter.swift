//
//  UserPresenter.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import PerfectLib
import PerfectHTTP
import VBPerfectArchitecture
import VBPerfectEntities

class UserPresenter: VBPerfectRessourcePresenter
{
    var output: VBPerfectController!
    
    func presentList(ressources: [Any]?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceController
        {
            if ok(response: response)
            {
                if let users = ressources as? [User]
                {
                    var usersJson = [UserJSON]()
                    
                    users.forEach({
                        user in
                        
                        usersJson.append(UserJSON(user: user))
                    })
                    
                    do
                    {
                        try response.setBody(string: usersJson.jsonEncodedString())
                        
                        response.setHeader(.contentType, value: "application/json")
                        response.status = .ok
                    }
                    catch
                    {
                        Log.error(message: "\(error)")
                        
                        response.status = .internalServerError
                    }
                }
                else
                {
                    Log.error(message: "\(VBPerfectStoreError.notFound(identifier: UserKeys.sharedInstance.className))")
                    
                    response.status = .noContent
                }
            }
            
            output.displayList(response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func presentRetrieve(ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceController
        {
            if ok(response: response)
            {
                if let user = ressource as? User
                {
                    let userJson = UserJSON(user: user)
                    
                    do
                    {
                        try response.setBody(string: userJson.jsonEncodedString())
                        
                        response.setHeader(.contentType, value: "application/json")
                        response.status = .ok
                    }
                    catch
                    {
                        Log.error(message: "\(error)")
                        
                        response.status = .internalServerError
                    }
                }
                else
                {
                    response.status = .notFound
                }
            }
            
            output.displayRetrieve(response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func presentCreate(ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceController
        {
            output.displayCreate(response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func presentUpdate(ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceController
        {
            if ok(response: response)
            {
                if let user = ressource as? User
                {
                    let userJson = UserJSON(user: user)
                    
                    do
                    {
                        try response.setBody(string: userJson.jsonEncodedString())
                        
                        response.setHeader(.contentType, value: "application/json")
                        response.status = .ok
                    }
                    catch
                    {
                        Log.error(message: "\(error)")
                        
                        response.status = .internalServerError
                    }
                }
                else
                {
                    response.status = .notFound
                }
            }
            
            output.displayUpdate(response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func presentDelete(ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceController
        {
            output.displayDelete(response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
}
