import Foundation
import UIKit
import ViewCode
import Components

final class CPFFormView: UIViewController {
    
    private var viewModel: CPFFormViewDelegate?
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = Dimensions.verySmall
        return stack
    }()
    
    private lazy var navigation: NavigationBar = {
        let nav = NavigationBar()
        return nav
    }()

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo de volta!"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.darkGray
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Qual seu CPF?"
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontMedium, weight: .bold)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField(frame: .zero)
        return field
    }()
    
    private lazy var nextButton: RegularButton = {
        let button = RegularButton()
        button.set(title: "Próximo", alignment: .left, style: .pink, icon: .arrow)
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
        viewModel?.inputCPF()
    }
}

extension CPFFormView: ViewCode {
    func setSubviews() {
        view.addSubviews([stack, nextButton])
        stack.addArrangedSubview(navigation)
        stack.addArrangedSubview(Spacer(size: Dimensions.small))
        stack.addArrangedSubview(welcomeLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(UIView(frame: .zero))
    }
    
    func setConstraints() {
        navigation.setWidthEqual(to: view)
        stack.anchor(top: view.topAnchor,
                     leading: view.leadingAnchor,
                     trailing: view.trailingAnchor)
        
        welcomeLabel.setWidthEqual(to: stack)
        titleLabel.setWidthEqual(to: stack)
        
        nextButton.size(height: 50)
        nextButton.anchor(leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,
                          paddingBottom: Dimensions.mediumSmall,
                          paddingLeft: Dimensions.medium,
                          paddingRight: Dimensions.medium)
    }
    
    func extraSetups() {
        view.backgroundColor = Colors.white
    }
}

extension CPFFormView: CPFFormViewProtocol {
    func set(delegate: CPFFormViewDelegate) {
        self.viewModel = delegate
    }
}
