import XCTest
@testable import Statement

class StatementDetailTests: XCTestCase {
    
    private var model: (StatementDetailViewModelProtocol & StatementDetailViewDelegate)!
    private var view: StatementDetailViewMock!
    private var coordinator: StatementDetailCoordinatorMock!
    private var dataSource: StatementDataSource!
    
    func setup() {
        model = StatementDetailViewModel()
        view = StatementDetailViewMock()
        coordinator = StatementDetailCoordinatorMock()
        dataSource = StatementDataSource()
        
        model.set(view: view)
        model.set(coordinator: coordinator)
        view.set(delegate: model)
    }
    
    
    func test_navigate_back() {
        setup()
        model.tapBack()
        XCTAssertTrue(coordinator.backWasCalled)
    }
    
    func test_view_set() {
        setup()
        let day1 = dataSource.getStatements().first
        let item1 = day1!.itens.first!
        let item2 = day1!.itens[1]
        let item4 = day1!.itens[3]
        let owner = dataSource.getUser()
        model.set(statement: item1, owner: owner)

        XCTAssertTrue(view.statement!.uuid == item1.uuid)
        XCTAssertTrue(view.mainTitle == "Data da transferência")
        XCTAssertTrue(view.navTitle == "Detalhe da transferência")
        XCTAssertTrue(view.personTo!.uuid == owner.uuid)
        XCTAssertTrue(view.personFrom!.uuid == item1.person.uuid)
        
        model.set(statement: item4, owner: owner)

        XCTAssertTrue(view.statement!.uuid == item4.uuid)
        XCTAssertTrue(view.mainTitle == "Data do boleto")
        XCTAssertTrue(view.navTitle == "Detalhe do boleto")
        XCTAssertTrue(view.personTo!.uuid == item4.person.uuid)
        XCTAssertTrue(view.personFrom!.uuid == owner.uuid)
        
        model.set(statement: item2, owner: owner)

        XCTAssertTrue(view.statement!.uuid == item2.uuid)
        XCTAssertTrue(view.mainTitle == "Data do pagamento")
        XCTAssertTrue(view.navTitle == "Detalhe do pagamento")
        XCTAssertTrue(view.personTo!.uuid == owner.uuid)
        XCTAssertTrue(view.personFrom!.uuid == item2.person.uuid)
    }
}
