import UIKit

protocol PasswordDisplaying: AnyObject {
    func displayNextStepButton(isEnabled: Bool)
    func displayPassword(isVisible: Bool, fieldImage: UIImage)
}

final class PasswordViewController: BaseViewController<PasswordInteracting> {
    private typealias Localizable = Strings.Password
    
    private lazy var solicitationLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.solicitation
        label.textColor = Colors.offBlack.color
        label.font = Font.Highlighted.secondaryTitle
        return label
    }()
    
    private lazy var togglePasswordButton: UIButton = {
        let action = UIAction { _ in self.interactor.tooglePasswordVisibility() }
        let button = UIButton()
        button.addAction(action, for: .touchUpInside)
        button.setImage(Images.icEyeHidden.image, for: [])
        button.tintColor = Colors.branding00.color
        return button
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.rightView = togglePasswordButton
        textField.rightViewMode = .always
        textField.textColor = Colors.offBlack.color
        textField.tintColor = Colors.offBlack.color
        textField.font = Font.Regular.secondaryTitle
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var forgotPasswordButton: Button = {
        let action = UIAction { _ in print("Forgot Password Clicked") }
        let button = Button(title: Localizable.forgotPassword,
                            titleColor: Colors.branding00.color,
                            action: action,
                            style: .small)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.configuration?.contentInsets = .zero
        return button
    }()
    
    private lazy var nextStepButton: Button = {
        let action = UIAction { _ in  self.interactor.performNextStep() }
        let button = Button(title: Localizable.nextStep,
                            titleColor: Colors.white.color,
                            action: action,
                            icon: Images.icArrowRight.image,
                            style: .medium)
        button.backgroundColor = Colors.gray02.color
        button.border(radius: Radius.medium)
        button.imageTintColor = Colors.white.color
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var fieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [solicitationLabel, passwordField, forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space03
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: Spacing.space04,
                                               left: Spacing.space04,
                                               bottom: Spacing.space05,
                                               right: Spacing.space04)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        setupCustomNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        passwordField.becomeFirstResponder()
    }
    
    // MARK: BuildableView
    
    override func setupHierarchy() {
        view.addSubviews(fieldStackView, nextStepButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            fieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarHeight),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextStepButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Spacing.space03),
            nextStepButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Spacing.space04),
            nextStepButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Spacing.space04),
            nextStepButton.topAnchor.constraint(greaterThanOrEqualTo: forgotPasswordButton.bottomAnchor)
        ])
        
        togglePasswordButton.size(32)
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

extension PasswordViewController: PasswordDisplaying {
    func displayNextStepButton(isEnabled: Bool) {
        let backgroundColor = isEnabled ? Colors.branding00.color : Colors.gray02.color
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .transitionCrossDissolve,
            animations: {
            self.nextStepButton.isEnabled = isEnabled
            self.nextStepButton.backgroundColor = backgroundColor
        })
    }
    
    func displayPassword(isVisible: Bool, fieldImage: UIImage) {
        passwordField.isSecureTextEntry = !isVisible
        togglePasswordButton.setImage(fieldImage, for: [])
    }
}

// MARK: - UITextFieldDelegate
extension PasswordViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let fieldText = (textField.text ?? "") as NSString
        let newText = fieldText.replacingCharacters(in: range, with: string)
        interactor.didChangeText(to: newText)
        return true
    }
}
