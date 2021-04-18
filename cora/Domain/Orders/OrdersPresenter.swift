//
//  OrdersPresenter.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol OrdersPresenter: class {
    func loading()
    func success(orders: [Order])
    func failure()
}
