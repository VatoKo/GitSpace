//
//  ApiUserListGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct ApiUserListGateway: UserListGateway {
    
    func fetchUsers(since id: Int, completion: @escaping UserListCompletion) {
        guard let url = URL(string: "https://api.github.com/users?since=\(id)") else {
            completion(.failure(InvalidUrlError()))
            return
        }
        
        Fetcher<[GithubUserEntity]>(url: url).fetch(completion: completion)
    }
    
}

struct InvalidUrlError: Error {
    
}
