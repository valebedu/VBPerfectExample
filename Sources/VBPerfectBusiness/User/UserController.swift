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
            output.fetchRetrieve(identifiers: nil, response: response)
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
            output.fetchCreate(identifiers: nil, ressource: nil, response: response)
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
            output.fetchUpdate(identifiers: nil, ressource: nil, response: response)
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
