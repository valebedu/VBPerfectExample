//
//  UserJSON.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 26/02/2017.
//
//

import PerfectLib

public class UserJSON: JSONConvertibleObject
{
    let keys = UserKeys.sharedInstance
    
    public var email: String = ""
    public var password: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var createdAt: String = ""
    public var updatedAt: String = ""
    
    public init(user: User)
    {
        super.init()
        
        email = user.email
        password = user.password
        firstName = user.firstName
        lastName = user.lastName
        createdAt = "\(user.createdAt)"
        updatedAt = "\(user.updatedAt)"
    }
    
    override public func setJSONValues(_ values: [String : Any])
    {
        email = getJSONValue(named: keys.email, from: values, defaultValue: "")
        password = getJSONValue(named: keys.password, from: values, defaultValue: "")
        firstName = getJSONValue(named: keys.firstName, from: values, defaultValue: "")
        lastName = getJSONValue(named: keys.lastName, from: values, defaultValue: "")
        createdAt = getJSONValue(named: keys.createdAt, from: values, defaultValue: "")
        updatedAt = getJSONValue(named: keys.updatedAt, from: values, defaultValue: "")
    }
    
    override public func getJSONValues() -> [String : Any]
    {
        return [
            keys.email: email,
            keys.firstName: firstName,
            keys.lastName: lastName,
            keys.createdAt: createdAt,
            keys.updatedAt: updatedAt
        ]
    }
}
