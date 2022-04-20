import Foundation

protocol ExtractInteracting: AnyObject {
    func getExtractData()
    func filterData(index: Int)
    func sectionCount() -> Int
    func transactionsCount(section: Int) -> Int
    func sectionTransactionDay(section: Int) -> String
    func sectionTransactionsValue(section: Int) -> String
    func getContentCell(index: IndexPath) -> StatementListCellModel
    func goToExtractDetail(indexPath: IndexPath)
    func signOut()
    func showFilter()
}

final class ExtractInteractor {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting
    private var statementData = [StatementData]()
    private(set) var filterStatementData = [StatementData]()

    init(service: ExtractServicing, presenter: ExtractPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

private extension ExtractInteractor {
    func checkTransaction(indexPath: IndexPath) -> Bool {
        let transactionType = filterStatementData[indexPath.section].transactions[indexPath.row].transactionStatus.transactionType
        switch transactionType {
        case .transfer, .payment:
            return true
        case .ticket:
            return false
        }
    }
}

// MARK: - ExtractInteracting
extension ExtractInteractor: ExtractInteracting {
    func getExtractData() {
        statementData = service.loadData()
    }
    
    func filterData(index: Int) {
        switch index {
        case 1:
            filterStatementData = statementData.compactMap {
                let filteredTransactions = $0.transactions.filter {
                    $0.transactionStatus.transactionEntry == .input
                }
                
                guard !filteredTransactions.isEmpty else { return nil }
                let statement = StatementData(transactionDay: $0.transactionDay,
                                              transactionTotalValue: $0.transactionTotalValue,
                                              transactions: filteredTransactions)
                return statement
            }
        case 2:
            filterStatementData = statementData.compactMap {
                let filteredTransactions = $0.transactions.filter {
                    $0.transactionStatus.transactionEntry == .output && $0.transactionStatus.status != .future
                }
                
                guard !filteredTransactions.isEmpty else { return nil }
                let statement = StatementData(transactionDay: $0.transactionDay,
                                              transactionTotalValue: $0.transactionTotalValue,
                                              transactions: filteredTransactions)
                return statement
            }
        case 3:
            filterStatementData = statementData.compactMap {
                let filteredTransactions = $0.transactions.filter {
                    $0.transactionStatus.status == .future
                }
                
                guard !filteredTransactions.isEmpty else { return nil }
                let statement = StatementData(transactionDay: $0.transactionDay,
                                              transactionTotalValue: $0.transactionTotalValue,
                                              transactions: filteredTransactions)
                return statement
            }
        default:
            filterStatementData = statementData
        }
        presenter.displayStatementList()
    }
    
    func sectionCount() -> Int {
        filterStatementData.count
    }
    
    func transactionsCount(section: Int) -> Int {
        filterStatementData[section].transactions.count
    }
    
    func sectionTransactionDay(section: Int) -> String {
        filterStatementData[section].transactionDay
    }
    
    func sectionTransactionsValue(section: Int) -> String {
        CurrencyString.getCurrency(.money(value: filterStatementData[section].transactionTotalValue))()
    }
    
    func getContentCell(index: IndexPath) -> StatementListCellModel {
        return StatementListCellModel(transaction: filterStatementData[index.section].transactions[index.row])
    }
    
    func goToExtractDetail(indexPath: IndexPath) {
        if checkTransaction(indexPath: indexPath) {
            presenter.presentExtractDetail(transaction: filterStatementData[indexPath.section].transactions[indexPath.row],
                                           transactionDay: filterStatementData[indexPath.section].transactionDay)
        }
    }
    
    func signOut() {
        presenter.didNextStep(action: .signOut)
    }
    
    func showFilter() {
        presenter.didNextStep(action: .filterScene)
    }
}
