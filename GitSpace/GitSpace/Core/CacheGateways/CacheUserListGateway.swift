//
//  CacheUserListGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 24.04.21.
//

import UIKit
import CoreData

struct CacheUserListGateway: UserListGateway {
    
    private let container: NSPersistentContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func fetchUsers(since id: Int, completion: @escaping UserListCompletion) {
        let cacher = Cacher<User, GithubUserEntity>.init(with: container)
        cacher.fetchFromCache { storedEntities in
            completion(.success(storedEntities))
        }
    }
    
    func saveUsers(_ users: [GithubUserEntity]) {
        let cacher = Cacher<User, GithubUserEntity>.init(with: container)
        cacher.storeInCache(contentsOf: users)
    }
    
}

struct ContainerNotFoundError: Error {
    
}
