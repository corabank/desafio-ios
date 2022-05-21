import class UIKit.UIViewController

class ViewControllerSpy: UIViewController {
    private(set) var callShowCount = 0
    
    private(set) var shownViewController: UIViewController?
    
    override func show(_ vc: UIViewController, sender: Any?) {
        callShowCount += 1
        shownViewController = vc
    }
}
