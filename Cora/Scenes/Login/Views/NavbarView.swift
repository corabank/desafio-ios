import UIKit

final class NavbarView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.title
        label.font = .body2
        label.textColor = .gray1
        return label
    }()

    private let arrowImage: UIImageView = {
        let imageview = UIImageView(image: Images.iconArrowLeft.image)
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
        backgroundColor = .gray4
        layer.cornerRadius = 12
        addViews()
        addConstraints()
    }

    private func addViews() {
        addSubview(titleLabel)
        addSubview(arrowImage)
    }

    private func addConstraints() {
        titleLabel.centerInSuperview()

        arrowImage.verticalToSuperview()
        arrowImage.leftToSuperview(offset: 16)
    }
}
