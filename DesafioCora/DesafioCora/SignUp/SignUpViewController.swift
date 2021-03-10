//
//  SignUpViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        view.addSubview(signUpView)
    }
}
