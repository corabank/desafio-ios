//
//  SignUpController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit
import Firebase

class SignUpController: BaseViewController {
    
    // MARK: - Constants
    
    let viewModelSignUp = SignUpViewModel()
    let authViewModel = AuthenticationViewModel()
    var ref: DatabaseReference!
    
    // MARK: - Private properties
    
    private lazy var viewSignUp: SignUpView = {
        var view = SignUpView(viewModel: viewModelSignUp)
        view.signUpAction = submmitPressed
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "signup"
        view.backgroundColor = .white
        ref = Database.database().reference()
        initializeHideKeyboard()
        setupNavigation()
    }
    
    override func loadView() {
        super.loadView()
        view = viewSignUp
    }
    
    // MARK: - Public functions
    
    /// function responsible for registering the user in firebase if it does not have incorrect data, for example: badly formatted email or password with at least 6 characters
    func submmitPressed() {
        let userData: [String: Any] = [
            "name": viewModelSignUp.name ?? ""
        ]
        
        authViewModel.signUpUser(viewModelSignUp.mail ?? "", viewModelSignUp.password ?? "") { (result, error) in
            if let err = error {
                self.showAlert(alertText: "Erro", alertMessage: err.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                self.showAlert(alertText: "Sucesso!!!", alertMessage: "Usuário criado. =-)")
            }
        }
    }
}
