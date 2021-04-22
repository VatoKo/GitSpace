//  
//  UserProfileConfigurator.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileConfigurator {
    func configure(_ controller: UserProfileController)
}

class UserProfileConfiguratorImpl: UserProfileConfigurator {
    
    func configure(_ controller: UserProfileController) {
        let router: UserProfileRouter = UserProfileRouterImpl(controller)
        
        let presenter: UserProfilePresenter = UserProfilePresenterImpl(
            view: controller,
            router: router
        )
        
        controller.presenter = presenter
    }
    
}
