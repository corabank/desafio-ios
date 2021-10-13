import SwiftUI

final class TransactionListViewModel: ObservableObject {
    
    @Published var state: LoadableState
    
    init(state: LoadableState = .initial) {
        self.state = state
    }
}
