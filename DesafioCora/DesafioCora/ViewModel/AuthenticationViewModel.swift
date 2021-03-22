//
//  authenticationViewModel.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 19/03/21.
//

import Foundation
import Firebase

final class AuthenticationViewModel {
    
    // MARK: - Properties
    
    var ref: DatabaseReference!
    
    // MARK: - Public functions
    
    func requestUser(mail: String, password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> ()) {
        Auth.auth().signIn(withEmail: mail, password: password) { (user, error) in
            completionHandler(user, error)
        }
    }
    
    func signUpUser(_ mail: String,_ password: String, completionHandler: @escaping (AuthDataResult?, Error?) -> ()) {
        Auth.auth().createUser(withEmail: mail, password: password) { (result, error) in
            completionHandler(result, error)
        }
    }
}
