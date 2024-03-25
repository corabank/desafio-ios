//
//  ExtractListView.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoraDesafio

final class ExtractListViewTests: XCTestCase {

    private var serviceSpy: CoraServiceSpy!
    
    override func setUpWithError() throws {
        serviceSpy = CoraServiceSpy()
    }
    
    func test_Extracy_List_Success() {
        let controller = UIHostingController(rootView: ExtractListView(ExtractListViewModel(service: serviceSpy)))
        assertSnapshot(of: controller, as: .image)
    }
    
    func testExtractListView_Rendering() throws {
          let view = ExtractListView(ExtractListViewModel(service: serviceSpy))
          
          let hostingController = UIHostingController(rootView: view)
          
          // Assert
          XCTAssertNotNil(hostingController.view)
      }
}
