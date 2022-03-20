import UIKit
import TinyConstraints

final class PasswordView: UIView {

    var onNextButtonTapped: ((String) -> Void)?

    private let bottomConstraintInitialConstant: CGFloat = -24

    private let passwordlabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Login.Question.password
        label.font = .title3Bold
        label.textColor = .gray5
        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray1
        textField.font = .title3
        textField.tintColor = .gray5
        textField.keyboardType = .alphabet
        return textField
    }()

    private let forgotlabel: UILabel = {
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

    private let nextButton = NextButton()
    private var bottomConstraint: Constraint?

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
        addActions()
        passwordTextField.becomeFirstResponder()
    }

    private func addViews() {
        addSubview(contentStack)
        addSubview(nextButton)

        contentStack.addArrangedSubview(passwordlabel)
        contentStack.addArrangedSubview(passwordTextField)
        contentStack.addArrangedSubview(forgotlabel)
    }

    private func addConstraints() {
        contentStack.edgesToSuperview(excluding: .bottom, insets: .uniform(24), usingSafeArea: true)
        contentStack.setCustomSpacing(32, after: passwordlabel)
        contentStack.setCustomSpacing(48, after: passwordTextField)

        nextButton.horizontalToSuperview(insets: .horizontal(24), usingSafeArea: true)
        bottomConstraint = nextButton.bottomToSuperview(offset: bottomConstraintInitialConstant, usingSafeArea: true)
    }

    private func addActions() {
        nextButton.onTapped = { [weak self] in
            self?.onNextButtonTapped?(self?.passwordTextField.text ?? "")
        }
    }

    func updateBottomConstraint(keyboardHeight: CGFloat) {
        bottomConstraint?.constant = bottomConstraintInitialConstant - keyboardHeight
    }
}
