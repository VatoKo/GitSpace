//
//  UIViewControllerExtensions.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 24.04.21.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnBlankTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
}
