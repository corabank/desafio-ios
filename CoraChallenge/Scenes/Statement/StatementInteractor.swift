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
        let response = repository.loadDataFromJason(fileName: StatementRepository.jsonName)
        
        print(response)
    }
}
