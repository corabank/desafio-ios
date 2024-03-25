//
//  ExtractListViewModelTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio

final class ExtractListViewModelTests: XCTestCase {
    
    private var serviceSpy: CoraServiceSpy!
    
    override func setUpWithError() throws {
        serviceSpy = CoraServiceSpy()
    }
    
    func testFetchExtractList() async throws {
        let viewModel = ExtractListViewModel(service: serviceSpy)
        
        await viewModel.fetchExtractList()
        
        XCTAssertEqual(viewModel.status, .success)
        XCTAssertNotNil(viewModel.extractList)
        XCTAssertEqual(1, serviceSpy.fetchExtractListCalled)
    }
}
