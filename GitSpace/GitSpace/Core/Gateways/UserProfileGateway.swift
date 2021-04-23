//
//  UserProfileGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

typealias UserProfileCompletion = (_ result: Result<GithubUserProfileEntity, Error>) -> Void

protocol UserProfileGateway {
    func fetchUserProfileInfo(with username: String, completion: @escaping UserProfileCompletion)
}
