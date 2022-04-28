//
//  StatementPresenter.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

protocol StatementPresenterProtocol {    
    func fillTableViewHeader(dailyBalance: [String : Double])
    func fillModel(model: [StatementModel])
}

class StatementPresenter: StatementPresenterProtocol {
    var viewController: StatementViewControllerProtocol
    
    init(viewController: StatementViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fillTableViewHeader(dailyBalance: [String : Double]) {
        var dailyBalanceArray: [String] = []
        dailyBalanceArray = dailyBalance.map{"\($0)|\($1)"}
        viewController.dailyBalanceArray = dailyBalanceArray
    }
    
    func fillModel(model: [StatementModel]) {
        viewController.model = model
    }
}
