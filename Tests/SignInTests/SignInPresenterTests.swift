@testable import Cora
import XCTest

private final class SignInCoordinatorSpy: SignInCoordinating {
    private(set) var callCoordinateToPasswordSceneCount = 0
    
    func coordinateToPasswordScene() {
        callCoordinateToPasswordSceneCount += 1
    }
}

private final class SignInViewControllerSpy: SignInDisplaying {
    private(set) var callDisplayNextStepButtonCount = 0
    private(set) var callDisplayMaskedField = 0
    
    private(set) var isNextStepButtonEnabled: Bool?
    
    func displayNextStepButton(isEnabled: Bool) {
        callDisplayNextStepButtonCount += 1
        isNextStepButtonEnabled = isEnabled
    }
    
    func displayMaskedField(text: String) {
        callDisplayMaskedField += 1
    }
}

final class SignInPresenterTests: XCTestCase {
    private let coordinatorSpy = SignInCoordinatorSpy()
    private let viewControllerSpy = SignInViewControllerSpy()
    private lazy var sut: SignInPresenter = {
        let presenter = SignInPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresentMaskedField_WhenDoesntHaveEnoughCharacters_ShouldDisableNextStepButton() {
        let input = "1234"
        sut.presentMaskedField(basedOn: input)
        
        XCTAssertEqual(viewControllerSpy.callDisplayMaskedField, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayNextStepButtonCount, 1)
        XCTAssertEqual(viewControllerSpy.isNextStepButtonEnabled, false)
    }
    
    func testPresentMaskedField_WhenHasEnoughCharacters_ShouldEnableNextStepButton() {
        let input = "01234567890"
        sut.presentMaskedField(basedOn: input)
        
        XCTAssertEqual(viewControllerSpy.callDisplayMaskedField, 1)
        XCTAssertEqual(viewControllerSpy.callDisplayNextStepButtonCount, 1)
        XCTAssertEqual(viewControllerSpy.isNextStepButtonEnabled, true)
    }
    
    func testPresentPasswordScene_ShouldCoordinateToPasswordScene() {
        sut.presentPasswordScene()
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToPasswordSceneCount, 1)
    }
}
