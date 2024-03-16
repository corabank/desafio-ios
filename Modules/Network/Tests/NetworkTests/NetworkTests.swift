import XCTest
@testable import Core
@testable import Network

final class NetworkTests: XCTestCase {
    var router: Router!
    var urlSession: URLSession!
    var service: NetworkServiceProtocol!
    var mockCat: CatModel!
    var mockData: Data!
    
    override func setUp() {
        router = MockRoute.catSearch
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        service = DefaultNetworkService(urlSession: urlSession)
        
        mockCat = CatModel(id: "d0q", url: "https://cdn2.thecatapi.com/images/d0q.jpg")
        mockData = try! JSONEncoder().encode(mockCat)
    }
    
    override func tearDown() {
        router = nil
        urlSession = nil
        service = nil
        mockCat = nil
        mockData = nil
        
        super.tearDown()
    }
    
    func testCatSearchSuccess() throws {
        let response = HTTPURLResponse(
            url: try! router.asURLRequest().url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: router.headers
        )!
                
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "cat search")
        
        do {
            try service.request(CatModel.self, router: MockRoute.catSearch) { result in
                switch result {
                case .success(let success):
                    XCTAssertEqual(success.url, self.mockCat.url)
                    expectation.fulfill()
                case .failure(let failure):
                    XCTAssertThrowsError(failure)
                }
            }
        } catch {
            XCTAssertThrowsError(error)
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testCatSearchError() throws {
        let response = HTTPURLResponse(
            url: try! router.asURLRequest().url!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: router.headers
        )!
                
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        
        let expectation = XCTestExpectation(description: "cat search")
        
        do {
            try service.request(CatModel.self, router: MockRoute.catSearch) { result in
                switch result {
                case .success(_):
                    XCTFail("It should not be success")
                    expectation.fulfill()
                case .failure(let failure):
                    XCTAssertEqual(NetworkError.requestFailed(statusCode: 400).localizedDescription, failure.localizedDescription)
                    expectation.fulfill()
                }
            }
        } catch {
            XCTAssertThrowsError(error)
        }
        
        wait(for: [expectation], timeout: 5)

    }
}
