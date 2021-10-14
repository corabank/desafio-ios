import SwiftUI

struct TransactionListView: View {
    @ObservedObject private var viewModel: TransactionListViewModel
    @State private var selectedTransaction: TransactionSceneModel? = nil
    
    private let headerColor = UIColor(red: 0.11, green: 0.18, blue: 0.25, alpha: 1)
    
    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    Section {
                        ForEach(viewModel.transactions) { transaction in
                            TransactionRowView(transaction: transaction)
                                .padding(.all)
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    self.selectedTransaction = transaction
                                }
                        }
                    } header: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Pedidos")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .textCase(nil)
                            Text("\(viewModel.summary.total) pedidos, totalizando \(viewModel.summary.sum)")
                                .font(.system(size: 12, weight: .light, design: .default))
                                .textCase(nil)
                        }
                        .padding()
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(uiColor: headerColor))
                        .foregroundColor(.white)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .frame(maxWidth: .infinity)
                .listStyle(GroupedListStyle())
                
                if viewModel.state == .loading {
                    LoadableView()
                }
            }
        }
        .sheet(item: $selectedTransaction, onDismiss: nil, content: { transaction in
            TransactionDetailView(transaction: transaction)
        })
        .onAppear { viewModel.fetchTransactions() }
        .navigationBarHidden(true)
    }
}

//struct TransactionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionListView(viewModel: .init())
//    }
//}
