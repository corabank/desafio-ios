import XCTest
@testable import Login

class PassFormTests: XCTestCase {
    
    private var model: (PassFormViewModelProtocol & PassFormViewDelegate)!
    private var view: PassFormViewMock!
    private var coordinator: PassFormCoordinatorMock!
    
    func setup() {
        model = PassFormViewModel()
        view = PassFormViewMock()
        coordinator = PassFormCoordinatorMock()
        
        model.set(view: view)
        model.set(coordinator: coordinator)
        view.set(delegate: model)
    }
    
    func test_navigate_to_next_form() {
        setup()
        model.inputPassword("123")
        XCTAssertTrue(coordinator.gotToStatementWasTapped)
    }
    
    func test_navigate_back() {
        setup()
        model.tapBack()
        XCTAssertTrue(coordinator.backWasTapped)
    }
}
