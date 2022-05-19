import UIKit

final class StatementHeaderView: UIView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Regular.secondarySubtitle
        label.textColor = Colors.gray01.color
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Highlighted.secondarySubtitle
        label.textColor = Colors.gray01.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLabel, balanceLabel])
        stack.axis = .horizontal
        stack.spacing = Spacing.space03
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: Spacing.space01,
                                           left: Spacing.space04,
                                           bottom: Spacing.space01,
                                           right: Spacing.space04)
        return stack
    }()
    
    init(content: StatementHeaderContent) {
        super.init(frame: .zero)
        dateLabel.text = content.formattedDate
        balanceLabel.text = content.dayBalance
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementHeaderView: BuildableView {
    func setupHierarchy() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.fitToParent()
    }
    
    func setupStyles() {
        backgroundColor = Colors.gray04.color
    }
}
