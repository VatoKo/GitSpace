//
//  Configurable.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol Configurable {
    associatedtype ObjectType = Self
    static func configured() -> ObjectType
}
