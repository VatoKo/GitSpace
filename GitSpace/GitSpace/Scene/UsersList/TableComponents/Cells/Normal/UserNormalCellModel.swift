//
//  UserNormalCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

struct UserNormalCellModel: CellModel {
    
    var cellIdentifier: String {
        UserNormalCell.reuseIdentifier
    }
    
    let id: Int
    let username: String
    let details: String
    let avatarUrl: String
    
}
