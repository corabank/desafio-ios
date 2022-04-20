import UIKit
@testable import desafio_cora

final class ViewControllerSpy: UIViewController {
    private(set) var callShowViewControllerCount = 0
    private(set) var callPresentViewControllerCount = 0
    private(set) var viewController: UIViewController?
    
    override func show(_ vc: UIViewController, sender: Any?) {
        callShowViewControllerCount += 1
        viewController = vc
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        callPresentViewControllerCount += 1
    }
}
