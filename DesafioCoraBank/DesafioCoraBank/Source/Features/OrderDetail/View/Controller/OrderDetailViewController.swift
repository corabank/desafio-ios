//
//  OrderDetailViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class OrderDetailViewController: DKViewController<OrderDetailRouter> {
    
    fileprivate var interactor: OrderDetailInteractorProtocol? { return self.getAbstractInteractor() as? OrderDetailInteractorProtocol }
    fileprivate var router: OrderDetailRouter? { return self.getAbstractRouter() as? OrderDetailRouter }
    
    public var orderID: String?
    public var codeView: OrderDetailView?
    
    override func loadView() {
        super.loadView()
        self.codeView = OrderDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cbWhite
        setupCodeView()
        setupNavigation()
        refresh()
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
        codeView?.navigationView.onTouch = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func refresh() {
        guard let orderID = self.orderID else { return }
        
        clearStackView()
        showLoading(true)
        async { self.interactor?.fetchOrderDetail(orderID: orderID) }
    }
    
    private func clearStackView() {
        guard let stackView = codeView?.stackView else { return }
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
        }
    }
    
}

extension OrderDetailViewController: OrderDetailViewControllerProtocol {
    func addValueCell(viewModel: OrderValueViewModel) {
        let cell = OrderValueView()
        cell.setup(viewModel)
        cell.heightAnchor.constraint(equalToConstant: 80).isActive = true
        codeView?.stackView.addArrangedSubview(cell)
    }
    
    func addIconInfoCell(viewModel: OrderDetailIconInfoViewModel) {
        let cell = OrderDetailIconInfoView()
        cell.setup(viewModel)
        cell.heightAnchor.constraint(equalToConstant: 54).isActive = true
        codeView?.stackView.addArrangedSubview(cell)
    }
    
    func addSectionHeaderCell(viewModel: OrderDetailSectionHeaderViewModel) {
        
        let dummySeparatorView = UIView(frame: .zero)
        dummySeparatorView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        codeView?.stackView.addArrangedSubview(dummySeparatorView)
        
        let cell = OrderDetailSectionHeaderView()
        cell.setup(viewModel)
        cell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        codeView?.stackView.addArrangedSubview(cell)
    }
    
    func addTextInfoCell(viewModel: OrderDetailTextInfoViewModel) {
        let cell = OrderDetailTextInfoView()
        cell.setup(viewModel)
        cell.heightAnchor.constraint(equalToConstant: viewModel.cellHeight).isActive = true
        codeView?.stackView.addArrangedSubview(cell)
    }
    
    func addSandboxCell(viewModel: OrderDetailSandboxViewModel) {
        let cell = OrderDetailSandboxView()
        cell.setup(viewModel)
        cell.heightAnchor.constraint(equalToConstant: 60).isActive = true
        codeView?.stackView.addArrangedSubview(cell)
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
