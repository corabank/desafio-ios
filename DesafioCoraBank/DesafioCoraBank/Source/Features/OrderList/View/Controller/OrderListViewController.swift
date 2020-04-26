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
    private var dataSource: OrderListTableViewDataSource?
    
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
        refresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeView?.navigationView.logoImage.isHidden = false
    }
    
    private func setupCodeView() {
        guard let codeView = self.codeView else { return }
        
        view.addSubview(codeView)
        codeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        codeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        codeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        codeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupNavigation() {
        codeView?.navigationView.userName = user?.userName ?? ""
    }
    
    private func setupTableView() {
        guard let tableView = codeView?.tableView else { return }
        dataSource = OrderListTableViewDataSource(tableView)
        tableView.reloadData()
    }
    
    private func setupSelectionAction() {
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
}

extension OrderListViewController: OrderListViewControllerProtocol {
    func updateHeader(viewModel: OrderListHeaderViewModel) {
        codeView?.headerView.setup(viewModel)
    }
    
    func updateOrderList(viewModel: [OrderValueViewModel]) {
        self.showLoading(false)
        dataSource?.cells = viewModel
        codeView?.tableView.reloadData()
    }
    
    func alertErrorLoadingData() {
        self.alert("error_message".localized, title: "error_title".localized, okButtonTitle: "error_try_again".localized) {
            self.refresh()
        }
    }
    
    func showLoading(_ visible: Bool) {
        codeView?.loading.isHidden = !visible
    }
}

