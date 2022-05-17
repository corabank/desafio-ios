import UIKit

final class HomeViewController: BaseViewController<HomeInteracting> {
    private typealias Localizable = Strings.Home
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(image: Images.coraLogo.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bannerImage: UIImageView = {
        let imageView = UIImageView(image: Images.homeBanner.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.title
        label.font = Font.Highlighted.primaryTitle
        label.textColor = Colors.white.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptonLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.description
        label.font = Font.Regular.tertiaryTitle
        label.textColor = Colors.white.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptonLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space03
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.space03,
                                               left: Spacing.space04,
                                               bottom: Spacing.space04,
                                               right: Spacing.space04)
        return stackView
    }()
    
    private lazy var signUpButton: Button = {
        let action = UIAction { _ in print("Sign Up Clicked") }
        let button = Button(title: Localizable.signUp,
                            titleColor: Colors.branding00.color,
                            action: action,
                            icon: Images.icArrowRight.image,
                            style: .large)
        button.backgroundColor = Colors.white.color
        button.border(radius: Radius.large)
        return button
    }()
    
    private lazy var signInButton: Button = {
        let action = UIAction { [weak self] _ in
            self?.interactor.goSignInScene()
        }
        let button = Button(title: Localizable.signIn,
                            titleColor: Colors.white.color,
                            action: action,
                            style: .medium)
        button.backgroundColor = .clear
        button.border(color: Colors.white.color, radius: Radius.medium)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, signInButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space03
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: .zero,
                                               left: Spacing.space04,
                                               bottom: Spacing.space03,
                                               right: Spacing.space04)
        return stackView
    }()
    
    // MARK: BuildableView
    
    override func setupHierarchy() {
        view.addSubviews(bannerImage, logoImage, textsStackView, buttonsStackView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: Spacing.space04),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.space04)
        ])
        
        NSLayoutConstraint.activate([
            textsStackView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor),
            textsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(greaterThanOrEqualTo: textsStackView.bottomAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Spacing.space03)
        ])
    }
    
    override func setupStyles() {
        super.setupStyles()
        view.backgroundColor = Colors.branding00.color
    }
}
