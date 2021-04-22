//  
//  UsersListRouter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UsersListRouter {
    
}

class UsersListRouterImpl: UsersListRouter {
    
    private weak var controller: UsersListController?
    
    init(_ controller: UsersListController?) {
        self.controller = controller
    }
    
}
