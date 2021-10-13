import XCTest
@testable import swiftui_poc

class UseCaseTests: XCTestCase {
    
    func testUnwrappedParams() {
        // given
        let expected = MockParamsUseCase.Params(firstParam: "1",
                                                secondParam: "2")
        let useCase = MockParamsUseCase()
        
        // when
        let result = useCase.unwrappParams(expected)
        
        // then
        XCTAssertEqual(result.firstParam, expected.firstParam)
        XCTAssertEqual(result.secondParam, expected.secondParam)
    }
    
    // TODO: Create unit test to fatalError
    // https://stackoverflow.com/questions/60972215/how-to-catch-a-fatalerror-caused-by-during-a-uitest
    func testNoParamsToUnwrap() {
        XCTAssertTrue(true)
    }
}
