//
//  UserConfigurator.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import VBPerfectArchitecture
import VBPerfectMySQL

public class UserConfigurator: VBPerfectConfigurator
{
    public static let sharedInstance = UserConfigurator()
    
    public let mySqlConfigurator = VBPerfectStoreMySQLConfigurator(host: "127.0.0.1", user: "root", password: "root", database: "EXAMPLE")
    public let endpoint = "users"
    public let id = "user"
    
    private init() {}
    
    public func configure(controller: VBPerfectController)
    {
        let interactor = UserInteractor()
        let presenter = UserPresenter()
        
        controller.output = interactor
        interactor.output = presenter
        presenter.output = controller
    }
}
