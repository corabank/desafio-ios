import Foundation

protocol ExtractInteracting: AnyObject {
    func getExtractData()
    func filterData(index: Int)
    func sectionCount() -> Int
    func transactionsCount(section: Int) -> Int
    func sectionTransactionDay(section: Int) -> String
    func sectionTransactionsValue(section: Int) -> String
    func getContentCell(index: IndexPath) -> StatementListCellModel
}

final class ExtractInteractor {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting
    private var statementData = [StatementData]()
    private var filterStatementData = [StatementData]()

    init(service: ExtractServicing, presenter: ExtractPresenting) {
        self.service = service
        self.presenter = presenter
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
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.groupingSeparator = "."
        return "R$ \(numberFormatter.string(from: NSNumber(value: filterStatementData[section].transactionTotalValue)) ?? "Valor indefinido")"
    }
    
    func getContentCell(index: IndexPath) -> StatementListCellModel {
        return StatementListCellModel(transaction: filterStatementData[index.section].transactions[index.row])
    }
}
