import XCTest
@testable import Statement

class StatementTests: XCTestCase {
    
    private var model: (StatementViewModelProtocol & StatementViewDelegate)!
    private var view: StatementViewMock!
    private var coordinator: StatementCoordinatorMock!
    private var dataSource: StatementDataSource!
    
    func setup() {
        model = StatementViewModel()
        view = StatementViewMock()
        coordinator = StatementCoordinatorMock()
        dataSource = StatementDataSource()
        
        model.set(view: view)
        model.set(coordinator: coordinator)
        model.set(dataSource: dataSource)
        view.set(delegate: model)
    }
    
    func test_navigate_to_detail() {
        setup()
        let item = dataSource.getStatements().first!.itens.first
        model.selectItem(item: item!)
        XCTAssertTrue(coordinator.detailItem?.uuid == item?.uuid)
    }
    
    func test_navigate_filter() {
        setup()
        XCTAssertTrue(model?.allStatements().count == 5)
        
        model?.incomeStatements().forEach {
            $0.itens.forEach {
                XCTAssertTrue($0.paymentStatus == .income)
            }
        }
        
        model?.outcomeStatements().forEach {
            $0.itens.forEach {
                XCTAssertTrue($0.paymentStatus == .outcome)
            }
        }
        
        model?.futureStatements().forEach {
            $0.itens.forEach {
                XCTAssertTrue($0.paymentStatus == .future)
            }
        }
    }
}
