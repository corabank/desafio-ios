@testable import Cora
import XCTest

private final class PasswordCoordinatorSpy: PasswordCoordinating {
    private(set) var callCoordinateToBankStatementSceneCount = 0
    
    func coordinateToBankStatement() {
        callCoordinateToBankStatementSceneCount += 1
    }
}

private final class PasswordViewControllerSpy: PasswordDisplaying {
    private(set) var callDisplayNextStepButtonCount = 0
    private(set) var callDisplayPasswordField = 0
    
    private(set) var isNextStepButtonEnabled: Bool?
    private(set) var isPasswordVisible: Bool?
    private(set) var passwordFieldImage: UIImage?
    
    func displayNextStepButton(isEnabled: Bool) {
        callDisplayNextStepButtonCount += 1
        isNextStepButtonEnabled = isEnabled
    }
    
    func displayPassword(isVisible: Bool, fieldImage: UIImage) {
        callDisplayPasswordField += 1
        isPasswordVisible = isVisible
        passwordFieldImage = fieldImage
    }
}

final class PasswordPresenterTests: XCTestCase {
    private let coordinatorSpy = PasswordCoordinatorSpy()
    private let viewControllerSpy = PasswordViewControllerSpy()
    private lazy var sut: PasswordPresenter = {
        let presenter = PasswordPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresentNextStepButton_WhenIsDisabled_ShouldDisableNextStepButton() {
        sut.presentNextStepButton(isEnabled: false)
        
        XCTAssertEqual(viewControllerSpy.callDisplayNextStepButtonCount, 1)
        XCTAssertEqual(viewControllerSpy.isNextStepButtonEnabled, false)
    }
    
    func testPresentNextStepButton_WhenIsEnabled_ShouldEnableNextStepButton() {
        sut.presentNextStepButton(isEnabled: true)
        
        XCTAssertEqual(viewControllerSpy.callDisplayNextStepButtonCount, 1)
        XCTAssertEqual(viewControllerSpy.isNextStepButtonEnabled, true)
    }
    
    func testPresentPassword_WhenIsVisible_ShouldDisplayPasswordWithEyeOpenImage() {
        sut.presentPassword(isVisible: true)
        
        XCTAssertEqual(viewControllerSpy.callDisplayPasswordField, 1)
        XCTAssertEqual(viewControllerSpy.isPasswordVisible, true)
        XCTAssertEqual(viewControllerSpy.passwordFieldImage, Images.icEyeOpen.image)
    }
    
    func testPresentPassword_WhenIsNotVisible_ShouldShowPasswordWithEyeHiddenImage() {
        sut.presentPassword(isVisible: false)
        
        XCTAssertEqual(viewControllerSpy.callDisplayPasswordField, 1)
        XCTAssertEqual(viewControllerSpy.isPasswordVisible, false)
        XCTAssertEqual(viewControllerSpy.passwordFieldImage, Images.icEyeHidden.image)
    }
    
    func testPresentBankStatementScene_ShouldCoordinateToBankStatementScene() {
        sut.presentBankStatementScene()
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToBankStatementSceneCount, 1)
    }
}
