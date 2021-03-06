//  
//  UserProfileConfigurator.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileConfigurator {
    func configure(_ controller: UserProfileController, username: String)
}

class UserProfileConfiguratorImpl: UserProfileConfigurator {
    
    func configure(_ controller: UserProfileController, username: String) {
        let router: UserProfileRouter = UserProfileRouterImpl(controller)
        
        let userProfileUseCase = UserProfileUseCaseImpl(gateway: ApiUserProfileGateway())
        let cacheNotesUseCase = NotesUseCaseImpl(gateway: CacheNotesGateway())
        
        let presenter: UserProfilePresenter = UserProfilePresenterImpl(
            view: controller,
            router: router,
            userProfileUseCase: userProfileUseCase,
            cacheNotesUseCase: cacheNotesUseCase,
            username: username
        )
        
        controller.presenter = presenter
    }
    
}
