import Foundation

protocol ExtractInteracting: AnyObject {
    func getExtractData()
}

final class ExtractInteractor {
    private let service: ExtractServicing
    private let presenter: ExtractPresenting
    private var statementData = [StatementData]()
    
    init(service: ExtractServicing, presenter: ExtractPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - ExtractInteracting
extension ExtractInteractor: ExtractInteracting {
    func getExtractData() {
        statementData = service.loadData()
        presenter.displayStatementList(statementData: statementData)
    }
}
