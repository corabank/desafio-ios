import UIKit

class BaseViewController<Interactor>: UIViewController, BuildableView {
    let interactor: Interactor
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    // MARK: BuildableView
    
    func setupHierarchy() { }
    
    func setupConstraints() { }
    
    func setupStyles() { }
}
