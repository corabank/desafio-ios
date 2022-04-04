//
//  PasswordViewController.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 18/03/22.
//

import Foundation
import UIKit

class PasswordViewController: UIViewController {
    
    private let passwordView: PasswordView = {
        let passwordView = PasswordView()
        return passwordView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupButton()
        self.navigationItem.title = "Login Cora"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func loadView() {
        self.view = passwordView
    }
    
    func setupButton() {
        passwordView.continueButton.addTarget(self, action: #selector(pushToExtract), for: .touchUpInside)
    }
    
    @objc func pushToExtract() {
        let extractViewController = ExtractViewController()
        navigationController?.pushViewController(extractViewController, animated: true)
    }
}
