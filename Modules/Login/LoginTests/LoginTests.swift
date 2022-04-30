import XCTest
@testable import Login

class LoginTests: XCTestCase {
    
    private var model: (LoginViewModelProtocol & LoginViewDelegate)!
    private var view: LoginViewMock!
    private var coordinator: LoginCoordinatorMock!
    
    func setup() {
        model = LoginViewModel()
        view = LoginViewMock()
        coordinator = LoginCoordinatorMock()
        
        model.set(view: view)
        model.set(coordinator: coordinator)
        view.set(delegate: model)
    }
    
    func test_navigate_to_form() {
        setup()
        model.login()
        XCTAssertTrue(coordinator.goToLogin)
    }
    
    func test_navigate_to_register() {
        setup()
        model.register()
        XCTAssertTrue(coordinator.goToRegister)
    }
    
    func test_chenge_button_state() {
        setup()
        
    }
}
