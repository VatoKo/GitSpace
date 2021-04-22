//  
//  UsersListPresenter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UsersListView: AnyObject {
    
}

protocol UsersListPresenter {
    
}

class UsersListPresenterImpl: UsersListPresenter {
    
    private weak var view: UsersListView?
    private var router: UsersListRouter
    
    init(view: UsersListView, router: UsersListRouter) {
        self.view = view
        self.router = router
    }
}
