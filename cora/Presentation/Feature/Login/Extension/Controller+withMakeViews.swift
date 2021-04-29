//
//  Controller+withMakeViews.swift
//  cora
//
//  Created by Lucas Silveira on 28/04/21.
//

import UIKit

extension LoginViewController {
    
    func makeView() {
        let backgroundImage = UIImage(named: "background-2")!.resized(to: UIScreen.main.bounds.size)!
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
        
        // scrolliew
        scrollView = UIScrollView(frame: CGRect(x: 10,
                                                y: 10,
                                                width: view.frame.width - 20,
                                                height: UIScreen.main.bounds.height - 20))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: scrollView.frame.width,
                                        height: UIScreen.main.bounds.height)
        scrollView.keyboardDismissMode = .onDrag
        
        // main stack
        mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.distribution = .fill
        mainStack.spacing = 18
        
        // logo
        logoView = LogoView()
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.layer.opacity = 0
        scrollView.addSubview(logoView)
        
        // email text field
        emailTextInput = .custom(withIdentifier: "emailTextInput",
                                              withPlaceholder: "Fill your email".localized)
        emailTextInput.delegate = self
        mainStack.addArrangedSubview(emailTextInput)
        
        // password text field
        passwordTextInput = .custom(withIdentifier: "passwordTextInput",
                                                 withPlaceholder: "Fill your password".localized)
        passwordTextInput.isSecureTextEntry = true
        passwordTextInput.delegate = self
        mainStack.addArrangedSubview(passwordTextInput)
        
        // error label
        errorLabel = .errorLabel
        mainStack.addArrangedSubview(errorLabel)
        
        // button
        button = .loginButton
        button.layer.opacity = 0.09
        mainStack.addArrangedSubview(button)
        
        scrollView.addSubview(mainStack)
        view.addSubview(scrollView)
        
        // loading
        loading = UIActivityIndicatorView(style: .white)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.accessibilityIdentifier = "loading"
        view.addSubview(loading)
    }
    
    /// Header View
    func makeHeaderView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            var ordersSum: Int {
                State.shared.user?.orders.count ?? 0
            }
            
            var ordersValueSum: Double {
                State.shared.user?.orders.reduce(0) { $0 + $1.value } ?? 0
            }
            
            self.loginHeaderView = LoginHeaderview(userName: State.shared.user?.name ?? "",
                                              ordersSum: ordersSum.description,
                                              ordersDescription: ordersValueSum.toCurrency)
            self.loginHeaderView.layer.opacity = 0.1
            self.scrollView.addSubview(self.loginHeaderView)
            self.loginHeaderView.moveHeaderTitles()
        }
    }
}
