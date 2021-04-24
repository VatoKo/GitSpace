//
//  User.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 24.04.21.
//

import Foundation
import CoreData

class User: NSManagedObject {
    
}

extension User: CoreDataConvertible {
    typealias Entity = GithubUserEntity
    
    func toEntity() -> GithubUserEntity {
        let person = GithubUserEntity(login: self.username!, id: Int(self.id), avatar_url: self.avatarUrl!)
        return person
    }
}
