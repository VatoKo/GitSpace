//
//  UserProfileUseCase.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import Foundation

protocol UserProfileUseCase {
    func fetchUserProfileInfo(with username: String, completion: @escaping UserProfileCompletion)
}

struct UserProfileUseCaseImpl: UserProfileUseCase {
    
    private let gateway: UserProfileGateway
    
    init(gateway: UserProfileGateway) {
        self.gateway = gateway
    }
    
    func fetchUserProfileInfo(with username: String, completion: @escaping UserProfileCompletion) {
        gateway.fetchUserProfileInfo(with: username, completion: completion)
    }
    
    
}
