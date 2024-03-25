//
//  ExtractDetailsViewModel.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio
import NetwokKit

final class ExtractDetailsViewModelTests: XCTestCase {
    
    private var serviceSpy: CoraServiceSpy!
    
    override func setUpWithError() throws {
        serviceSpy = CoraServiceSpy()
    }
    
    func testFetchExtractDetails_Success() async throws {
        
        let viewModel = ExtractDetailsViewModel(service: serviceSpy, extractId: "123")
        
        try await viewModel.fetchExtractDetails()
        
        XCTAssertEqual(viewModel.status, .success)
        XCTAssertNotNil(viewModel.extractDetails)
        XCTAssertEqual(1, serviceSpy.fetchExtractDetailsCalled)
        XCTAssertEqual("123", serviceSpy.fetchExtractDetailsValue)
    }
}
