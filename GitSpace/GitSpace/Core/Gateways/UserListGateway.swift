//
//  UserListGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

typealias UserListCompletion = (_ result: Result<[GithubUserEntity], Error>) -> Void

protocol UserListGateway {
    func fetchUsers(since id: Int, completion: @escaping UserListCompletion)
    func saveUsers(_ users: [GithubUserEntity])
}
