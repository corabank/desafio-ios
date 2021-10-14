import XCTest
@testable import swiftui_poc

class BuyerSceneModelTests: XCTestCase {
    
    private let sut = BuyerSceneModel(name: "Caju Cacau",
                                      email: "cajucacau@labs.moip.com.br")
    
    func testMappingFromModel() {
        // given
        let buyer = BuyerModel(name: "Caju Cacau",
                               email: "cajucacau@labs.moip.com.br")
        
        // when
        let result = BuyerSceneModel(mapping: buyer)
        
        // then
        XCTAssertEqual(result, sut)
    }
}
