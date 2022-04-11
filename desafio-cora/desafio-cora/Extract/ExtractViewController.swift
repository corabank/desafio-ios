import UIKit

protocol ExtractDisplaying: AnyObject {
    //Display Protocol
}

private extension ExtractViewController.Layout {
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class ExtractViewController: UIViewController {
    fileprivate enum Layout {}

    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        let navItem = UINavigationItem(title: Strings.extractNavBarTitle)
        let backItem = UIBarButtonItem(image: Images.leftArrow, style: .done, target: self, action: #selector(backButtonTapped))
        let signOutItem = UIBarButtonItem(image: Images.signOut, style: .done, target: self, action: #selector(signOutButtonTapped))
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.gray1!]
        backItem.tintColor = Colors.backgroundColor
        signOutItem.tintColor = Colors.backgroundColor
        navItem.leftBarButtonItem = backItem
        navItem.rightBarButtonItem = signOutItem
        navBar.backgroundColor = Colors.gray4
        navBar.titleTextAttributes = textAttributes
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private let interactor: ExtractInteracting
    
    init(interactor: ExtractInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension ExtractViewController {
    func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func signOutButtonTapped(){
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ExtractViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(navBar)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.white
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - ExtractDisplaying
extension ExtractViewController: ExtractDisplaying {
    func displaySomething() { 
        //Para implementar ações na tela por meio de protocolo
    }
}
