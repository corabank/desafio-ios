//
//  OrderListController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 11/03/21.
//

import UIKit
import Firebase
    
// MARK: - Protocols

    protocol DetailsGithubDataProtocol {
        func getValue(_ indexPath: IndexPath) -> Double
        func getMail(_ indexPath: IndexPath) -> String
        func getStatus(_ indexPath: IndexPath) -> Bool
        func getPayDay(_ indexPath: IndexPath) -> String
    }

class OrderListController: BaseViewController {
    
    // MARK: - Properties
    
    var ref: DatabaseReference!
    var orderListView = OrderListView()
    
    private lazy var contentView: OrderListView = {
        let view = OrderListView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(OrderListCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    var appUser: AppUser? {
        didSet {
            guard let username = appUser?.name else { return }
            contentView.currentUser.text = "Olá, \(username)"
        }
    }
    
    var viewModel: OrderListViewModel? {
        didSet {
            contentView.tableView.reloadData()
        }
    }
    
    // MARK: - Override & Initializers
    
    init(viewModel: OrderListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchUserInfo()
        view.backgroundColor = .white
        self.loadData()
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    // MARK: - Puclic functions
    
    func loadData() {
        viewModel?.getJsonSerializer { (error) in
            if let error = error {
                self.showError(error: error, buttonLabel: "Ok")
            } else {
                self.contentView.tableView.reloadData()
            }
        }
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

// MARK: - Extensions

extension OrderListController: UITableViewDelegate, UITableViewDataSource, DetailsGithubDataProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListCell
        cell.setup(purchaseValue: getValue(indexPath), currentEmail: getMail(indexPath), statusPayment: getStatus(indexPath), payDay: getPayDay(indexPath))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = InfoClientController(data: viewModel?.model[indexPath.row])
        let navVC = UINavigationController(rootViewController: infoVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        
    }
    
    func getValue(_ indexPath: IndexPath) -> Double {
        return viewModel?.model[indexPath.row].value ?? 0.0
    }
    
    func getMail(_ indexPath: IndexPath) -> String {
        return viewModel?.model[indexPath.row].mail ?? ""
    }
    
    func getStatus(_ indexPath: IndexPath) -> Bool {
        return viewModel?.model[indexPath.row].status ?? false
    }
    
    func getPayDay(_ indexPath: IndexPath) -> String {
        return viewModel?.model[indexPath.row].date ?? ""
    }
}
