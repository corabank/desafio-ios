//
//  ReceiptInteractorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ReceiptInteractorDummy = ReceiptInteractorSpy

final class ReceiptInteractorSpy: ReceiptInteracting {
    var model: ReceiptModel? = .init(icon: Asset.timeClock.name,
                                     status: "Aguardando agendamento",
                                     value: "R$ 30,00",
                                     date: "22/07/2022",
                                     addresseeInfo: .init(title: "De",
                                                          name: "Allana Castenharo",
                                                          cpf: "210.099.221-88",
                                                          bank: "Cora Bank",
                                                          account: "Agência 6193 - Conta 12225-3"),
                                     beneficiaryInfo: .init(title: "Para",
                                                            name: "Sueli Castenharo",
                                                            cpf: "450.099.251-88",
                                                            bank: "Cora Bank",
                                                            account: "Agência 6163 - Conta 12325-3"),
                                     description: "Boleto")
    
    private(set) var fetchCalled = false
    func fetch() {
        fetchCalled = true
    }
}
