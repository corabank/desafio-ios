//
//  OrderListViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderListViewController: DKViewController<OrderListRouter> {
    
    fileprivate var interactor: OrderListInteractorProtocol? { return self.getAbstractInteractor() as? OrderListInteractorProtocol }
    fileprivate var router: OrderListRouter? { return self.getAbstractRouter() as? OrderListRouter }
    
    public var user: UserEntity?
    public var codeView: OrderListView?
    public var dataSource: OrderListTableViewDataSource?
    
    override func loadView() {
        super.loadView()
        self.codeView = OrderListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cbDarkBlue
        setupCodeView()
        setupNavigation()
        setupTableView()
        setupSelectionAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeView?.navigationView.logoImage.isHidden = false
        self.refresh()
    }
    
    private func setupCodeView() {
        guard let codeView = self.codeView else { return }
        
        view.addSubview(codeView)
        codeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        codeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        codeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        codeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupNavigation() {
        codeView?.navigationView.userName = user?.userName ?? ""
    }
    
    private func setupTableView() {
        guard let tableView = codeView?.tableView else { return }
        dataSource = OrderListTableViewDataSource(tableView)
        tableView.reloadData()
    }
    
    public func setupSelectionAction() {
        dataSource?.onSelect = { [weak self] viewModel in
            self?.router?.showDetail(orderID: viewModel.id)
        }
    }
    
    private func refresh() {
        dataSource?.cells = []
        codeView?.tableView.reloadData()
        
        showLoading(true)
        async {
            self.interactor?.fetchOrderList()
        }
    }
    
    public func updateDataSource(viewModel: [OrderValueViewModel]) {
        self.showLoading(false)
        dataSource?.cells = viewModel
        codeView?.tableView.reloadData()
    }
    
    public func showError() {
        self.alert("error_message".localized, title: "error_title".localized)
    }
}

extension OrderListViewController: OrderListViewControllerProtocol {
    func updateHeader(viewModel: OrderListHeaderViewModel) {
        codeView?.headerView.setup(viewModel)
    }
    
    func updateOrderList(viewModel: [OrderValueViewModel]) {
        self.updateDataSource(viewModel: viewModel)
    }
    
    func alertErrorLoadingData() {
        self.showError()
    }
    
    func showLoading(_ visible: Bool) {
        codeView?.loading.isHidden = !visible
    }
}

