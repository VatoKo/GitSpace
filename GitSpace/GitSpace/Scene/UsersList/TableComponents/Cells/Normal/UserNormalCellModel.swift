//
//  UserNormalCellModel.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

protocol UserCell: CellModel {
    var id: Int { get set }
    var username: String { get set }
}

struct UserNormalCellModel: UserCell {
    
    var cellIdentifier: String {
        UserNormalCell.reuseIdentifier
    }
    
    var id: Int
    var username: String
    let details: String
    let avatarUrl: String
    
}
