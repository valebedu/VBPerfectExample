//
//  UserKeys.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 26/02/2017.
//
//

import Foundation

public class UserKeys
{
    public static let sharedInstance = UserKeys()
    
    public let className = "User"
    public let email = "email"
    public let password = "password"
    public let firstName = "firstName"
    public let lastName = "lastName"
    public let createdAt = "createdAt"
    public let updatedAt = "updatedAt"
    
    private init() {}
}
