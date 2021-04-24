//
//  KeyboardResponsive.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 24.04.21.
//

import UIKit

protocol KeyboardResponsive {
    
    var contentScrollView: UIScrollView { get set }
    var contentView: UIView { get set }
    var keyboardAlignedToView: UIView { get }
    var spacingBetweenKeyboardAndView: CGFloat { get }
    
    func setupKeyboardResponsiveLayout()
    func addKeyboardNotificationListeners()
    func removeKeyboardNotificationListeners()
    
}

extension KeyboardResponsive where Self: UIViewController {
    
    var spacingBetweenKeyboardAndView: CGFloat {
        return 24
    }
    
}

// MARK: Setup
extension KeyboardResponsive where Self: UIViewController {
    
    func setupKeyboardResponsiveLayout() {
        view.addSubview(contentScrollView)
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        contentScrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor).isActive = true
        
        let equalWidth = contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        let equalHeight = contentView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor)
        equalHeight.priority = .defaultLow
        NSLayoutConstraint.activate([equalWidth, equalHeight])
    }
}

// MARK: Notification Listeners
extension KeyboardResponsive where Self: UIViewController {
 
    func addKeyboardNotificationListeners() {
        let center = NotificationCenter.default
        
        var showToken: NSObjectProtocol!
        showToken = center.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: { [weak self] notification in
                guard let self = self else {
                    if let token = showToken {
                        center.removeObserver(token)
                    }
                    return
                }
                self.keyboardWillShow(notification)
            }
        )
        
        var hideToken: NSObjectProtocol!
        hideToken = center.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: { [weak self] notification in
                guard let self = self else {
                    if let token = hideToken {
                        center.removeObserver(token)
                    }
                    return
                }
                self.keyboardWillHide(notification)
            }
        )
        
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let duration: Double = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        
        let keyboardY = keyboard.origin.y
        let bottom = contentBottom
        if keyboardY < bottom {
            UIView.animate(withDuration: duration) {
                self.contentScrollView.contentInset.bottom = keyboard.size.height + self.spacingBetweenKeyboardAndView
                self.contentScrollView.setContentOffset(.init(x: .zero, y: bottom - keyboardY), animated: false)
            }
        }
    }
    
    private func keyboardWillHide(_ notification: Notification) {
        let duration: Double = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        UIView.animate(withDuration: duration) {
            self.contentScrollView.contentInset = UIEdgeInsets.zero
            self.contentScrollView.setContentOffset(.init(x: CGFloat.zero, y: CGFloat.zero), animated: false)
        }
    }
    
    func removeKeyboardNotificationListeners() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: Helper Properties
extension KeyboardResponsive {

    private var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
    private var contentBottom: CGFloat {
        let frame = keyboardAlignedToView.superview!.convert(keyboardAlignedToView.frame, to: keyWindow)
        let height = frame.origin.y + frame.height
        return height + spacingBetweenKeyboardAndView
    }
}
