//
//  InvoiceServiceTests.swift
//  Desafio CoraTests
//
//  Created by João Pedro DTI on 20/05/22.
//

@testable import Desafio_Cora
import XCTest

// swiftlint:disable line_length
private final class InvoiceServiceMock: InvoiceServiceDelegate {
    var fetchOfferExpectedResult: Result<InvoiceModel, Error>?
    let chart = [Chart(month: "jan", value: 1.0),
                Chart(month: "fev", value: 2.0)]
    let info = Infos(value: 100.0, totalValue: 30_000.0, expirationDate: "05/01/2022")
    let transactions = [Transaction(date: "05/01/2022", transactionDescription: "desc", value: 3.0, transactionType: .payment, observationDescription: nil, observationValue: nil, observationCurrency: nil)]
    let cards = [Card(cardName: "teste", finalCardNumber: "0000", transactions: [Transaction(date: "05/01/2022", transactionDescription: "desc", value: 3.0, transactionType: .payment, observationDescription: nil, observationValue: nil, observationCurrency: nil)])]

    func loadData() -> InvoiceModel {
        let data = InvoiceModel(invoiceResume: InvoiceResume(chart: chart, infos: info),
                                mainTransactions: transactions,
                                cards: cards)
        return data
    }
}

class InvoiceServiceTests: BaseCoordinatorTests {
    override func setUp() {
        super.setUp()
        networkServices = NetworkCoordinator(navigationController: navigationController)
        networkServices.configureUnitTests(service: InvoiceServiceMock())
    }

    func test_invoiceServiceTestAPICall() {
        let invoiceCoordinator = InvoiceCoordinator(navigationController: navigationController, networkServices: networkServices)
        invoiceCoordinator.getInvoiceData { result in
            XCTAssertEqual(result.cards.count, 1)
            XCTAssertEqual(result.invoiceResume?.infos.value, 100)
        } onFailure: { _ in
            // pass
        }
    }

    func test_formatTransactions() {
        let invoiceCoordinator = InvoiceCoordinator(navigationController: navigationController, networkServices: networkServices)
        invoiceCoordinator.getInvoiceData { result in
            XCTAssertEqual(result.dataForTable.count, 2)
        } onFailure: { _ in
            // pass
        }
    }
}
