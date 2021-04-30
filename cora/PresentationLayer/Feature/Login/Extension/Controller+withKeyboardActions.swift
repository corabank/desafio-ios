//
//  Controller+withKeyboardActions.swift
//  cora
//
//  Created by Lucas Silveira on 29/04/21.
//

import UIKit

extension LoginViewController {
    // MARK: Keyboard
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChange(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.y = 0
        })
    }

    @objc func keyboardWillChange(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) != nil) {
            if emailTextInput.isFirstResponder {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = -self.emailTextInput.frame.origin.y
                })
            }
            
            if passwordTextInput.isFirstResponder {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = -self.passwordTextInput.frame.origin.y
                })
            }
        }
    }
}
