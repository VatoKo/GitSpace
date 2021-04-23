//
//  ApiUserProfileGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

struct ApiUserProfileGateway: UserProfileGateway {
    
    func fetchUserProfileInfo(with username: String, completion: @escaping UserProfileCompletion) {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            completion(.failure(InvalidUrlError()))
            return
        }
        
        Fetcher<GithubUserProfileEntity>(url: url).fetch(completion: completion)
    }
    
    
}
