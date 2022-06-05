//
//  ExtractInteractorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import Foundation
@testable import DesafioiOS

typealias ExtractInteractorDummy = ExtractInteractorSpy

final class ExtractInteractorSpy: ExtractInteracting {
    
    private(set) var fetchCalled = false
    func fetch() {
        fetchCalled = true
    }
    
    private(set) var numberOfSectionCalled = false
    func numberOfSection() -> Int {
        numberOfSectionCalled = true
        return 3
    }
    
    private(set) var numberOfRowsCalled = false
    func numberOfRows(section: Int) -> Int {
        numberOfRowsCalled = true
        return 4
    }
    
    private(set) var getCellModelCalled = false
    func getCellModel(index: IndexPath) -> DetailTransactionCell.Model {
        getCellModelCalled = true
        return .init(image: Asset.barCode.image, value: "R$ 40,00", name: "Allana Castenharo", type: .entry, time: "23:00", description: "Cacau Show", isLast: false, isFirst: false)
    }
    
    private(set) var getHeaderTransactionCalled = false
    func getHeaderTransaction(section: Int) -> HeaderTransactionView.Model {
        getHeaderTransactionCalled = true
        return .init(day: "Segunda-feira 03 maio", balance: "R$ 3.000,00")
    }
    
    private(set) var filterTransactionCalled = false
    func filterTransaction(type: FilterType) {
        filterTransactionCalled = true
    }
    
    private(set) var didTapTransactionCalled = false
    func didTapTransaction() {
        didTapTransactionCalled = true
    }
}
