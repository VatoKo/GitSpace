//  
//  UserProfilePresenter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileView: AnyObject {
    var pageTitle: String { get set }
    func configure(with profileInfo: GithubUserProfileEntity)
}

protocol UserProfilePresenter {
    func viewDidLoad()
}

class UserProfilePresenterImpl: UserProfilePresenter {
    
    private weak var view: UserProfileView?
    private var router: UserProfileRouter
    
    private let userProfileUseCase: UserProfileUseCase
    
    private var username: String
    
    init(
        view: UserProfileView,
        router: UserProfileRouter,
        userProfileUseCase: UserProfileUseCase,
        username: String
    ) {
        self.view = view
        self.router = router
        self.userProfileUseCase = userProfileUseCase
        self.username = username
    }
    
    func viewDidLoad() {
        view?.pageTitle = username
        userProfileUseCase.fetchUserProfileInfo(with: username) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let userProfileInfo):
                    self.view?.configure(with: userProfileInfo)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
