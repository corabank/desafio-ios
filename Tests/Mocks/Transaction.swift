@testable import Cora

extension Transaction {
    static let mock = Transaction(id: 1,
                                  name: "Name 1",
                                  hour: "01:00",
                                  value: 1.00,
                                  type: .reversed,
                                  method: .transfer)
    
    static let mock2 = Transaction(id: 2,
                                   name: "Name 2",
                                   hour: "02:00",
                                   value: 2.00,
                                   type: .output,
                                   method: .payment)
    
    static let mock3 = Transaction(id: 3,
                                   name: "Name 3",
                                   hour: "03:00",
                                   value: 3.00,
                                   type: .input,
                                   method: .billet)
    
    static let mock4 = Transaction(id: 4,
                                   name: "Name 4",
                                   hour: "04:00",
                                   value: 4.00,
                                   type: .scheduled,
                                   method: .transfer)
}
