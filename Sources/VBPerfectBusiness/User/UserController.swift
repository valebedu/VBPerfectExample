//
//  UserController.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import Foundation
import PerfectHTTP
import PerfectLib
import VBPerfectArchitecture
import VBPerfectEntities

public class UserController: VBPerfectRessourceController
{
    public var output: VBPerfectInteractor!
    
    public required init()
    {
        UserConfigurator.sharedInstance.configure(controller: self)
    }
    
    public func handleList(request: HTTPRequest, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceInteractor
        {
            var options = try! VBPerfectStoreOptions(order: nil, limit: nil, page: nil)
            
            if !supportedMediaTypeAccept(request: request) || !supportedMediaTypeAcceptCharset(request: request) || !supportedMediaTypeAcceptEncoding(request: request)
            {
                response.status = .notAcceptable
            }
            else
            {
                do
                {
                    options = try VBPerfectStoreOptions(request: request)
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .badRequest
                }
            }
            
            output.fetchList(identifiers: nil, options: options, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    public func handleRetrieve(request: HTTPRequest, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceInteractor
        {
            var identifiers = [String: String]()
            
            if !supportedMediaTypeAccept(request: request) || !supportedMediaTypeAcceptCharset(request: request) || !supportedMediaTypeAcceptEncoding(request: request)
            {
                response.status = .notAcceptable
            }
            else
            {
                if let userId = request.urlVariables[UserConfigurator.sharedInstance.id]
                {
                    identifiers[UserConfigurator.sharedInstance.id] = userId
                }
                else
                {
                    Log.error(message: "Id empty")
                    
                    response.status = .badRequest
                }
            }
            
            output.fetchRetrieve(identifiers: identifiers, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    public func handleCreate(request: HTTPRequest, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceInteractor
        {
            var user: User?
            
            if !supportedMediaTypeAcceptCharset(request: request) || !supportedMediaTypeAcceptEncoding(request: request)
            {
                response.status = .notAcceptable
            }
            else if !supportedMediaTypeContentType(request: request)
            {
                response.status = .unsupportedMediaType
            }
            else
            {
                do
                {
                    if let body = try request.postBodyString?.jsonDecode() as? [String: Any]
                    {
                        do
                        {
                            user = try User(body: body)
                        }
                        catch
                        {
                            Log.error(message: "\(error)")
                            
                            response.status = .badRequest
                        }
                    }
                    else
                    {
                        Log.error(message: "Post body empty")
                        
                        response.status = .badRequest
                    }
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .badRequest
                }
            }
            
            output.fetchCreate(identifiers: nil, ressource: user, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    public func handleUpdate(request: HTTPRequest, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceInteractor
        {
            var identifiers = [String: String]()
            var user: User?
            
            if !supportedMediaTypeAcceptCharset(request: request) || !supportedMediaTypeAcceptEncoding(request: request)
            {
                response.status = .notAcceptable
            }
            else if !supportedMediaTypeContentType(request: request)
            {
                response.status = .unsupportedMediaType
            }
            else
            {
                do
                {
                    if let userId = request.urlVariables[UserConfigurator.sharedInstance.id], let body = try request.postBodyString?.jsonDecode() as? [String: Any]
                    {
                        identifiers[UserConfigurator.sharedInstance.id] = userId
                        
                        do
                        {
                            user = try User(body: body)
                        }
                        catch
                        {
                            Log.error(message: "\(error)")
                            
                            response.status = .badRequest
                        }
                    }
                    else
                    {
                        Log.error(message: "Id empty AND/OR body empty")
                        
                        response.status = .badRequest
                    }
                }
                catch
                {
                    Log.error(message: "\(error)")
                    
                    response.status = .badRequest
                }
            }
            
            output.fetchUpdate(identifiers: identifiers, ressource: user, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
    
    public func handleDelete(request: HTTPRequest, response: HTTPResponse)
    {
        if let output = output as? VBPerfectRessourceInteractor
        {
            output.fetchDelete(identifiers: nil, response: response)
        }
        else
        {
            Log.terminal(message: "Bad output")
        }
    }
}
