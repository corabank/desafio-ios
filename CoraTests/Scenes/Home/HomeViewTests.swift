import Quick
import Nimble
import Nimble_Snapshots

@testable import Cora
import UIKit

final class HomeViewTests: QuickSpec {
    override func spec() {
        var sut: HomeView!

        beforeEach {
            sut = HomeView(frame: UIScreen.main.bounds)
        }

        describe("#init") {
            it("expect to have a valid snapshot") {
                expect(sut).to(haveValidSnapshot())
            }
        }

        describe("#didTapLogin") {
            var didTapLogin = false

            beforeEach {
                sut.didTapLogin = {
                    didTapLogin = true
                }

                let loginButton = sut.viewwi
            }

            it("") {

            }
        }
    }
}
