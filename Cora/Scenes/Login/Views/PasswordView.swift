import UIKit

final class PasswordView: UIView {
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.Question.password
        label.font = .title3Bold
        label.textColor = .gray5
        return label
    }()

    private let forgotLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.forgotPassword
        label.font = .body2
        label.textColor = .mainCora
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

        contentStack.addArrangedSubview(passwordLabel)
        contentStack.addArrangedSubview(forgotLabel)
    }

    private func addConstraints() {
        contentStack.edgesToSuperview()
        contentStack.setCustomSpacing(8, after: passwordLabel)
    }
}
