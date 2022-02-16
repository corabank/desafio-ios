import XCTest
@testable import DesafioCora

final class LoginCordinatorSpy: LoginCoordinating {
    var viewController: UIViewController? = nil
    
    var executeCallsCount: Int = 0
    var executeInvocations: [LoginCoordinatorFlow] = []
    
    func execute(_ flow: LoginCoordinatorFlow) {
        executeCallsCount += 1
        executeInvocations.append(flow)
    }
}

final class LoginViewControllerSpy: LoginDisplay {
    var errorMessageCallsCount: Int = 0
    var errorMessageInvocations: [String] = []
    
    func errorMessage(_ message: String) {
        errorMessageCallsCount += 1
        errorMessageInvocations.append(message)
    }
    
    var clearMessageCallsCount: Int = 0
    
    func clearMessage() {
        clearMessageCallsCount += 1
    }
    
    var disableTextFieldsCallsCount: Int = 0
    
    func disableTextFields() {
        disableTextFieldsCallsCount += 1
    }
    
    var enableTextFieldsCallsCount: Int = 0
    
    func enableTextFields() {
        enableTextFieldsCallsCount += 1
    }
    
    var startButtonLoadingCallsCount: Int = 0
    
    func startButtonLoading() {
        startButtonLoadingCallsCount += 1
    }
    
    var stopButtonLoadingCallsCount: Int = 0
    
    func stopButtonLoading() {
        stopButtonLoadingCallsCount += 1
    }
}

final class LoginPresenterTests: XCTestCase {
    
    let coordinatorSpy: LoginCordinatorSpy = LoginCordinatorSpy()
    let viewControllerSpy: LoginViewControllerSpy = LoginViewControllerSpy()
    
    lazy var sut: LoginPresenting = {
        let presenter = LoginPresenter(coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testDidLoginWithMessageShouldInvokeCorrectFunctions() {
        // Given
        let loginMessage = "some message"
        
        // When
        sut.didLoginWith(loginMessage)
        
        // Then
        XCTAssertEqual(viewControllerSpy.enableTextFieldsCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.stopButtonLoadingCallsCount, 1)
        XCTAssertEqual(coordinatorSpy.executeCallsCount, 1)
        XCTAssertEqual(coordinatorSpy.executeInvocations.first, LoginCoordinatorFlow.home(loginMessage))
    }
    
    func testPrepareForLoadingShouldInvokeCorrectFunctions() {
        // When
        sut.prepareForLoading()
        
        // Then
        XCTAssertEqual(viewControllerSpy.disableTextFieldsCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.startButtonLoadingCallsCount, 1)
    }
    
    func testSomethingWrongDidHappenShouldInvokeCorrectFunctions() {
        // Given
        let errorMessage = "something wrong message"
        
        // When
        sut.somenthingWrongDidHappen(errorMessage)
        
        // Then
        XCTAssertEqual(viewControllerSpy.enableTextFieldsCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.stopButtonLoadingCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.errorMessageCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.errorMessageInvocations.first, errorMessage)
    }
}
