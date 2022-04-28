//
//  UserLoginViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/21/22.
//

import UIKit

class UserLoginViewController: BaseViewController {
    
    lazy var screen: UserLoginView = {
        let view = UserLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewCodeSetup()
        screen.delegate = self
        title = "Login Cora"
    }
}

extension UserLoginViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(screen)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            screen.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func viewCodeAditionalSetup() {
        view.backgroundColor = .coraBackgroundWhite
        screen.regularLabelText = "Bem-vindo de volta!"
        screen.boldLabelText = "Qual o seu CPF?"
        screen.nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
        screen.isLinkButtonHidden = true
        screen.isPassword = false
    }
}

extension UserLoginViewController: UserLoginViewDelegate {
    @objc func missPasswordButton() {
        print("FORGET PASSWORD")
    }
    
    @objc func nextButtonPressed() {
        print("Button NEXT TOUCHED")
        CoraLoginRouter.goToPassword(from: self)
    }
}
