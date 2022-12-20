import UIKit

class BaseViewController<Interactor>: UIViewController, BuildableView {
    private lazy var backButton = UIBarButtonItem(image: Images.icChevronLeft.image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(didTapBackButton))
    
    private lazy var customNavigationItem: UINavigationItem = {
        let navItem = UINavigationItem(title: title ?? "")
        navItem.leftBarButtonItem = backButton
        return navItem
    }()
    
    private lazy var customNavBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.titleTextAttributes = navBarTitleAttributes
        navBar.shadowImage = UIImage()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.tintColor = Colors.branding00.color
        navBar.backgroundColor = Colors.gray04.color
        navBar.setItems([customNavigationItem], animated: false)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private lazy var statusBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray04.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let interactor: Interactor
    let navigationBarHeight: CGFloat = 44
    
    private var navBarTitleAttributes: [NSAttributedString.Key : Any] {
        return [
            .font: Font.Regular.primarySubtitle,
            .foregroundColor: Colors.gray01.color
        ]
    }
    
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
    
    func setupCustomNavigationBar() {
        view.addSubviews(customNavBar, statusBarBackgroundView)
        
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarBackgroundView.bottomAnchor.constraint(equalTo: customNavBar.topAnchor)
        ])
    }
    
    /// override didTapRightButton to implement item action
    func setRightButtonItem(icon: UIImage) {
        customNavigationItem.rightBarButtonItem = UIBarButtonItem(image: icon,
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(didTapRightButton))
    }
    
    // MARK: BuildableView
    
    func setupHierarchy() { }
    
    func setupConstraints() { }
    
    func setupStyles() { }
    
    // MARK: Objc functions
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRightButton() {
        // to be overrited
    }
}
