final class StatementDataSource {
    
    private func dayCreate(_ date: String) -> Date? {
        let parseStrategy = Date.ParseStrategy(
            format: "\(day: .twoDigits)-\(month: .twoDigits)-\(year: .defaultDigits)",
            locale: Locale(identifier: "es"),
            timeZone: .current
        )
        
        return try? Date(date, strategy: parseStrategy)
    }
    
    private lazy var sections = [
        day1,
        day2,
        day3,
        day4,
    ]
    
    private lazy var day1 = StatementDay(date: dayCreate("06-08-2022")!, itens: [
        StatementItem(person: person1, status: "Transferência recebida",
                      paymentType: .pay, paymentStatus: .income,
                      value: 730, time: "17:35", type: .cpf),
        
        StatementItem(person: person2, status: "Pagamento recebido",
                      paymentType: .pay, paymentStatus: .income,
                      value: 26, time: "13:17", type: .cpf),
        
        StatementItem(person: person3, status: "Transferência estornada",
                      paymentType: .reversal, paymentStatus: .reverse,
                      value: 26, time: "13:17", type: .cpf),
        
        StatementItem(person: person4, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .outcome,
                      value: 100, time: "9:22", type: .cnpj),
    ])
    
    private lazy var day2 = StatementDay(date: dayCreate("02-08-2022")!, itens: [
        StatementItem(person: person5, status: "Depósito via boleto",
                      paymentType: .ticket, paymentStatus: .income,
                      value: 450, time: "9:22", type: .cpf),
        
        StatementItem(person: person6, status: "Transferência enviada",
                      paymentType: .pay, paymentStatus: .outcome,
                      value: 50, time: "9:22", type: .cpf),
    ])
    
    private lazy var day3 = StatementDay(date: dayCreate("20-08-2022")!, itens: [
        StatementItem(person: person7, status: "Pagamento estornado",
                      paymentType: .reversal, paymentStatus: .reverse,
                      value: 26, time: "9:22", type: .cpf),
        
        StatementItem(person: person8, status: "Transferência recebida",
                      paymentType: .pay, paymentStatus: .income,
                      value: 130, time: "9:22", type: .cpf),
        
        StatementItem(person: person9, status: "Transferência enviada",
                      paymentType: .pay, paymentStatus: .outcome,
                      value: 26, time: "9:22", type: .cpf),
    ])
    
    private lazy var day4 = StatementDay(date: dayCreate("05-08-2022")!, itens: [
        StatementItem(person: person10, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .outcome,
                      value: 210, time: "9:22", type: .cpf),
    ])
    
    private lazy var person1 = Person(name: "Lucas Costa", cpf: "457.131.063-26",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person2 = Person(name: "João da Silva", cpf: "511.120.443-52",
                                      bank: "Banco Bradesco", agency: "2435", account: "43556-3")
    
    private lazy var person3 = Person(name: "Daniela Andrade", cpf: "427.110.133-22",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person4 = Person(name: "Aut Arquitetura", cpf: "402.299.322-50",
                                      bank: "Banco do Brasil", agency: "2435", account: "43556-3")
    
    private lazy var person5 = Person(name: "Leonardo Silva ME", cpf: "500.120.223-86",
                                      bank: "Banco Itaú", agency: "2435", account: "43556-3")
    
    private lazy var person6 = Person(name: "Stella Moraes", cpf: "427.160.163-56",
                                      bank: "Banco Bradesco", agency: "2435", account: "43556-3")
    
    private lazy var person7 = Person(name: "Darlene Edwards", cpf: "390.190.513-16",
                                      bank: "Banco Nu-SA", agency: "2435", account: "43556-3")
    
    private lazy var person8 = Person(name: "Guy Edwards", cpf: "420.200.522-99",
                                      bank: "Banco Cora", agency: "2435", account: "43556-3")
    
    private lazy var person9 = Person(name: "Theresa Simmmons", cpf: "437.133.673-96",
                                      bank: "Banco Santander", agency: "2435", account: "43556-3")
    
    private lazy var person10 = Person(name: "Judith Cooper", cpf: "417.129.231-23",
                                      bank: "Banco Cora", agency: "2435", account: "43556-3")
    
    private lazy var owner = Person(name: "Lucas Vallim da Costa", cpf: "407.130.563-56",
                                    bank: "Banco Cora", agency: "6193", account: "12225-3")
}

extension StatementDataSource: StatementDataSourceProtocol {
    func getStatements() -> [StatementDay] {
        return sections
    }
    
    func getUser() -> Person {
        return owner
    }
}
