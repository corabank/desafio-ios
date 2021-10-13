import XCTest
@testable import swiftui_poc

class BuyerModelTests: XCTestCase {
    
    private let sut = BuyerModel(name: "Caju Cacau",
                                   email: "cajucacau@labs.moip.com.br")
    
    func testMappingFromEntity() {
        // given
        let buyer = BuyerEntity(name: "Caju Cacau",
                                email: "cajucacau@labs.moip.com.br")
        
        // when
        let result = BuyerModel(mapping: buyer)
        
        // then
        XCTAssertEqual(result.name, sut.name)
        XCTAssertEqual(result.email, sut.email)
    }
}
