import UIKit

protocol HomeDisplaying: AnyObject {
    //Display Protocol
}

private extension HomeViewController.Layout {
    enum Size {
        static let imageBackgroundHeight: CGFloat = 340.0
        static let buttonsStackViewHeight: CGFloat = 128.0
    }
}

final class HomeViewController: UIViewController {
    fileprivate enum Layout {}
    private lazy var imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.backgroundLogin
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 140
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.coraLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var homeTitleBold: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.homeTitleBold
        label.font = Typography.setFont(.bold(size: 28))()
        label.numberOfLines = 0
        label.textColor = Colors.white
        return label
    }()
    
    private lazy var homeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.homeTitle
        label.font = Typography.setFont(.regular(size: 28))()
        label.numberOfLines = 0
        label.textColor = Colors.white
        return label
    }()
    
    private lazy var homeSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.homeSubtitle
        label.font = Typography.setFont(.regular(size: 16))()
        label.numberOfLines = 0
        label.textColor = Colors.white
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [homeTitleBold, homeTitle, homeSubtitle])
        stackView.spacing = Spacing.space1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.signUpButtonTitle, for: [])
        button.setTitleColor(UIColor(named: "background"), for: [])
        button.setImage(Images.rightArrow, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = Colors.white
        button.semanticContentAttribute = .forceRightToLeft
        button.configuration?.titleAlignment = .automatic
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 140, bottom: 0, right: 0)
        button
        button.frame.size = CGSize(width: view.widthAnchor.hash, height: 64)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.loginButtonTitle, for: [])
        button.setTitleColor(.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = .clear
        button.layer.borderColor = Colors.white?.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, loginButton])
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    private let interactor: HomeInteracting
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - @objc Private Methods
@objc private extension HomeViewController {
    func loginButtonTapped() {
        interactor.loginScene()
    }
    
    func signUpButtonTapped() {
        interactor.signUpScene()
    }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: Layout.Size.imageBackgroundHeight)
        ])
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.space7),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space6),
            imageLogo.heightAnchor.constraint(equalToConstant: Spacing.space5)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: Spacing.space3),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            labelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Spacing.space7),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space5),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.space5),
            buttonsStackView.heightAnchor.constraint(equalToConstant: Layout.Size.buttonsStackViewHeight)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(imageLogo)
        view.addSubview(labelsStackView)
        view.addSubview(buttonsStackView)
    }
    
    func setupStyles() {
        view.backgroundColor = Colors.backgroundColor
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    //Para implementar ações na tela por meio de protocolo
}
