//
//  OrderListViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 11/03/21.
//

import UIKit
import Firebase

class OrderListViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var appUser: AppUser? {
        didSet {
            guard let username = appUser?.name else { return }
            navigationItem.title = username
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        view.backgroundColor = .systemGray
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? NSDictionary else { return }
              guard let username = data["name"] as? String else { return }
            self.appUser = AppUser(name: username, uid: userId)
        }
    }
}
