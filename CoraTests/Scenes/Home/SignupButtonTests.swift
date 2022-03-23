import Quick
import Nimble
import Nimble_Snapshots

@testable import Cora

final class SignupButtonTests: QuickSpec {
    override func spec() {
        var sut: SignupButton!

        beforeEach {
            sut = SignupButton()
        }

        describe("#init") {
            it("expect to have a valid snapshot") {
                expect(sut).to(haveValidSnapshot())
            }
        }
    }
}
