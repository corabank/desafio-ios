import UIKit

protocol SignInDisplaying: AnyObject {
    func displayNextStepButton(isEnabled: Bool)
    func displayMaskedField(text: String)
}

final class SignInViewController: BaseViewController<SignInInteracting> {
    private typealias Localizable = Strings.SignIn
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.welcome
        label.textColor = Colors.gray01.color
        label.font = Font.Regular.tertiaryTitle
        return label
    }()
    
    private lazy var cpfSolicitationLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.cpfSolicitation
        label.textColor = Colors.offBlack.color
        label.font = Font.Highlighted.secondaryTitle
        return label
    }()
    
    private lazy var textsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, cpfSolicitationLabel])
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
    
    private lazy var nextStepButton: Button = {
        let action = UIAction { _ in self.interactor.performNextStep() }
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
    
    private lazy var cpfField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.textColor = Colors.offBlack.color
        textField.tintColor = Colors.offBlack.color
        textField.font = Font.Regular.secondaryTitle
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.title
        setupCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBottomButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cpfField.becomeFirstResponder()
    }
    
    private func setupBottomButton() {
        NSLayoutConstraint.activate([
            nextStepButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Spacing.space03),
            nextStepButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Spacing.space04),
            nextStepButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Spacing.space04)
        ])
    }
    
    // MARK: BuildableView
    
    override func setupHierarchy() {
        view.addSubviews(textsStackView, nextStepButton, cpfField)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            textsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: navigationBarHeight),
            textsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cpfField.topAnchor.constraint(equalTo: textsStackView.bottomAnchor),
            cpfField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -Spacing.space04),
            cpfField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: Spacing.space04)
        ])
        
        setupBottomButton()
    }
    
    override func setupStyles() {
        view.backgroundColor = Colors.white.color
    }
}

extension SignInViewController: SignInDisplaying {
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
    
    func displayMaskedField(text: String) {
        cpfField.text = text
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let fieldText = (textField.text ?? "") as NSString
        let newText = fieldText.replacingCharacters(in: range, with: string)
        interactor.didChangeText(to: newText)
        return false
    }
}
