@testable import Cora
import Foundation

extension TransactionDetail {
    static let mock = TransactionDetail(type: .reversed,
                                        method: .transfer,
                                        value: 100,
                                        date: Date(),
                                        sender: TransactionPerson(name: "Sender",
                                                                  cpf: "000.000.000-00",
                                                                  bankName: "Banco Itaú",
                                                                  bankAgency: "0245",
                                                                  bankAccount: "12305-4"),
                                        receiver: TransactionPerson(name: "Receiver",
                                                                    cpf: "111.111.111-11",
                                                                    bankName: "Banco Cora",
                                                                    bankAgency: "0001",
                                                                    bankAccount: "11111-1"))
}
