//
//  OrdersViewModel.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import Foundation

enum OrdersViewModelState {
    case none
    case loading
    case failure
    case success(orders: [Order])
}

protocol OrdersViewModelProtocol {
    var onUpdated: ((OrdersViewModelState) -> Void)? { get set }
    func fetchOrders()
}

class OrdersViewModel: OrdersViewModelProtocol {
    var onUpdated: ((OrdersViewModelState) -> Void)? {
        didSet {
            onUpdated?(state)
        }
    }

    var state = OrdersViewModelState.none {
        didSet {
            DispatchQueue.main.async {
                self.onUpdated?(self.state)
            }
        }
    }

    private var useCase: OrdersUseCaseProtocol
    init(useCase: OrdersUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.presenter = self
    }

    func fetchOrders() {
        useCase.execute()
    }
}

extension OrdersViewModel: OrdersPresenter {
    func loading() {
        state = .loading
    }
    
    func success(orders: [Order]) {
        state = .success(orders: orders)
    }
    
    func failure() {
        state = .failure
    }
}
