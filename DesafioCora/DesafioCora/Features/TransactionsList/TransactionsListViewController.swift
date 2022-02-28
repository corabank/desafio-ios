//
//  TransactionsListViewController.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation
import UIKit

protocol TransactionsListDisplaying: AnyObject {
    func displayTransactions()
    func displayError(title: String?, message: String?)
}

final class TransactionsListViewController: UIViewController {
    private lazy var headerView: TransactionsListHeaderView = {
        let header = TransactionsListHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TransactionCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let interactor: TransactionsListInteracting
    
    init(interactor: TransactionsListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        interactor.loadTransactions()
    }
    
    private func setupViews() {
        view.backgroundColor = .defaultBackground
        tableView.backgroundColor = .clear
        
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        view.addConstraints([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -8),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TransactionsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TransactionCell else {
            fatalError("Could not dequeue the a cell for this identifier!")
        }
        
        cell.configureCell(data: interactor.transactions[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.select(transaction: indexPath.row)
    }
}

extension TransactionsListViewController: TransactionsListDisplaying {
    func displayTransactions() {
        tableView.reloadData()
    }
    
    func displayError(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
}
