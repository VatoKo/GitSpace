//
//  CellConfiguration.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

protocol CellViewModel {
    func configure(with model: CellModel)
}


protocol CellModel {
    var cellIdentifier: String { get }
}
