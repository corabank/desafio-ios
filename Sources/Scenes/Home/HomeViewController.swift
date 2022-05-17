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
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
        return stackView
    }()
    
    // MARK: BuildableView
    
    override func setupHierarchy() {
        view.addSubviews(bannerImage, logoImage, textsStackView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            textsStackView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor),
            textsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.branding00.color
    }
}
