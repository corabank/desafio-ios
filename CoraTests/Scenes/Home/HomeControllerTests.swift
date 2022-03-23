import Quick
import Nimble
import XCoordinator

@testable import Cora

final class HomeControllerTests: QuickSpec {
    override func spec() {
        var coordSpy: AppCoordinatorSpy!
        var view: HomeViewMock!
        var sut: HomeController!

        beforeEach {
            coordSpy = AppCoordinatorSpy()
            view = HomeViewMock()
            sut = HomeController(router: coordSpy.unownedRouter, contentView: view)
            sut.viewDidLoad()
            UIView.setAnimationsEnabled(false)
        }

        describe("#loadView") {
            it("expect view to not be nil") {
                expect(sut.view).notTo((beNil()))
            }
        }

        describe("#bindActions") {
            beforeEach {
                view.didTapLogin?()
            }

            it("expect router to trigger login router") {
                expect(coordSpy.lastRouteTriggered).to(equal(.login))
            }
        }
    }
}
