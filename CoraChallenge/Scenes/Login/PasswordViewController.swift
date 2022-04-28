//
//  PasswordViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/22/22.
//

import UIKit

class PasswordViewController: BaseViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Login Cora"
    }
}

extension PasswordViewController: ViewCodeProtocol {
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
        screen.regularLabelText = nil
        screen.boldLabelText = "Digite sua senha de acesso"
        screen.nextButton.addTarget(self, action: #selector(self.nextButtonPressed), for: .touchUpInside)
        screen.isLinkButtonHidden = false
        screen.isPassword = true
    }
}

extension PasswordViewController: UserLoginViewDelegate {
    @objc func missPasswordButton() {
        print("FORGET PASSWORD")
    }
    
    @objc func nextButtonPressed() {
        print("Button NEXT TOUCHED")
        CoraLoginRouter.goToStatement(from: self)
    }
}
