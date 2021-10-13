import SwiftUI

struct TransactionListView: View {
    @ObservedObject private var viewModel: TransactionListViewModel
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: .init(state: .initial))
    }
}
