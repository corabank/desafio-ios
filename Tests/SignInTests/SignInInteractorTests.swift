@testable import Cora
import XCTest

private final class SignInPresenterSpy: SignInPresenting {
    private(set) var callPresentMaskedFieldCount = 0
    private(set) var callPresentPasswordSceneCount = 0
    
    private(set) var calledUserInput: String?

    func presentMaskedField(basedOn userInput: String) {
        callPresentMaskedFieldCount += 1
        calledUserInput = userInput
    }
    
    func presentPasswordScene() {
        callPresentPasswordSceneCount += 1
    }
}

final class SignInInteractorTests: XCTestCase {
    private let presenterSpy = SignInPresenterSpy()
    private lazy var sut = SignInInteractor(presenter: presenterSpy)
    
    func testDidChangeText_ShouldCallPresentMaskedFieldWithUserInput() {
        let input = "12345"
        sut.didChangeText(to: input)
        
        XCTAssertEqual(presenterSpy.callPresentMaskedFieldCount, 1)
        XCTAssertEqual(presenterSpy.calledUserInput, input)
    }
    
    func testPerformNextStep_ShouldCallPresentPasswordScene() {
        sut.performNextStep()
        
        XCTAssertEqual(presenterSpy.callPresentPasswordSceneCount, 1)
    }
}
