import UIKit

final class LoginView: UIView {
    private let documentView = DocumentView()
    private let passwordView = PasswordView()
    private let nextButton = NextButton()

    private let pagerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
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
        addSubview(pagerContentStack)
        addSubview(nextButton)

        pagerContentStack.addArrangedSubview(documentView)
        pagerContentStack.addArrangedSubview(passwordView)
    }

    private func addConstraints() {
        pagerContentStack.edgesToSuperview(excluding: .bottom, insets: .uniform(24), usingSafeArea: true)

        nextButton.edgesToSuperview(excluding: .top, insets: .uniform(24), usingSafeArea: true)
    }
}
