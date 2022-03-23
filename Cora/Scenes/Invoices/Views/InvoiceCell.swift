import UIKit

final class InvoiceCell: UITableViewCell {
    private let firstLine: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    private let secondLine: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .caption
        label.textColor = .gray1
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption
        label.textColor = .gray5
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption
        label.textColor = .gray1
        return label
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .captionBold
        label.textColor = .gray5
        return label
    }()

    private let subValueLabel: UILabel = {
        let label = UILabel()
        label.font = .captionBold
        label.textColor = .gray1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear
        addViews()
        addConstraints()
    }

    private func addViews() {
        firstLine.addArrangedSubview(dateLabel)
        firstLine.addArrangedSubview(titleLabel)
        firstLine.addArrangedSubview(valueLabel)

        secondLine.addArrangedSubview(subtitleLabel)
        secondLine.addArrangedSubview(subValueLabel)

        contentView.addSubview(firstLine)
        contentView.addSubview(secondLine)
    }

    private func addConstraints() {
        firstLine.edgesToSuperview(excluding: .bottom)
        secondLine.edgesToSuperview(excluding: .init(arrayLiteral: .left, .top))
        secondLine.topToBottom(of: firstLine)

        firstLine.setCustomSpacing(16, after: dateLabel)
        firstLine.setCustomSpacing(16, after: titleLabel)

        secondLine.setCustomSpacing(16, after: subtitleLabel)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"

        return formatter.string(from: date)
    }

    func show(viewModel: InvoiceViewModel) {
        dateLabel.text = formatDate(viewModel.date)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        valueLabel.text = viewModel.value
        subValueLabel.text = viewModel.subValue

        if viewModel.subtitle == nil || viewModel.subValue == nil {
            secondLine.arrangedSubviews.forEach { $0.isHidden = true }
        }

        if viewModel.isInvoicePayment {
            dateLabel.textColor = .mainSecondary
            titleLabel.textColor = .mainSecondary
            valueLabel.textColor = .mainSecondary
        }
    }
}
