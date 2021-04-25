//
//  UserInvertedCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation

class UserInvertedCellModel: UserCell {
    
    var cellIdentifier: String {
        return UserInvertedCell.reuseIdentifier
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
