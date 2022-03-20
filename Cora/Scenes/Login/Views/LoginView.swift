import UIKit
import TinyConstraints

final class LoginView: UIView {

    var onNextButtonTapped: ((String) -> Void)?

    private let bottomConstraintInitialConstant: CGFloat = -24

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

    private let documentTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray1
        textField.font = .title3
        textField.tintColor = .gray5
        textField.keyboardType = .numberPad
        return textField
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
        documentTextField.becomeFirstResponder()
    }

    private func addViews() {
        addSubview(contentStack)
        addSubview(nextButton)

        contentStack.addArrangedSubview(welcomeLabel)
        contentStack.addArrangedSubview(documentLabel)
        contentStack.addArrangedSubview(documentTextField)
    }

    private func addConstraints() {
        contentStack.edgesToSuperview(excluding: .bottom, insets: .uniform(24), usingSafeArea: true)
        contentStack.setCustomSpacing(8, after: welcomeLabel)
        contentStack.setCustomSpacing(32, after: documentLabel)

        nextButton.horizontalToSuperview(insets: .horizontal(24), usingSafeArea: true)
        bottomConstraint = nextButton.bottomToSuperview(offset: bottomConstraintInitialConstant, usingSafeArea: true)
    }

    private func addActions() {
        nextButton.onTapped = { [weak self] in
            self?.onNextButtonTapped?(self?.documentTextField.text ?? "")
        }
    }

    func updateBottomConstraint(keyboardHeight: CGFloat) {
        bottomConstraint?.constant = bottomConstraintInitialConstant - keyboardHeight
    }
}
