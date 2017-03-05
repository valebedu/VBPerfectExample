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
}
