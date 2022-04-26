//
//  StatementInteractor.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/24/22.
//

import Foundation

protocol StatementInteractorProtocol {
    var model: [StatementModelData] { get set }
    var dailyBalanceArray: [String] { get set }
    func fetchStatementData()
}

class StatementInteractor:  StatementInteractorProtocol {
    
    var repository: StatementRepository
    var presenter: StatementPresenterProtocol
    var model: [StatementModelData] = []
    var dailyBalanceArray: [String] = []
    
    init(repository: StatementRepository, presenter: StatementPresenterProtocol) {
        self.repository = repository
        self.presenter = presenter
    }
    
    func fetchStatementData() {
        guard let response = repository.loadDataFromJason(fileName: StatementRepository.jsonName) else { return }
        
        self.model = response

        self.getSectionHeaderData(model: response)
    }
    
    func getSectionHeaderData(model: [StatementModelData]) {
        var dailyBalance: [String : Double] = [:]
        
        model.forEach { item in
            let date = item.date ?? String()//?.stringToDate(withFormat: "dd/MM/yyyy") ?? String()
            if let _ = dailyBalance[date] {
                dailyBalance[date]! += item.value ?? Double()
            } else {
                dailyBalance[date] = item.value ?? Double()
            }
        }
        
        dailyBalanceArray = dailyBalance.map{"\($0)|\($1)"}
    }
}
