//
//  UserWorker.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 05/03/2017.
//
//

import Foundation
import VBPerfectArchitecture

public class UserWorker: VBPerfectWorker
{
    public var store: VBPerfectStoreDatabase
    
    public required init(store: VBPerfectStoreDatabase)
    {
        self.store = store
    }
}
