//
//  DesafioCoraTests.swift
//  DesafioCoraTests
//
//  Created by Euclides Medeiros on 09/03/21.
//

import XCTest
import FBSnapshotTestCase
@testable import DesafioCora

class DesafioCoraTests: FBSnapshotTestCase {

    var sut: OrderListController!
    var viewModel = OrderListViewModel()
    
    // MARK: - Override & Initializers
    
//    init(viewModel: OrderListViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
    override func setUp() {
        super.setUp()
//        sut = OrderListController(viewModel: viewModel)
        self.recordMode = true
    }
    
    func testUIOrderList() {
        sut = OrderListController(viewModel: viewModel)
        FBSnapshotVerifyView(sut.view)
    }

}
