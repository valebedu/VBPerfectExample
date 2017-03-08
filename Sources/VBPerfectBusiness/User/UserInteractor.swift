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
                    if let usersDatabase = try worker!.list(identifiers: nil, options: options) as? [User]
                    {
                        users = usersDatabase
                        
                        response.status = .ok
                    }
                    else
                    {
                        Log.error(message: "\(VBPerfectStoreError.notFound(identifier: UserKeys.sharedInstance.className))")
                        
                        response.status = .noContent
                    }
                }
                catch let error as VBPerfectStoreError
                {
                    Log.error(message: "\(error)")
                    
                    switch error
                    {
                    case .alreadyExist:
                        response.status = .notAcceptable
                    case .identifiersNotExpected, .ressourceNotExpected:
                        response.status = .badRequest
                    default:
                        response.status = .internalServerError
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
                        
                        response.status = .ok
                    }
                    else
                    {
                        response.status = .notFound
                    }
                }
                catch let error as VBPerfectStoreError
                {
                    Log.error(message: "\(error)")
                    
                    switch error
                    {
                    case .alreadyExist:
                        response.status = .notAcceptable
                    case .identifiersNotExpected, .ressourceNotExpected:
                        response.status = .badRequest
                    default:
                        response.status = .internalServerError
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
            if ok(response: response)
            {
                if let user = ressource as? User
                {
                    do
                    {
                        try worker!.create(identifiers: nil, ressource: user)
                        
                        response.status = .created
                    }
                    catch let error as VBPerfectStoreError
                    {
                        Log.error(message: "\(error)")
                        
                        switch error
                        {
                        case .alreadyExist:
                            response.status = .notAcceptable
                        case .identifiersNotExpected, .ressourceNotExpected:
                            response.status = .badRequest
                        default:
                            response.status = .internalServerError
                        }
                    }
                    catch
                    {
                        Log.error(message: "\(error)")
                        
                        response.status = .internalServerError
                    }
                }
                else
                {
                    Log.error(message: "Should be throw before")
                    
                    response.status = .internalServerError
                }
            }
            
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
            let user = ressource as? User
            
            if ok(response: response)
            {
                if user != nil
                {
                    do
                    {
                        try worker!.update(identifiers: identifiers!, ressource: user!)
                        
                        response.status = .ok
                    }
                    catch let error as VBPerfectStoreError
                    {
                        Log.error(message: "\(error)")
                        
                        switch error
                        {
                        case .alreadyExist:
                            response.status = .notAcceptable
                        case .identifiersNotExpected, .ressourceNotExpected:
                            response.status = .badRequest
                        default:
                            response.status = .internalServerError
                        }
                    }
                    catch
                    {
                        Log.error(message: "\(error)")
                        
                        response.status = .internalServerError
                    }
                }
                else
                {
                    Log.error(message: "Should be throw before")
                    
                    response.status = .internalServerError
                }
            }
            
            output.presentUpdate(ressource: user, response: response)
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
            if ok(response: response)
            {
                do
                {
                    try worker!.delete(identifiers: identifiers!)
                    
                    response.status = .ok
                }
                catch let error as VBPerfectStoreError
                {
                    Log.error(message: "\(error)")
                    
                    switch error
                    {
                    case .alreadyExist:
                        response.status = .notAcceptable
                    case .identifiersNotExpected, .ressourceNotExpected:
                        response.status = .badRequest
                    default:
                        response.status = .internalServerError
                    }
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .internalServerError
                }
            }
            
            output.presentDelete(ressource: identifiers![UserConfigurator.sharedInstance.id], response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
}
