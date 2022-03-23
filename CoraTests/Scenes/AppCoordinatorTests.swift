import Quick
import Nimble

@testable import Cora

final class AppCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: AppCoordinator!

        beforeEach {
            sut = AppCoordinator()
            UIView.setAnimationsEnabled(false)
        }

        describe("#trigger") {
            context("home") {
                it("expext controller to be kind of HomeController") {
                    waitUntil { done in
                        sut.trigger(.home) {
                            done()
                        }
                    }
                    expect(sut.rootViewController.visibleViewController).to(beAKindOf(HomeController.self))
                }
            }

            context("login") {
                it("expext controller to be kind of LoginController") {
                    waitUntil { done in
                        sut.trigger(.login) {
                            done()
                        }
                    }
                    expect(sut.rootViewController.visibleViewController).to(beAKindOf(LoginController.self))
                }
            }

            context("password") {
                it("expext controller to be kind of PasswordController") {
                    waitUntil { done in
                        sut.trigger(.password(document: "")) {
                            done()
                        }
                    }
                    expect(sut.rootViewController.visibleViewController).to(beAKindOf(PasswordController.self))
                }
            }

            context("invoices") {
                it("expext controller to be kind of InvoiceController") {
                    waitUntil { done in
                        sut.trigger(.invoices) {
                            done()
                        }
                    }
                    expect(sut.rootViewController.visibleViewController).to(beAKindOf(InvoiceController.self))
                }
            }
        }
    }
}
