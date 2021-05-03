//
//  LoginViewController+withUITextFieldDelegate.swift
//  cora
//
//  Created by Lucas Silveira on 27/04/21.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextInput || textField == passwordTextInput {
           textField.resignFirstResponder()
        }
        return true
    }
}
