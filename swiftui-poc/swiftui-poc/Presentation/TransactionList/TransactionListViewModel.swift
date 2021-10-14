import SwiftUI
import RxSwift

final class TransactionListViewModel: ObservableObject {
    
    @Published var state: LoadableState
    @Published var summary: TransactionSummarySceneModel
    @Published var transactions: [TransactionSceneModel]
    
    private let fetchTransactionsUseCase: FetchTransactionsUseCase

    private let coordinator: TransactionCoordinator

    private let disposeBag = DisposeBag()

    init(state: LoadableState = .initial,
         fetchTransactionsUseCase: FetchTransactionsUseCase,
         coordinator: TransactionCoordinator) {
        self.state = state
        self.fetchTransactionsUseCase = fetchTransactionsUseCase
        self.coordinator = coordinator
        self.summary = TransactionSummarySceneModel(total: "", sum: "")
        self.transactions = []
    }
    
    func fetchTransactions() {
        self.state = .loading
        
        self.fetchTransactionsUseCase.execute()
            .subscribe(
                onSuccess: { models in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.state = .loaded

                        let transactions = TransactionSceneModel.asArray(mapping: models)
                        self.transactions = transactions
                        
                        let summary = TransactionSummarySceneModel(mapping: models)
                        self.summary = summary
                    }
                }, onFailure: { error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        self.state = .error
                        
                        //TODO: Show Empty State
                    }
                }
            ).disposed(by: self.disposeBag)
    }
}
