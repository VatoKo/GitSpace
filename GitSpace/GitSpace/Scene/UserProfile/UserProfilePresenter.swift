//  
//  UserProfilePresenter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileView: AnyObject {
    
}

protocol UserProfilePresenter {
    
}

class UserProfilePresenterImpl: UserProfilePresenter {
    
    private weak var view: UserProfileView?
    private var router: UserProfileRouter
    
    init(view: UserProfileView, router: UserProfileRouter) {
        self.view = view
        self.router = router
    }
}
