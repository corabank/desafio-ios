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
    var orderListView: OrderListCollectionView!
    
     let contentView: OrderListCollectionView = {
        let view = OrderListCollectionView()
        view.backgroundColor = .white
        return view
    }()
    
    var appUser: AppUser? {
        didSet {
            guard let username = appUser?.name else { return }
            contentView.currentUser.text = "Olá, \(username)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchUserInfo()
        view.backgroundColor = .white
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(OrderListCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func loadView() {
        self.view = contentView
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

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OrderListCell
        cell.setup(purchaseValue: "R$ 110,00", currentEmail: "euclides.sena@hotmail.com", statusPayment: "Pago", payDay: "3 dias atrás")
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
  
}
