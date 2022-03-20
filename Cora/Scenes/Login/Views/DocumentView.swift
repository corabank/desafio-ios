import UIKit

final class DocumentView: UIView {

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.welcome
        label.font = .body1
        label.textColor = .gray1
        return label
    }()

    private let documentLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.Question.document
        label.font = .title3Bold
        label.textColor = .gray5
        return label
    }()

    private let contentStack: UIStackView = {
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
        backgroundColor = .white
        addViews()
        addConstraints()
//        addActions()
    }

    private func addViews() {
        addSubview(contentStack)

        contentStack.addArrangedSubview(welcomeLabel)
        contentStack.addArrangedSubview(documentLabel)
    }

    private func addConstraints() {
        contentStack.edgesToSuperview()
        contentStack.setCustomSpacing(8, after: welcomeLabel)
    }
}
