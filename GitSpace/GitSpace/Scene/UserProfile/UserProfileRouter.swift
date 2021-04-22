//  
//  UserProfileRouter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileRouter {
    
}

class UserProfileRouterImpl: UserProfileRouter {
    
    private weak var controller: UserProfileController?
    
    init(_ controller: UserProfileController?) {
        self.controller = controller
    }
    
}
