//
//  UserInteractor.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import PerfectHTTP
import PerfectLib
import VBPerfectArchitecture
import VBPerfectMySQL
import VBPerfectPersistence
import VBPerfectEntities

class UserInteractor: VBPerfectRessourceInteractor
{
    let worker: UserWorker?
    
    var output: VBPerfectPresenter!
    
    init()
    {
        do
        {
            worker = try UserWorker(store: UserStoreMySQL(configurator: UserConfigurator.sharedInstance.mySqlConfigurator))
        }
        catch
        {
            Log.terminal(message: "\(error)")
        }
    }
    
    func fetchList(identifiers: [String : Any]?, options: VBPerfectStoreOptions, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourcePresenter
        {
            var users = [User]()
            
            if ok(response: response)
            {
                do
                {
                    if let usersDatabase = try worker!.list(identifiers: identifiers, options: options) as? [User]
                    {
                        users = usersDatabase
                    }
                    else
                    {
                        Log.error(message: "\(VBPerfectStoreError.notFound(identifier: UserKeys.sharedInstance.className))")
                        
                        response.status = .noContent
                    }
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .internalServerError
                }
            }
            
            output.presentList(ressources: users, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func fetchRetrieve(identifiers: [String : Any]?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourcePresenter
        {
            var user: User?
            
            if ok(response: response)
            {
                do
                {
                    if let userDatabase = try worker!.retrieve(identifiers: identifiers!) as? User
                    {
                        user = userDatabase
                    }
                    else
                    {
                        response.status = .notFound
                    }
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .internalServerError
                }
            }
            
            output.presentRetrieve(ressource: user, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func fetchCreate(identifiers: [String : Any]?, ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourcePresenter
        {
            output.presentCreate(ressource: nil, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func fetchUpdate(identifiers: [String : Any]?, ressource: Any?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourcePresenter
        {
            output.presentUpdate(ressource: nil, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    func fetchDelete(identifiers: [String : Any]?, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourcePresenter
        {
            output.presentDelete(ressource: nil, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
}
