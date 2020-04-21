//
//  KeyboardObserver.swift
//  PaladinKit
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation

public extension UIView {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        dismissKeyboard()
    }

    @objc private func handleKeyboardShow(notification: NSNotification){
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.keyboardWillShow(frame: keyboardFrame)
    }
    
    @objc open func keyboardWillShow(frame: CGRect) {}

    @objc private func handleKeyboardHide(notification: NSNotification){
        self.keyboardWillHide()
    }
    
    @objc open func keyboardWillHide() {}

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
