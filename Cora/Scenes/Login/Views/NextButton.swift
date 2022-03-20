import UIKit

final class NextButton: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.Button.next
        label.font = .body2
        label.textColor = .white
        return label
    }()

    private let arrowImage: UIImageView = {
        let image = Images.iconArrowRight.image.withRenderingMode(.alwaysTemplate)
        let imageview = UIImageView(image: image)
        imageview.contentMode = .scaleAspectFit
        imageview.tintColor = .white
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
        backgroundColor = .gray2
        layer.cornerRadius = 12
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(titleLabel)
        addSubview(arrowImage)
    }

    private func addConstraints() {
        titleLabel.edgesToSuperview(excluding: .right, insets: .left(24))
        titleLabel.rightToLeft(of: arrowImage, offset: 10, relation: .equalOrLess)

        arrowImage.edgesToSuperview(excluding: .left, insets: .right(16))

        height(48)
    }
}
