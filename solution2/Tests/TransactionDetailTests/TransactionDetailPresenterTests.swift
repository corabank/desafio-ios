@testable import Cora
import XCTest

private final class TransactionDetailCoordinatorSpy: TransactionDetailCoordinating {
    private(set) var callCoordinateToActivityControllerCount = 0
    private(set) var calledShareItem: UIImage?
    
    func coordinateToActivityController(shareItem: UIImage) {
        callCoordinateToActivityControllerCount += 1
        calledShareItem = shareItem
    }
}

private final class TransactionDetailViewControllerSpy: TransactionDetailDisplaying {
    private(set) var callDisplayContentCount = 0
    private(set) var calledViewModel: TransactionDetailViewModel?
    
    func displayContent(viewModel: TransactionDetailViewModel) {
        callDisplayContentCount += 1
        calledViewModel = viewModel
    }
}

final class TransactionDetailPresenterTests: XCTestCase {
    private let coordinatorSpy = TransactionDetailCoordinatorSpy()
    private let viewControllerSpy = TransactionDetailViewControllerSpy()
    private lazy var sut: TransactionDetailPresenter = {
        let presenter = TransactionDetailPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresentContent_ShouldCallDisplayContentWithViewModel() {
        sut.presentContent(transactionDetail: .mock)
        
        XCTAssertEqual(viewControllerSpy.callDisplayContentCount, 1)
        XCTAssertEqual(viewControllerSpy.calledViewModel, TransactionDetailViewModel(transactionDetail: .mock))
    }
    
    func testPresentActivityController_ShouldCallCoordinateToActivityControllerWithShareItem() {
        let image = UIImage()
        sut.presentActivityController(shareItem: image)
        
        XCTAssertEqual(coordinatorSpy.callCoordinateToActivityControllerCount, 1)
        XCTAssertEqual(coordinatorSpy.calledShareItem, image)
    }
}
