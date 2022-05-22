import Foundation

protocol BankStatementInteracting: AnyObject {
    func dayInfo(for section: Int) -> StatementHeaderContent
    func didSelectTransaction(section: Int, at index: Int)
    func numberOfDays() -> Int
    func numberOfTransactions(at section: Int) -> Int
    func transactionInfo(section: Int, at index: Int) -> StatementItemContent
    func selectSegment(at index: Int)
}

final class BankStatementInteractor {    
    private let service: BankStatementServicing
    private let presenter: BankStatementPresenting
    
    private let dailyTransactions: [DailyTransactions]
    private(set) var segmentedDailyTransactions: [DailyTransactions]

    init(service: BankStatementServicing, presenter: BankStatementPresenting) {
        self.service = service
        self.presenter = presenter
        dailyTransactions = service.getBankStatementData()
        segmentedDailyTransactions = dailyTransactions
    }
}

extension BankStatementInteractor: BankStatementInteracting {
    func selectSegment(at index: Int) {
        guard let segment = BankStatementSegment(rawValue: index) else { return }
        switch segment {
        case .all:
            segmentedDailyTransactions = dailyTransactions
        case .input:
            segmentDailyTransactions(by: [.input])
        case .output:
            segmentDailyTransactions(by: [.output, .reversed])
        case .future:
            segmentDailyTransactions(by: [.scheduled])
        }
        
        presenter.presentTransactions()
    }
    
    func didSelectTransaction(section: Int, at index: Int) {
        let selectedId = segmentedDailyTransactions[section].transactions[index].id
        presenter.presentTransactionDetail(id: selectedId)
    }
    
    func numberOfDays() -> Int {
        segmentedDailyTransactions.count
    }
    
    func numberOfTransactions(at section: Int) -> Int {
        segmentedDailyTransactions[section].transactions.count
    }
    
    func dayInfo(for section: Int) -> StatementHeaderContent {
        StatementHeaderContent(dayInfo: segmentedDailyTransactions[section].dayInfo)
    }
    
    func transactionInfo(section: Int, at index: Int) -> StatementItemContent {
        StatementItemContent(transaction: segmentedDailyTransactions[section].transactions[index])
    }
}

private extension BankStatementInteractor {
    func segmentDailyTransactions(by types: [TransactionType]) {
        segmentedDailyTransactions.removeAll()
        dailyTransactions.forEach { dailyTransaction in
            let filteredTransactions = dailyTransaction.transactions.filter { types.contains($0.type) }
            if !filteredTransactions.isEmpty {
                segmentedDailyTransactions.append(DailyTransactions(dayInfo: dailyTransaction.dayInfo,
                                                                    transactions: filteredTransactions))
            }
        }
    }
}
