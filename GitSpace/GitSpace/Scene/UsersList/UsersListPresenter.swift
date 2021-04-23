//  
//  UsersListPresenter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UsersListView: AnyObject {
    func reloadList()
}

protocol UsersListPresenter {
    var tableDataSource: [CellModel] { get set }
    func viewDidLoad()
}

class UsersListPresenterImpl: UsersListPresenter {
    
    private weak var view: UsersListView?
    private var router: UsersListRouter
            
    private let userListUseCase: UserListUseCase
    
    var tableDataSource: [CellModel] = .init() {
        didSet {
            view?.reloadList()
        }
    }
    
    init(
        view: UsersListView,
        router: UsersListRouter,
        userListUseCase: UserListUseCase
    ) {
        self.view = view
        self.router = router
        self.userListUseCase = userListUseCase
    }
    
    func viewDidLoad() {
        userListUseCase.fetchUsers(since: 0) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self.tableDataSource = users.map { UserNormalCellModel(id: $0.id, username: $0.login, details: "", avatarUrl: $0.avatar_url) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
