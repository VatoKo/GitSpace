//  
//  UserProfileController.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

class UserProfileController: UIViewController {

    var presenter: UserProfilePresenter?

    
}

extension UserProfileController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension UserProfileController: UserProfileView {
    
}

extension UserProfileController: Configurable {
    
    static func configured() -> UserProfileController {
        let vc = UserProfileController()
        let configurator = UserProfileConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}
