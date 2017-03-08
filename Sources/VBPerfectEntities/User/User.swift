//
//  User.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 20/02/2017.
//
//

import Foundation

public struct User: Entity
{
    private let keys = UserKeys.sharedInstance
    
    public var email: String
    public var password: String
    public var firstName: String
    public var lastName: String
    
    public var createdAt: Date?
    public var updatedAt: Date?
    
    public init (email: String, password: String, firstName: String, lastName: String, createdAt: Date?, updatedAt: Date?)
    {
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public init (body: [String: Any]) throws
    {
        if let email = body[keys.email] as? String, let password = body[keys.password] as? String, let firstName = body[keys.firstName] as? String, let lastName = body[keys.lastName] as? String
        {
            self.email = email
            self.password = password
            self.firstName = firstName
            self.lastName = lastName
        }
        else
        {
            throw EntityError.parsingFailed(body: body)
        }
    }
}
