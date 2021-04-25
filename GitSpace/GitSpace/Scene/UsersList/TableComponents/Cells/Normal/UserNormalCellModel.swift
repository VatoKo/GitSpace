//
//  UserNormalCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserCell: CellModel {
    var id: Int { get set }
    var username: String { get set }
}

class UserNormalCellModel: UserCell {
    
    var cellIdentifier: String {
        UserNormalCell.reuseIdentifier
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
