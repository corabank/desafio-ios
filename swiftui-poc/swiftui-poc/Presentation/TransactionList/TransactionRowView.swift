import SwiftUI

struct TransactionRowView: View {
    private let transaction: TransactionSceneModel
    
    init(transaction: TransactionSceneModel) {
        self.transaction = transaction
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(transaction.value)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Spacer()
                Text(transaction.status.localizedDescription)
                    .font(.system(size: 16))
                    .foregroundColor(Color(uiColor: transaction.status.uiColor))
            }
            .frame(maxWidth: .infinity)
            HStack {
                Text(transaction.buyer.email)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Spacer()
                Text(transaction.date)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction:
                            TransactionSceneModel(id: "f97f1882-01bb-4ec4-9ad6-fe4c29a0820d",
                                                  value: "R$ 110,00",
                                                  buyer: BuyerSceneModel(name: "Caju Cacau", email: "cajucacau@labs.moip.com.br"),
                                                  paymentMethod: .creditCard,
                                                  date: "13/10/21",
                                                  status: .paid,
                                                  taxes: "R$ 2,33"))
    }
}
