import Foundation
import UIKit
import ViewCode
import Components

final class StatementView: UIViewController {
    
    private var viewModel: StatementViewDelegate?
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        return field
    }()
    
    private lazy var nextButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Proximo")
        button.addTarget(self, action: #selector(nextActionCallback), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) { return nil }
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    @objc
    private func nextActionCallback() {
        nextButton.flash()
    }
}

extension StatementView: ViewCode {
    func setSubviews() {
        view.addSubview(stack)
        stack.addArrangedSubview(UIView(frame: .zero))
        stack.addArrangedSubview(nextButton)
    }
    
    func setConstraints() {
        stack.setAnchorsEqual(to: self.view)
        nextButton.size(height: 48)
        nextButton.setWidthEqual(to: stack)
    }
    
    func extraSetups() {
        view.backgroundColor = .white
    }
}

extension StatementView: StatementViewProtocol {
    func set(delegate: StatementViewDelegate) {
        self.viewModel = delegate
    }
}
