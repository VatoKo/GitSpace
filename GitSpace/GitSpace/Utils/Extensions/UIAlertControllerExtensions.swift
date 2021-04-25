//
//  UIAlertControllerExtensions.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import UIKit

extension UIAlertController {
    
    static func showSimplePopup(title: String?, text: String? = nil, from vc: UIViewController) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
