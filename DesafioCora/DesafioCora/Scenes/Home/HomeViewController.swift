import UIKit

protocol HomeDisplay: AnyObject {
    func welcome(_ message: String)
}

class HomeViewController: UIViewController, ViewBuilderProtocol {
    typealias Localizable = HomeLocalizable
    private let interactor: HomeInteracting
    
    private enum Layout {
        enum Label {
            static let sideConstraint: CGFloat = 24
        }
    }
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.Base.branding300
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.textAlignment = .center
        return label
    }()
    
    init(_ interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet!")
    }
    
    override func viewDidLoad() {
        interactor.setup()
        buildLayout()
    }
    
    func setupHierarchy() {
        view.addSubview(welcomeLabel)
    }
    
    func setupConstraints() {
        let labelLeading = welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Label.sideConstraint)
        let labelTrailing = welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.Label.sideConstraint * -1)
        let labelCenterY = welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    
        NSLayoutConstraint.activate([labelLeading, labelTrailing, labelCenterY])
    }
    
    func setupViews() {
        view.backgroundColor = .white
        title = Localizable.View.title
    }
}

extension HomeViewController: HomeDisplay {
    func welcome(_ message: String) {
        welcomeLabel.text = message
    }
}
