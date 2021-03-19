//
//  SignUpController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit
import Firebase

class SignUpController: BaseViewController {
    
    let viewModelSignUp = SignUpViewModel()
    let authViewModel = AuthenticationViewModel()
    var ref: DatabaseReference!
    
    private lazy var viewSignUp: SignUpView = {
        var view = SignUpView(viewModel: viewModelSignUp)
        view.signUpAction = submmitPressed
        return view
    }()
    
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
