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
    var tableDataSource: [UserCell] { get set }
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func shouldLoadNextPage()
}

class UsersListPresenterImpl: UsersListPresenter {
    
    private weak var view: UsersListView?
    private var router: UsersListRouter
            
    private let apiUserListUseCase: UserListUseCase
    private let cacheUserListUseCase: UserListUseCase
    
    var tableDataSource: [UserCell] = .init() {
        didSet {
            view?.reloadList()
        }
    }
    
    private var lastUserId: Int {
        return tableDataSource.sorted(by: { $0.id < $1.id }).last?.id ?? 0
    }
    
    init(
        view: UsersListView,
        router: UsersListRouter,
        apiUserListUseCase: UserListUseCase,
        cacheUserListUseCase: UserListUseCase
    ) {
        self.view = view
        self.router = router
        self.apiUserListUseCase = apiUserListUseCase
        self.cacheUserListUseCase = cacheUserListUseCase
    }
    
    func viewDidLoad() {
        loadCachedUsers()
        fetchUsers()
    }
    
    private func loadCachedUsers() {
        cacheUserListUseCase.fetchUsers(since: 0) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self.tableDataSource = users.sorted(by: { $0.id < $1.id })
                                                .map { UserNormalCellModel(id: $0.id, username: $0.login, details: "Details", avatarUrl: $0.avatar_url) }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchUsers() {
        apiUserListUseCase.fetchUsers(since: 0) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self.tableDataSource = users.map { UserNormalCellModel(id: $0.id, username: $0.login, details: "Details", avatarUrl: $0.avatar_url) }
                    self.cacheUserListUseCase.saveUsers(users)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func didSelectItem(at index: Int) {
        let itemModel = tableDataSource[index]
        router.navigateToUserProfile(with: itemModel.username)
    }
    
    func shouldLoadNextPage() {
        apiUserListUseCase.fetchUsers(since: lastUserId) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self.tableDataSource.append(
                        contentsOf: users.map { UserNormalCellModel(id: $0.id, username: $0.login, details: "Details", avatarUrl: $0.avatar_url) }
                    )
                    self.cacheUserListUseCase.saveUsers(users)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
