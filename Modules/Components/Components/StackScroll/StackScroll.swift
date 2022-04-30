import UIKit
import ViewCode

public final class StackScrollView: UIScrollView {

    private lazy var mainStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    required init?(coder: NSCoder) { return nil }
    public init(spacing: CGFloat) {
        super.init(frame: .zero)
        setupViewDetails(spacing)
        setupView()
    }

    private func setupViewDetails(_ spacing: CGFloat) {
        mainStack.spacing = spacing
    }

    public func addView(view: UIView,
                        paddingTop: CGFloat = 0,
                        paddingBottom: CGFloat = 0,
                        paddingLeft: CGFloat = 0,
                        paddingRight: CGFloat = 0) {

        let wrapper: UIView = UIView()
        wrapper.addSubview(view)

        view.anchor(top: wrapper.topAnchor,
                    leading: wrapper.leadingAnchor,
                    bottom: wrapper.bottomAnchor,
                    trailing: wrapper.trailingAnchor,
                    paddingTop: paddingTop, paddingBottom: paddingBottom,
                    paddingLeft: paddingLeft, paddingRight: paddingRight)

        mainStack.addArrangedSubview(wrapper)
    }
}

extension StackScrollView: ViewCode {
    public func setSubviews() {
        addSubview(mainStack)
    }

    public func setConstraints() {
        mainStack.setAnchorsEqual(to: self)
        mainStack.setWidthEqual(to: self)
    }
}
