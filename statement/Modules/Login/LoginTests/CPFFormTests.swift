import XCTest
@testable import Login

class CPFFormTests: XCTestCase {
    
    private var model: (CPFFormViewModelProtocol & CPFFormViewDelegate)!
    private var view: CPFFormViewMock!
    private var coordinator: CPFFormCoordinatorMock!
    
    func setup() {
        model = CPFFormViewModel()
        view = CPFFormViewMock()
        coordinator = CPFFormCoordinatorMock()
        
        model.set(view: view)
        model.set(coordinator: coordinator)
        view.set(delegate: model)
    }
    
    func test_navigate_to_next_form() {
        setup()
        view.nextWithInput(input: "123")
        XCTAssertTrue(coordinator.loginWasTapped)
    }
    
    func test_navigate_back() {
        setup()
        view?.goBack()
        XCTAssertTrue(coordinator.backWasTapped)
    }
}
