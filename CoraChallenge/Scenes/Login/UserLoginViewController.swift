//
//  UserLoginViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/21/22.
//

import UIKit

class UserLoginViewController: UIViewController {
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, cpfLabel, cpfTextView, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .coraBackgroundWhite
        return stackView
    }()
    
    
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bem-vindo de volta!"
        return label
    }()
    
    lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Qual seu CPF?"
        return label
    }()
    
    lazy var cpfTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.heightAnchor.
        
        return textView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coraMediumGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 16
        button.setTitle("Próximo", for: .normal)
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
    }
    
    func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false

        let navBar = self.navigationController?.navigationBar
        self.title = "Login Cora"
        navBar?.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Avenir-Roman", size: 14)!,
                                       NSAttributedString.Key.foregroundColor : UIColor.coraDarkGray]
        navBar?.backgroundColor = .coraLightGray
        navBar?.tintColor = .coraPink
        navBar?.backItem?.title = ""
        
        let backButtonImage = UIImage(named: "nav_bar_back_button")
        navBar?.backIndicatorImage = backButtonImage
        navBar?.backIndicatorTransitionMaskImage = backButtonImage
    }
    
    //MARK: - Actions
    
    @objc func nextButtonAction() {
        print("NEXT BUTTON TAPPED")
    }
    
}

extension UserLoginViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(mainStack)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func viewCodeAditionalSetup() {
        setupNavigationBar()
    }
}
