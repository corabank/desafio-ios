//
//  OrderListView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderListView: UIView {
    
    public let navigationView = OrderListNavigationView()
    public let headerView = OrderListHeaderView()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var tableViewHeader: UIView = {
        let view = UIView(frame: .zero)
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var loading = CBLoading()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension OrderListView: CodeView {
    func buildViewHierarchy() {
        addSubview(navigationView)
        addSubview(headerView)
        addSubview(tableView)
        addSubview(loading)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationHeight: CGFloat = 45
        let headerHeight: CGFloat = 77
        
        navigationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        navigationView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: navigationHeight).isActive = true
        
        headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        headerView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        loading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        loading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        loading.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        loading.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        tableViewHeader.heightAnchor.constraint(equalToConstant: navigationHeight + headerHeight).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        tableView.backgroundColor = .clear
        tableViewHeader.backgroundColor = .clear
        tableView.tableHeaderView = tableViewHeader
        loading.isHidden = true
    }
}
