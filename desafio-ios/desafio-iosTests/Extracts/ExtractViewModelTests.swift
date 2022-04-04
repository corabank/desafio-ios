//
//  ExtractViewModelTests.swift
//  desafio-iosTests
//
//  Created by Amaryllis Baldrez on 04/04/22.
//

import Foundation
import XCTest
@testable import desafio_ios

class ExtractViewModelTests:XCTestCase {
    
    private let urlSessionStub = URLSessionProtocolStub()
    private lazy var sut = ExtractViewModel(session: urlSessionStub)
    typealias NetworkResult = Result<Mocks.DecodableFake, Error>
    
    func test_request_givenInvalidJSON_shouldReturnHTTPClientErrorInvalidURL() throws {
            
            // Given
            
            var result: NetworkResult?
            sut.getExtracts { resultado in
                result = resultado
            }
            
            // Then
            
            XCTAssertFalse(urlSessionStub.fetchDataCalled)
            XCTAssertNil(urlSessionStub.fetchDataUrlPassed)
            
            switch result {
            case .failure(let error):
                let unwrappedError = try XCTUnwrap(error as? HTTPClientError)
                XCTAssertEqual(unwrappedError, .invalidJson)
            default:
                XCTFail("Result should be failure with error")
            }
        }
        
        func test_request_givenValidURL_andSessionReturningError_shouldReturnExpectedError() {
            
            // Given
            
            urlSessionStub.completionHandlerToBeReturned = (nil, nil, Mocks.ErrorDummy())
            
            // When
            
            var result: NetworkResult?
            sut.getExtracts { result in
                result = result
            }
            
            // Then
            
            XCTAssertTrue(urlSessionStub.fetchDataCalled)
            XCTAssertNotNil(urlSessionStub.fetchDataUrlPassed)
            
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error as? Mocks.ErrorDummy)
            default:
                XCTFail("Result should be failure with error")
            }
        }
        
        func test_request_givenValidURL_andRequestReturnNilError_andHTTPResponseIsDiferentFrom200_shouldReturnHTTPClientErrorUnexpectedStatusCode() throws {
            
            // Given
            
            urlSessionStub.completionHandlerToBeReturned = (nil, Mocks.invalidJsonResponse, nil)
            
            // When
            
            var result: NetworkResult?
            sut.getExtracts { result in
                result = result
            }
            
            // Then
            
            XCTAssertTrue(urlSessionStub.fetchDataCalled)
            XCTAssertNotNil(urlSessionStub.fetchDataUrlPassed)
            
            switch result {
            case .failure(let error):
                let unwrappedError = try XCTUnwrap(error as? HTTPClientError)
                XCTAssertEqual(unwrappedError, .unexpectedStatusCode)
            default:
                XCTFail("Result should be failure with error")
            }
        }
        
        func test_request_givenValidURL_andRequestReturnNilError_andHTTPResponseIs200_shouldReturnHTTPClientErrorInvalidData() throws {
            
            // Given
            
            urlSessionStub.completionHandlerToBeReturned = (nil, Mocks.validJsonResponse, nil)
            
            // When
            
            var result: NetworkResult?
            sut.getExtracts { result in
                result = result
            }
            
            // Then
            
            XCTAssertTrue(urlSessionStub.fetchDataCalled)
            XCTAssertNotNil(urlSessionStub.fetchDataUrlPassed)
            
            switch result {
            case .failure(let error):
                let unwrappedError = try XCTUnwrap(error as? HTTPClientError)
                XCTAssertEqual(unwrappedError, .invalidData)
            default:
                XCTFail("Result should be failure with error")
            }
        }
    
}

class URLSessionProtocolStub: URLSessionProtocol {
    
    func fetchData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        fetchDataCalled = true
        fetchDataUrlPassed = urlRequest
        completionHandler(completionHandlerToBeReturned?.data, completionHandlerToBeReturned?.response, completionHandlerToBeReturned?.error)
    }
    
    
    private(set) var fetchDataCalled = false
    private(set) var fetchDataUrlPassed: URLRequest?
    var completionHandlerToBeReturned: (data: Data?, response: URLResponse?, error: Error?)?
    
}

class Mocks {
    
    struct DecodableFake: Decodable {
        let name: String
    }
    
    struct ErrorDummy: Error {
        
    }
    
    static var validJsonResponse = HTTPURLResponse(url: .init(fileURLWithPath: "url"), statusCode: 200, httpVersion: nil, headerFields: nil)
    static var invalidJsonResponse = HTTPURLResponse(url: .init(fileURLWithPath: "url"), statusCode: 300, httpVersion: nil, headerFields: nil)
    static var validData: Data? = {
         """
        {
            "day": "Hoje - 6 de Agosto"
        }
        """.data(using: .utf8)
    }()
    static var invalidData: Data? = {
         """
        {
            "dia": "Hoje - 6 de Agosto"
        }
        """.data(using: .utf8)
    }()
}
