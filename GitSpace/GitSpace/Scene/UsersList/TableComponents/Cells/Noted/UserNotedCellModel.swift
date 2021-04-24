//
//  UserNotedCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct UserNotedCellModel: UserCell {
    
    var cellIdentifier: String {
        return UserNotedCell.reuseIdentifier
    }
    
    let id: Int
    var username: String
    let details: String
    let avatarUrl: String
    
}
