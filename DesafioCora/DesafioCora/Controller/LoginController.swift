//
//  LoginController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit

class LoginController: BaseViewController {
    
    let viewModel = OrderListViewModel()
    let viewModelLogin = LoginViewModel()
    let authViewModel = AuthenticationViewModel()
    
    private lazy var contentView: LoginView = {
        var view = LoginView(viewModel: viewModelLogin)
        view.loginAction = loginPressed
        view.signUpAction = signUpPressed
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initializeHideKeyboard()
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    func loginPressed() {
        dismissMyKeyboard()
        self.showLoadingAnimation()
        requestUser()
    }
    
    private func requestUser() {
        authViewModel.requestUser(mail: viewModelLogin.mail ?? "", password: viewModelLogin.password ?? "") { (error) in
            if let err = error {
                self.hiddenLoadingAnimation()
                self.showAlert(alertText: "Error", alertMessage: "\(err.localizedDescription)")
            } else {
                let goToOrderListVc = OrderListController(viewModel: self.viewModel)
                goToOrderListVc.modalPresentationStyle = .fullScreen
                self.present(goToOrderListVc, animated: true, completion: nil)
                self.hiddenLoadingAnimation()
            }
        }
    }
    
    private func signUpPressed() {
        let goToSignUpScreen = SignUpController()
        let navVC = UINavigationController(rootViewController: goToSignUpScreen)
//        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
}
