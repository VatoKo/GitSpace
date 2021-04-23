//
//  GithubUserEntity.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct GithubUserEntity: Codable {
    let login: String
    let id: Int
    let avatar_url: String
}
