import UIKit

final class LoginView: UIView {

    private let navBarView = NavbarView()
    private let documentView = DocumentView()
    private let passwordView = PasswordView()
    private let nextButton = NextButton()
    private let navBarHeight: CGFloat

    private let pagerContentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    init(navBarHeight: CGFloat) {
        self.navBarHeight = navBarHeight
        super.init(frame: .zero)
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
        addSubview(navBarView)
        addSubview(pagerContentStack)
        addSubview(nextButton)

        pagerContentStack.addArrangedSubview(documentView)
        pagerContentStack.addArrangedSubview(passwordView)
    }

    private func addConstraints() {
        navBarView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        navBarView.height(navBarHeight)

        pagerContentStack.horizontalToSuperview(insets: .horizontal(24))
        pagerContentStack.topToBottom(of: navBarView, offset: 24)

        nextButton.edgesToSuperview(excluding: .top, insets: .uniform(24), usingSafeArea: true)
    }
}
