//
//  StatementViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/23/22.
//

import UIKit

protocol StatementViewControllerProtocol {
    
}

class StatementViewController: UIViewController, StatementViewControllerProtocol {
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: self.view.frame)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .green
        return scroll
    }()
    
    lazy var statementTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .coraDarkGray
        return tableView
    }()
    
    var interactor: StatementInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coraBlue
        setupTableview()
        viewCodeSetup()
    }
    
    func setupTableview() {
        statementTableView.register(StatementTableViewCell.self, forCellReuseIdentifier: StatementTableViewCell.cellId)
        statementTableView.delegate = self
        statementTableView.dataSource = self
    }
}

extension StatementViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statementTableView.dequeueReusableCell(withIdentifier: StatementTableViewCell.cellId, for: indexPath) as! StatementTableViewCell
        cell.viewCodeSetup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select cell at \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
}

extension StatementViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(scrollView)
        scrollView.addSubview(statementTableView)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
            statementTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statementTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statementTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            statementTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
