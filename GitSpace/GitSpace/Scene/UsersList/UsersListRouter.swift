//  
//  UsersListRouter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UsersListRouter {
    func navigateToUserProfile(with username: String)
}

class UsersListRouterImpl: UsersListRouter {
    
    private weak var controller: UsersListController?
    
    init(_ controller: UsersListController?) {
        self.controller = controller
    }
    
    func navigateToUserProfile(with username: String) {
        let vc = UserProfileController(username: username)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
