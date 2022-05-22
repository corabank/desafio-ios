import class UIKit.UIViewController

class ViewControllerSpy: UIViewController {
    private(set) var callShowCount = 0
    private(set) var callPresentCount = 0
    
    private(set) var shownViewController: UIViewController?
    private(set) var viewControllerToPresent: UIViewController?
    
    override func show(_ vc: UIViewController, sender: Any?) {
        callShowCount += 1
        shownViewController = vc
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        callPresentCount += 1
        self.viewControllerToPresent = viewControllerToPresent
    }
}
