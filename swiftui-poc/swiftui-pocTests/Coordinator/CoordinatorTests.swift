import XCTest
@testable import swiftui_poc

class CoordinatorTests: XCTestCase {
    
    private let sut = MockCoordinator()
    
    func testAddChildCoordinators() {
        // given
        let coordinator1 = MockCoordinator()
        
        // when
        sut.startChild(coordinator1)
        
        // then
        XCTAssert(sut.childCoordinators.first === coordinator1)
    }
    
    func testRemoveChildCoordinators() {
        // given
        let coordinator1 = MockCoordinator()
        let coordinator2 = MockCoordinator()
        let coordinator3 = MockCoordinator()
        
        sut.childCoordinators.append(coordinator1)
        sut.childCoordinators.append(coordinator2)
        sut.childCoordinators.append(coordinator3)
        
        // when
        sut.childDidFinish(coordinator2)
        
        // then
        XCTAssert(sut.childCoordinators.count == 2)
        XCTAssert(sut.childCoordinators.first === coordinator1)
        XCTAssert(sut.childCoordinators.last === coordinator3)
    }
}
