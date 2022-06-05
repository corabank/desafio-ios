//
//  ExtractInteractor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol ExtractInteracting: AnyObject {
    func fetch()
    func numberOfSection() -> Int
    func numberOfRows(section: Int) -> Int
    func getCellModel(index: IndexPath) -> DetailTransactionCell.Model
    func getHeaderTransaction(section: Int) -> HeaderTransactionView.Model
    func filterTransaction(type: FilterType)
    func didTapTransaction()
}

final class ExtractInteractor: CoraInteractor<ExtractPresenting> {
    let service: ExtractServicing
    private var model: ExtractModel? {
        didSet {
            filterModel = model
        }
    }
    
    private(set) var filterModel: ExtractModel?
    init(service: ExtractServicing, presenter: ExtractPresenting ) {
        self.service = service
        super.init(presenter: presenter)
    }
    
    func countTransactions(indexPath: IndexPath) -> Int {
        (model?.days[indexPath.section].transactions.count ?? 0) - 1
    }
    
    func getTransactionType(filterType: FilterType) -> [TransactionType] {
        var transactionType: [TransactionType] = []
        switch filterType {
        case .all:
            transactionType = TransactionType.allCases
        case .entry:
            transactionType = [.entry]
        case .output:
            transactionType = [.output]
        case .future:
            transactionType = [.refund]
        }
        
        return transactionType
    }
}

extension ExtractInteractor: ExtractInteracting {
    func numberOfSection() -> Int {
        filterModel?.days.count ?? 0
    }
    
    func numberOfRows(section: Int) -> Int {
        filterModel?.days[section].transactions.count ?? 0
    }
    
    func getCellModel(index: IndexPath) -> DetailTransactionCell.Model {
        let transaction = filterModel?.days[index.section].transactions[index.row]
        let icon = UIImage(named: transaction?.icon ?? String())
        return .init(image: icon,
                     value: transaction?.value,
                     name: transaction?.name,
                     type: transaction?.type,
                     time: transaction?.time,
                     description: transaction?.description,
                     isLast: index.row == countTransactions(indexPath: index),
                     isFirst: index.row == 0)
    }
    
    func didTapTransaction() {
        presenter.presentReceipt()
    }
    
    func getHeaderTransaction(section: Int) -> HeaderTransactionView.Model {
        let days = filterModel?.days[section]
        return .init(day: days?.day, balance: days?.balance)
    }
    
    func fetch() {
        service.fetch { result in
            switch result {
            case .success(let model):
                self.model = model
                presenter.presentExtract()
            case .failure:
                presenter.presentError()
            }
        }
    }
    
    func filterTransaction(type: FilterType) {
        guard let model = model else { return }
        
        let transactionType = getTransactionType(filterType: type)
        
        let result: [ExtractDay] = model.days.compactMap({ day in
            let transactions = day.transactions.filter({ transactionType.contains($0.type) })
            return transactions.isEmpty ? nil : ExtractDay(day: day.day, balance: day.balance, transactions: transactions)
        })
        
        filterModel = ExtractModel(days: result)
        presenter.presentExtract()
    }
}
