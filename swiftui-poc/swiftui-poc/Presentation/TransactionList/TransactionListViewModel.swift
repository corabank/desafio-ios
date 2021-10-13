import SwiftUI
import RxSwift

final class TransactionListViewModel: ObservableObject {
    
    @Published var state: LoadableState
    @Published var transactions: [TransactionRowSceneModel]
    
    private let fetchTransactionsUseCase: FetchTransactionsUseCase

    private let coordinator: TransactionCoordinator

    private let disposeBag = DisposeBag()

    init(state: LoadableState = .initial,
         fetchTransactionsUseCase: FetchTransactionsUseCase,
         coordinator: TransactionCoordinator) {
        self.state = state
        self.fetchTransactionsUseCase = fetchTransactionsUseCase
        self.coordinator = coordinator
        self.transactions = []
    }
    
    func fetchTransactions() {
        self.state = .loading
        
        self.fetchTransactionsUseCase.execute()
            .subscribe(
                onSuccess: { models in
                    self.state = .loaded
                    
                    let transactions = TransactionRowSceneModel.asArray(mapping: models)
                    self.transactions = transactions
                }, onFailure: { error in
                    self.state = .error
                    
                    //TODO: Show Empty State
                }
            ).disposed(by: self.disposeBag)
    }
}
