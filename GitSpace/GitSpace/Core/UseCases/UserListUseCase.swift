//
//  UserListUseCase.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

protocol UserListUseCase {
    func fetchUsers(since id: Int, completion: @escaping UserListCompletion)
    func saveUsers(_ users: [GithubUserEntity])
}

struct UserListUseCaseImpl: UserListUseCase {
    
    private let gateway: UserListGateway
    
    init(gateway: UserListGateway) {
        self.gateway = gateway
    }
    
    
    func fetchUsers(since id: Int, completion: @escaping UserListCompletion) {
        gateway.fetchUsers(since: id, completion: completion)
    }
    
    func saveUsers(_ users: [GithubUserEntity]) {
        gateway.saveUsers(users)
    }
    
}
