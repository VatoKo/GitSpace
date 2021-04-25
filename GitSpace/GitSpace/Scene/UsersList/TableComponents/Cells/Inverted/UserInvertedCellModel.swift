//
//  UserInvertedCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation

struct UserInvertedCellModel: UserCell {
    
    var cellIdentifier: String {
        return UserInvertedCell.reuseIdentifier
    }
    
    var id: Int
    var username: String
    let details: String
    let avatarUrl: String
    
}
