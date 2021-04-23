//  
//  UsersListConfigurator.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UsersListConfigurator {
    func configure(_ controller: UsersListController)
}

class UsersListConfiguratorImpl: UsersListConfigurator {
    
    func configure(_ controller: UsersListController) {
        let router: UsersListRouter = UsersListRouterImpl(controller)
        
        let userListUseCase = UserListUseCaseImpl(gateway: ApiUserListGateway())
        
        let presenter: UsersListPresenter = UsersListPresenterImpl(
            view: controller,
            router: router,
            userListUseCase: userListUseCase
        )
        
        controller.presenter = presenter
    }
    
}
