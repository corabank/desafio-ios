//
//  OrderDetailViewModel.swift
//  cora
//
//  Created by Lucas Silveira on 19/04/21.
//

import Foundation

class OrderDetailViewModel {
    var order: Order // setar para private após ter view model view
    
    init(order: Order) {
        self.order = order
    }
}

// criar um order detail view model view para mandar os valores corretos para o controller
