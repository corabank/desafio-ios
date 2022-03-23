import UIKit
import TinyConstraints

final class HomeView: UIView {

    var didTapLogin: (() -> Void)?

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: Images.loginBackground.image)
        imageView.contentMode = .bottom
        imageView.clipsToBounds = true
        return imageView
    }()

    private let logoCoraImage = UIImageView(image: Images.logoCora.image)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Home.title
        label.font = .homeTitle
        label.textColor = .white
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Home.subtitle
        label.font = .homeSubTitle
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Home.description
        label.font = .body1
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let signupButton = SignupButton()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Home.Button.login, for: .normal)
        button.titleLabel?.font = .body2
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.accessibilityIdentifier = "buttonLogin"
        return button
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .mainCora
        addViews()
        addConstraints()
        addActions()
    }

    private func addViews() {
        addSubview(backgroundImage)
        addSubview(logoCoraImage)
        addSubview(contentStackView)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(subtitleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(signupButton)
        contentStackView.addArrangedSubview(loginButton)
    }

    private func addConstraints() {
        logoCoraImage.topToSuperview(offset: 24)
        logoCoraImage.leftToSuperview(offset: 24)

        backgroundImage.edgesToSuperview(excluding: .bottom)
        backgroundImage.bottomToTop(of: contentStackView, offset: -24, relation: .equalOrLess)
        backgroundImage.setCompressionResistance(.defaultLow, for: .vertical)

        contentStackView.edgesToSuperview(excluding: .top, insets: .horizontal(24) + .bottom(24))
        contentStackView.setCustomSpacing(16, after: subtitleLabel)
        contentStackView.setCustomSpacing(24, after: descriptionLabel)
        contentStackView.setCustomSpacing(16, after: signupButton)

        loginButton.height(48)
    }

    private func addActions() {
        loginButton.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
    }

    @objc
    private func onLoginTapped() {
        didTapLogin?()
    }
}
