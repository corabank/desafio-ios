import UIKit

final class StatementItemCell: UITableViewCell {
    private lazy var iconImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }()
    
    private lazy var valueLabel = UILabel()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Regular.primarySubtitle
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Regular.primarySubtitle
        label.textColor = Colors.gray01.color
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Regular.secondarySubtitle
        label.textColor = Colors.gray01.color
        label.textAlignment = .right
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, descriptionLabel, nameLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImage, textsStackView, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space03
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top:  Spacing.space04,
                                               left: Spacing.space04,
                                               bottom: .zero,
                                               right: Spacing.space04)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(content: StatementItemContent) {
        iconImage.image = content.icon
        valueLabel.attributedText = content.formattedValue
        descriptionLabel.text = content.description
        timeLabel.text = content.hour
        nameLabel.text = content.name
        iconImage.tintColor = content.tintColor
        descriptionLabel.textColor = content.tintColor
        valueLabel.textColor = content.tintColor
    }
}

extension StatementItemCell: BuildableView {
    func setupHierarchy() {
        contentView.addSubview(rootStackView)
    }
    
    func setupConstraints() {
        rootStackView.fitToParent()
    }
    
    func setupStyles() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
