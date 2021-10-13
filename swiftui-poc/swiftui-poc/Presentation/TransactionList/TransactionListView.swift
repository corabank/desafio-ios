import SwiftUI

struct TransactionListView: View {
    @ObservedObject private var viewModel: TransactionListViewModel
    
    private let headerColor = UIColor(red: 0.11, green: 0.18, blue: 0.25, alpha: 1)
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Pedidos")
                            .font(.system(size: 24, weight: .bold, design: .default))
                        Text("320 pedidos, totalizando R$ 115.345,45")
                            .font(.system(size: 12, weight: .light, design: .default))
                    }
                    .padding(.all)
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: headerColor))
                    .foregroundColor(.white)
                    
                    List(viewModel.transactions) { transaction in
                        TransactionRowView(transaction: transaction)
                            .padding(.all)
                            .listRowSeparator(.hidden)
                    }
                }
                
                if viewModel.state == .loading {
                    LoadableView()
                }
            }
        }.onAppear {
            viewModel.fetchTransactions()
        }
    }
}

//struct TransactionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListView(viewModel: .init(state: .initial))
//    }
//}
