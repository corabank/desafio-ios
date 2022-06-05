//
//  LoginViewController.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol LoginDisplaying: AnyObject {
    func enableButton(_ isValid: Bool)
}

final class LoginViewController: CoraViewController<LoginInteracting> {
    typealias Strings = Localization.Login

    let coraForm = FormView(frame: .zero)
    var bottomContraint: NSLayoutConstraint?
    
    private lazy var buttonNext: CoraButton = {
        let button = CoraButton()
        let icon = Asset.arrowRight.image.paintImage(color: .white)
        button.render(.fill(.init(style: .secondary, icon: icon, title: Strings.buttonNext)))
        button.addTarget(self, action: #selector(didTapNextStep), for: .touchUpInside)
        return button
    }()
    
    override init(interactor: LoginInteracting) {
        super.init(interactor: interactor)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    public required init?(coder aDecoder: NSCoder) {
        nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        coraForm.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: ViewCode {
    
    func buildViewHierarchy() {
        view.addSubview(coraForm)
        view.addSubview(buttonNext)
    }
        
    func setupConstraints() {
        coraForm.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        
        bottomContraint = buttonNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.coraSpacing(.base07))

        NSLayoutConstraint.activate([
            /// Cora Form
            coraForm.topAnchor.constraint(equalTo: view.topAnchor),
            coraForm.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coraForm.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            /// Button Next
            buttonNext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.coraSpacing(.base07)),
            buttonNext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .coraSpacing(.base07)),
            bottomContraint!
        ])
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .coraColor(.white)
        title = Strings.titleNavigation
        buttonNext.render(.enabled(false))
        
        switch interactor.screenType {
        case .cpf:
            cpfForm()
        case .password:
            passwordForm()
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 0.35, delay: 0.3) {
                self.bottomContraint?.constant = -(keyboardHeight + 16.0)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.35, delay: 0.3) {
            self.bottomContraint?.constant = -.coraSpacing(.base07)
        }
    }
    
    func cpfForm() {
        coraForm.titleLabel.text = Strings.CpfForm.title
        coraForm.titleTextFieldLabel.text = Strings.CpfForm.titleTextField
        coraForm.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        coraForm.textField.placeholder = Strings.CpfForm.placeholder
        coraForm.textField.keyboardType = .numberPad
        coraForm.button.isHidden = true
    }
    
    func passwordForm() {
        coraForm.titleTextFieldLabel.text = Strings.PasswordForm.titleTextField
        coraForm.textField.placeholder = Strings.PasswordForm.placeholder
        coraForm.button.isHidden = false
        coraForm.textField.isSecureTextEntry = true
        coraForm.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        coraForm.textField.addEyeButton()
        coraForm.button.render(.fill(.init(style: .ghost, icon: nil, title: Strings.PasswordForm.buttontitle)))
        coraForm.button.contentHorizontalAlignment = .left
    }
}

extension LoginViewController: LoginDisplaying {
    func enableButton(_ isValid: Bool) {
        buttonNext.render(.enabled(isValid))
    }
}

@objc
extension LoginViewController {
    func textFieldDidChange(_ textField: UITextField) {
        if interactor.screenType == .cpf {
            textField.text = textField.text?.applyMask(Mask(format: Strings.CpfForm.mask))
        }
        interactor.validate(value: textField.text ?? String())
    }
    
    func didTapNextStep() {
        interactor.nextStep()
    }
}
