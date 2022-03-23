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

                // swiftlint:disable:next force_cast
                let loginButton = sut.viewWithTag(35) as! UIButton
                loginButton.sendActions(for: .touchUpInside)
            }

            it("expect flag to be true") {
                expect(didTapLogin).to(beTrue())
            }
        }
    }
}
