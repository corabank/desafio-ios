//
//  LoginViewController.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

//sourcery: AutoMockable
protocol LoginViewControllerDelegate: AnyObject {
    func authenticated()
}

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelProtocol?
    weak var delegate: LoginViewControllerDelegate?

    var logoView: LogoView!
    var scrollView: UIScrollView!
    var mainStack: UIStackView!
    var emailTextInput: UITextField!
    var passwordTextInput: UITextField!
    var errorLabel: UILabel!
    var button: UIButton!
    var loading: UIActivityIndicatorView!
    var loginHeaderView: LoginHeaderview!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
        addTargets()
        addConstraints()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        emailTextInput.text = ""
        passwordTextInput.text = ""
        viewModel?.onUpdated = handleState
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
}

extension LoginViewController {
    
    func addTargets() {
        self.button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
    }
    
    @objc func onButtonTap() {
        // REMOVE
//        emailTextInput.text = "lucas.fernandes.silveira@gmail.com"
//        passwordTextInput.text = "caveira2021"
        //

        self.view.endEditing(true)
        loading.startAnimating()
        viewModel?.email = emailTextInput.text
        viewModel?.password = passwordTextInput.text
        viewModel?.login()
    }
    
    private func startAnimation() {
        scrollView.animateScroll()
        button.animateOpacity(from: 0.09, to: 1, withDuration: 0.3, andDelay: 0.4)
        logoView.animateOpacity(from: 0, to: 1, withDuration: 0.3, andDelay: 0.7)
    }

    // MARK: Constraints

    func addConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 260.dp),
            
            emailTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40.dp),
            emailTextInput.heightAnchor.constraint(equalToConstant: 54.dp),
            
            passwordTextInput.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40.dp),
            passwordTextInput.heightAnchor.constraint(equalToConstant: 54.dp),
            
            button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.dp),
            
            errorLabel.heightAnchor.constraint(equalToConstant: 20.dp),
            
            loading.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20.dp),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
