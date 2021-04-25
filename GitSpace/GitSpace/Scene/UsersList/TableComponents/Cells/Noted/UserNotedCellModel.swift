//
//  UserNotedCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

class UserNotedCellModel: UserCell {
    
    var cellIdentifier: String {
        return UserNotedCell.reuseIdentifier
    }
    
    var id: Int
    var username: String
    let details: String
    let avatarUrl: String
    var avatarData: Data?
    
    init(id: Int, username: String, details: String, avatarUrl: String) {
        self.id = id
        self.username = username
        self.details = details
        self.avatarUrl = avatarUrl
    }
}
