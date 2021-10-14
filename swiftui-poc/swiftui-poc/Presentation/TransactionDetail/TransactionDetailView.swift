import SwiftUI

struct TransactionDetailView: View {
    private let transaction: TransactionSceneModel
    
    init(transaction: TransactionSceneModel) {
        self.transaction = transaction
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            VStack(spacing: 4) {
                Text(transaction.value)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Text(transaction.paymentMethod.localizedDescription)
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(.gray)
            }
            VStack(spacing: 4) {
                Text("Comprador")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(.gray)
                Text(transaction.buyer.name)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.black)
            }
            VStack(spacing: 4) {
                Text("Email")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(.gray)
                Text(transaction.buyer.email)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.black)
            }
            VStack(spacing: 4) {
                Text("Criado em")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(.gray)
                Text(transaction.date)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(.black)
            }
            VStack(spacing: 4) {
                Text("Status")
                    .font(.system(size: 16, weight: .light, design: .default))
                    .foregroundColor(.gray)
                Text(transaction.status.localizedDescription)
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .foregroundColor(Color(uiColor: transaction.status.uiColor))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailView(transaction:
                                TransactionSceneModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                                      value: "R$ 110,00",
                                                      buyer: BuyerSceneModel(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br"),
                                                      paymentMethod: .creditCard,
                                                      date: "13/10/21",
                                                      status: .paid,
                                                      taxes: "R$ 2,33"))
    }
}
