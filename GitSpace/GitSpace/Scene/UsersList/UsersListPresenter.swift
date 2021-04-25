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
    var searchValue: String { get set }
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
    
    var searchValue: String = String() {
        didSet {
            view?.reloadList()
        }
    }
    
    private var dataSource: [UserCell] = .init() {
        didSet {
            view?.reloadList()
        }
    }
    
    var tableDataSource: [UserCell] {
        get {
            if searchValue.isEmpty {
                return dataSource
            } else {
                return dataSource.filter { $0.username.contains(searchValue) }
            }
        }
        
        set {
            dataSource = newValue
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
                                                .enumerated()
                                                .map { index, item -> UserCell in self.getCellModel(at: index, entity: item) }
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
                    self.tableDataSource = users.enumerated()
                                                .map { index, item -> UserCell in self.getCellModel(at: index, entity: item) }
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
        guard searchValue.isEmpty else { return }
        
        apiUserListUseCase.fetchUsers(since: lastUserId) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self.tableDataSource.append(
                        contentsOf: users.enumerated()
                                         .map { index, item -> UserCell in self.getCellModel(at: index, entity: item) }
                    )
                    self.cacheUserListUseCase.saveUsers(users)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getCellModel(at index: Int, entity: GithubUserEntity) -> UserCell {
        if index % 4 == 3 {
            return UserInvertedCellModel(id: entity.id, username: entity.login, details: "Details", avatarUrl: entity.avatar_url)
        } else {
            return UserNormalCellModel(id: entity.id, username: entity.login, details: "Details", avatarUrl: entity.avatar_url)
        }
    }
    
}
