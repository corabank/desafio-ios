import UIKit

final class SignupButton: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Home.Button.signup
        label.font = .body1
        label.textColor = .mainCora
        return label
    }()

    private let arrowImage: UIImageView = {
        let imageview = UIImageView(image: Images.iconArrowRight.image)
        imageview.contentMode = .scaleAspectFit
        return imageview
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
        backgroundColor = .white
        layer.cornerRadius = 16
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(titleLabel)
        addSubview(arrowImage)
    }

    private func addConstraints() {
        titleLabel.edgesToSuperview(excluding: .right, insets: .left(24))
        titleLabel.rightToLeft(of: arrowImage, offset: -10, relation: .equalOrLess)

        arrowImage.edgesToSuperview(excluding: .left, insets: .right(16))

        height(64)
    }
}
