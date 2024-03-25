//
//  ExtractDetailsViewTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import CoraDesafio

final class ExtractDetailsViewTests: XCTestCase {
    
    private var serviceSpy: CoraServiceSpy!
    
    override func setUpWithError() throws {
        serviceSpy = CoraServiceSpy()
    }
    
    func test_Extract_Details() {
        let controller = UIHostingController(
            rootView: ExtractDetailsView().environmentObject(ExtractDetailsViewModel(service: serviceSpy, extractId: "123"))
        )
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_Extract_Details_View_Rendering() throws {
        let view = ExtractDetailsView().environmentObject(ExtractDetailsViewModel(service: serviceSpy, extractId: "123"))
        
        let hostingController = UIHostingController(rootView: view)
        
        XCTAssertNotNil(hostingController.view)
    }
    
}
