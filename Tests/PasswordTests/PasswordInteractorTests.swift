@testable import Cora
import XCTest

private final class PasswordPresenterSpy: PasswordPresenting {
    private(set) var callPresentBankStatementSceneCount = 0
    private(set) var callPresentNextStepButtonCount = 0
    private(set) var callPresentPasswordCount = 0
    
    private(set) var isNextStepButtonEnabled: Bool?
    private(set) var isPasswordVisible: Bool?
    
    func presentBankStatementScene() {
        callPresentBankStatementSceneCount += 1
    }
    
    func presentNextStepButton(isEnabled: Bool) {
        callPresentNextStepButtonCount += 1
        isNextStepButtonEnabled = isEnabled
    }
    
    func presentPassword(isVisible: Bool) {
        callPresentPasswordCount += 1
        isPasswordVisible = isVisible
    }
}

final class PasswordInteractorTests: XCTestCase {
    private let presenterSpy = PasswordPresenterSpy()
    private lazy var sut = PasswordInteractor(presenter: presenterSpy)
    
    func testDidChangeText_WhenDoesntHaveEnoughCharacters_ShouldDisableNextStepButton() {
        let input = ""
        sut.didChangeText(to: input)
        
        XCTAssertEqual(presenterSpy.callPresentNextStepButtonCount, 1)
        XCTAssertEqual(presenterSpy.isNextStepButtonEnabled, false)
    }
    
    func testDidChangeText_WhenHasEnoughCharacters_ShouldEnableNextStepButton() {
        let input = "a"
        sut.didChangeText(to: input)
        
        XCTAssertEqual(presenterSpy.callPresentNextStepButtonCount, 1)
        XCTAssertEqual(presenterSpy.isNextStepButtonEnabled, true)
    }
    
    func testTooglePasswordVisibility_ShouldTurnPasswordVisible() {
        sut.tooglePasswordVisibility()
        
        XCTAssertEqual(presenterSpy.callPresentPasswordCount, 1)
        XCTAssertEqual(presenterSpy.isPasswordVisible, true)
    }
    
    func testPerformNextStep_ShouldCallPresentBankStatementScene() {
        sut.performNextStep()
        
        XCTAssertEqual(presenterSpy.callPresentBankStatementSceneCount, 1)
    }
}
