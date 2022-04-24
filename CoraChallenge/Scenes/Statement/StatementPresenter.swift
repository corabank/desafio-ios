//
//  StatementPresenter.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

protocol StatementPresenterProtocol {
    func fillTableview()
}

class StatementPresenter: StatementPresenterProtocol {
    var viewController: StatementViewControllerProtocol
    
    init(viewController: StatementViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fillTableview() {
        
    }
}
