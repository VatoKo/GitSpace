//
//  GithubUserProfileEntity.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct GithubUserProfileEntity: Codable {
    let login: String
    let id: Int
    let avatar_url: String
    let followers: Int
    let following: Int
    let name: String
    let company: String?
    let blog: String
}
