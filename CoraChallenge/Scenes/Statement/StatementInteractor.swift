//
//  StatementInteractor.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

protocol StatementInteractorProtocol {
    func fetchStatementData()
}

class StatementInteractor:  StatementInteractorProtocol {
    
    var repository: StatementRepository
    var presenter: StatementPresenterProtocol
    
    init(repository: StatementRepository, presenter: StatementPresenterProtocol) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func fetchStatementData() {
        guard let response = repository.loadDataFromJason(fileName: StatementRepository.jsonName) else { return }
        presenter.fillModel(model: response)
        self.getSectionHeaderData(model: response)
    }
    
    private func getSectionHeaderData(model: [StatementModel]) {
        var dailyBalance: [String : Double] = [:]
        
        model.enumerated().forEach { (index, data) in
            let date = data.date
            let info = data.info
            
            if let _ = dailyBalance[date ?? ""] {
                dailyBalance[date ?? ""]! += info?[index].value ?? Double()
            } else {
                dailyBalance[date ?? ""] = info?[index].value ?? Double()
            }
        }
        presenter.fillTableViewHeader(dailyBalance: dailyBalance)
    }
}
