final class StatementDataSource {
    private lazy var sections = [
        section1,
        section2,
        section3,
        section4,
    ]
    
    private lazy var section1 = StatementSection(date: "Hoje - 6 de Agosto", total: 3446, itens: [
        StatementItem(person: person1, status: "Transferência recebida",
                      paymentType: .transfer, paymentStatus: .sent,
                      value: 30, time: "17:35", state: .income, type: .cpf),
        
        StatementItem(person: person2, status: "Pagamento recebido",
                      paymentType: .payement, paymentStatus: .sent,
                      value: 26, time: "13:17", state: .income,type: .cpf),
        
        StatementItem(person: person3, status: "Transferência estornada",
                      paymentType: .payement, paymentStatus: .reversal,
                      value: 26, time: "13:17", state: .outcome,type: .cpf),
        
        StatementItem(person: person4, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .sent,
                      value: 26, time: "9:22", state: .outcome, type: .cnpj),
    ])

    private lazy var section2 = StatementSection(date: "Segunda-feira - 2  de Agosto", total: 3110.08, itens: [
        StatementItem(person: person5, status: "Depósito via boleto",
                      paymentType: .ticket, paymentStatus: .sent,
                      value: 30, time: "9:22", state: .income,type: .cpf),
        
        StatementItem(person: person6, status: "Transferência enviada",
                      paymentType: .transfer, paymentStatus: .sent,
                      value: 26, time: "9:22", state: .outcome, type: .cpf),
        
    ])
    
    private lazy var section3 = StatementSection(date: "Sexta-feira - 30 de Julho", total: 3050.3, itens: [
        StatementItem(person: person7, status: "Pagamento estornado",
                      paymentType: .payement, paymentStatus: .reversal,
                      value: 26, time: "9:22", state: .outcome, type: .cpf),
        
        StatementItem(person: person8, status: "Transferência recebida",
                      paymentType: .transfer, paymentStatus: .sent,
                      value: 30, time: "9:22", state: .income,type: .cpf),
        
        StatementItem(person: person9, status: "Transferência enviada",
                      paymentType: .payement, paymentStatus: .sent,
                      value: 26, time: "9:22", state: .outcome,type: .cpf),
    ])
    
    private lazy var section4 = StatementSection(date: "Ontem - 5 de Agosto", total: 3124.34, itens: [
        StatementItem(person: person10, status: "Boleto pago",
                      paymentType: .ticket, paymentStatus: .sent,
                      value: 26, time: "9:22", state: .outcome,type: .cpf),
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
    func getStatements() -> [StatementSection] {
        return sections
    }
    
    func getUser() -> Person {
        return owner
    }
}
