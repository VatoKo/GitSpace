//
//  GithubUserEntity.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation
import CoreData

struct GithubUserEntity: Codable {
    let login: String
    var id: Int
    let avatar_url: String
}

extension GithubUserEntity: CoreDataStorable {
    typealias ManagedObject = User
    
    func toManagedObject(with context: NSManagedObjectContext) -> User {
        let userMO = User(context: context)
        userMO.id = Int32(self.id)
        userMO.username = self.login
        userMO.avatarUrl = self.avatar_url        
        return userMO
    }
}
