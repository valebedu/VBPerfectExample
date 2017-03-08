//
//  UserStoreMySQL.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 20/02/2017.
//
//

import Foundation
import PerfectLib
import VBPerfectArchitecture
import VBPerfectEntities
import VBPerfectMySQL

public class UserStoreMySQL: VBPerfectStoreMySQL, VBPerfectStoreDatabase
{
    let keys = UserKeys.sharedInstance
    
    public func count(identifiers: [String: Any]?) throws -> UInt64
    {
        guard identifiers == nil || identifiers?.count == 0 else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 0)
        }
        
        let query = "SELECT COUNT(*) " +
        "FROM \(keys.className);"
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
        
        let results = mySql.storeResults()!
        var count: UInt64 = 0
        
        results.forEachRow(callback: {
            row in
            
            if let rowCount = UInt64(row[0]!)
            {
                count = rowCount
            }
            else
            {
                Log.critical(message: "\(VBPerfectStoreMySQLError.parsingFailed)")
            }
        })
        
        return count
    }
    
    public func list(identifiers: [String: Any]?, options: VBPerfectStoreOptions) throws -> [Any]?
    {
        guard identifiers == nil || identifiers?.count == 0 else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 0)
        }
        
        var query = "SELECT * " +
            "FROM \(keys.className) "
        
        if options.order != nil && (options.order!.0 == keys.email || options.order!.0 == keys.firstName || options.order!.0 == keys.lastName)
        {
            query += "ORDER BY \(options.order!.0) "
            
            if !options.order!.1
            {
                query += "DESC "
            }
        }
        else
        {
            query += "ORDER BY \(keys.email) "
        }
        
        if options.limit != nil
        {
            query += "LIMIT \(options.limit!) "
        }
        else
        {
            query += "LIMIT 20 "
        }
        
        if options.page != nil
        {
            if options.limit != nil
            {
                query += "OFFSET \(options.page! * UInt64(options.limit!));"
            }
            else
            {
                query += "OFFSET \(options.page! * 20);"
            }
        }
        else
        {
            query += "OFFSET 0;"
        }
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
        
        let results = mySql.storeResults()!
        var users: [User] = []
        
        results.forEachRow(callback: {
            row in
            
            if let email = row[0], let password = row[1], let firstName = row[2], let lastName = row[3], let createdAt = row[4], let updatedAt = row[5], let dateCreatedAt = dateFormatter.date(from: createdAt), let dateUpdatedAt = dateFormatter.date(from: updatedAt)
            {
                users.append(User(email: email, password: password, firstName: firstName, lastName: lastName, createdAt: dateCreatedAt, updatedAt: dateUpdatedAt))
            }
            else
            {
                Log.critical(message: "\(VBPerfectStoreMySQLError.parsingFailed)")
            }
        })
        
        return users
    }
    
    public func retrieve(identifiers: [String: Any]) throws -> Any?
    {
        guard let email = identifiers[keys.email] else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 1)
        }
        
        let query = "SELECT * " +
            "FROM \(keys.className) " +
        "WHERE \(keys.email) = \"\(email)\";"
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
        
        let results = mySql.storeResults()!
        var users: [User] = []
        
        results.forEachRow(callback: {
            row in
            
            if let email = row[0], let password = row[1], let firstName = row[2], let lastName = row[3], let createdAt = row[4], let updatedAt = row[5], let dateCreatedAt = dateFormatter.date(from: createdAt), let dateUpdatedAt = dateFormatter.date(from: updatedAt)
            {
                users.append(User(email: email, password: password, firstName: firstName, lastName: lastName, createdAt: dateCreatedAt, updatedAt: dateUpdatedAt))
            }
            else
            {
                Log.critical(message: "\(VBPerfectStoreMySQLError.parsingFailed)")
            }
        })
        
        if users.count == 0
        {
            return nil
        }
        else if users.count > 1
        {
            throw VBPerfectStoreError.notSingle(identifier: users[0].email)
        }
        else
        {
            return users[0]
        }
    }
    
    public func create(identifiers: [String: Any]?, ressource: Any) throws
    {
        guard identifiers == nil || identifiers?.count == 0 else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 0)
        }
        
        guard let user = ressource as? User else
        {
            throw VBPerfectStoreError.ressourceNotExpected(ressource: ressource, expected: keys.className)
        }
        
        let createdDate = Date()
        
        let query = "INSERT INTO \(keys.className) (\(keys.email), \(keys.password), \(keys.firstName), \(keys.lastName), \(keys.createdAt), \(keys.updatedAt)) " +
        "VALUES (\"\(user.email)\", \"\(user.password)\", \"\(user.firstName)\", \"\(user.lastName)\", \"\(dateFormatter.string(from: createdDate))\", \"\(dateFormatter.string(from: createdDate))\");"
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
    }
    
    public func update(identifiers: [String: Any], ressource: Any) throws
    {
        guard let email = identifiers[keys.email] else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 1)
        }
        
        guard let user = ressource as? User else
        {
            throw VBPerfectStoreError.ressourceNotExpected(ressource: ressource, expected: keys.className)
        }
        
        let updatedDate = Date()
        
        let query = "UPDATE \(keys.className) " +
            "SET \(keys.email) = \"\(user.email)\", \(keys.password) = \"\(user.password)\", \(keys.firstName) = \"\(user.firstName)\", \(keys.lastName) = \"\(user.lastName)\", \(keys.updatedAt) = \"\(dateFormatter.string(from: updatedDate))\" " +
        "WHERE email = \"\(email)\";"
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
    }
    
    public func delete(identifiers: [String: Any]) throws
    {
        guard let email = identifiers[keys.email] else
        {
            throw VBPerfectStoreError.identifiersNotExpected(identifiers: identifiers, expected: 1)
        }
        
        let query = "DELETE FROM \(keys.className) " +
        "WHERE \(keys.email) = \"\(email)\";"
        
        let success = mySql.query(statement: query)
        
        guard success else
        {
            throw VBPerfectStoreMySQLError.querryFailed(code: mySql.errorCode(), message: mySql.errorMessage())
        }
    }
}
