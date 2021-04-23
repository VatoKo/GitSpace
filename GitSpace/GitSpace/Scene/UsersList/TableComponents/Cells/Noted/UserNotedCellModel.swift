//
//  UserNotedCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct UserNotedCellModel: CellModel {
    
    var cellIdentifier: String {
        return UserNotedCell.reuseIdentifier
    }
    
    let id: Int
    let username: String
    let details: String
    let avatarUrl: String
    
}
