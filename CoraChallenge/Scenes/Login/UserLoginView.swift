//
//  UserLoginView.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/21/22.
//

import UIKit

@objc protocol UserLoginViewDelegate: AnyObject {
    @objc func missPasswordButton()
    @objc func nextButtonPressed()
}

class UserLoginView: UIView {

    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [regularLabel, boldLabel, cpfTextField, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .coraBackgroundWhite
        return stackView
    }()
    
    private lazy var regularLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 16)
        label.textColor = .coraDarkGray
        return label
    }()
    
    private lazy var boldLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        label.textColor = .coraBlack
        return label
    }()
    
    private lazy var cpfTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        textField.font = UIFont(name: "Avenir-Roman", size: 16)
        textField.placeholder = "PLACEHOLDER"
        textField.textColor = .coraDarkGray
        textField.backgroundColor = .coraBackgroundWhite
        textField.keyboardType = .numberPad
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var hidePasswordButton: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "ic_eye-hidden")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.coraPink, for: .normal)
        button.imageView?.image = image
        return button
    }()
    
    lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(UIColor.coraPink, for: .normal)
        button.titleLabel?.font = UIFont(name:"Avenir-Roman", size: 14)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coraMediumGray
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 16
        button.setTitle("Próximo", for: .normal)
        return button
    }()
    
    private var buttomBottomConstraint: CGFloat = -24 {
        didSet {
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: buttomBottomConstraint).isActive = true
            layoutIfNeeded()
        }
    }
    
    var regularLabelText: String? {
        didSet {
            if regularLabelText != nil {
                self.regularLabel.text = regularLabelText
            } else {
                self.regularLabel.isHidden = true
            }
            
        }
    }
    
    var boldLabelText: String? {
        didSet {
            self.boldLabel.text = boldLabelText
        }
    }
    
    var isLinkButtonHidden: Bool = true {
        didSet {
            self.linkButton.isHidden = isLinkButtonHidden
        }
    }
    
    var isPassword: Bool = true {
        didSet {
            self.hidePasswordButton.isHidden = isPassword
            if isPassword {
                cpfTextField.textContentType = .password
            } else {
                cpfTextField.isSecureTextEntry = false
            }
        }
    }
    
    weak var delegate: UserLoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserLoginView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        cpfTextField.addDoneToolbar()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string:  String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if isPassword {
            textField.text = formattedNumber(number: newString, mask: "")
        } else {
            textField.text = formattedNumber(number: newString, mask: "###.###.###-##")
        }
        return false
    }
    
    func formattedNumber(number: String, mask: String) -> String {
        let cpfNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = mask
        var result = ""
        var index = cpfNumber.startIndex
        for ch in mask where index < cpfNumber.endIndex {
            if ch == "#" {
                result.append(cpfNumber[index])
                index = cpfNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension UserLoginView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(regularLabel)
        addSubview(boldLabel)
        addSubview(cpfTextField)
        cpfTextField.addSubview(hidePasswordButton)
        addSubview(linkButton)
        addSubview(nextButton)
    }
    
    func viewCodeConstraintSetup() {
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            regularLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            regularLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            regularLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            boldLabel.topAnchor.constraint(equalTo: regularLabel.bottomAnchor, constant: padding),
            boldLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            boldLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            cpfTextField.topAnchor.constraint(equalTo: boldLabel.bottomAnchor, constant: 32),
            cpfTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            cpfTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            hidePasswordButton.heightAnchor.constraint(equalToConstant: padding),
            hidePasswordButton.widthAnchor.constraint(equalToConstant: padding),
            hidePasswordButton.trailingAnchor.constraint(equalTo: cpfTextField.trailingAnchor, constant: -8),
            
            linkButton.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor, constant: padding),
            linkButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            
            nextButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        self.buttomBottomConstraint = -padding
    }
    
    func viewCodeAditionalSetup() {
        backgroundColor = .coraBackgroundWhite
        regularLabel.text = regularLabelText
    }
    
    func addKeyboardObserver(isloading: Bool) {
        if isloading {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let keyboardHeight = keyboardSize?.height
        
        self.buttomBottomConstraint = -keyboardHeight!+24
        
        UIView.animate(withDuration: 0.5){
            self.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification){
        self.buttomBottomConstraint = -24
        UIView.animate(withDuration: 0.5){
            self.layoutIfNeeded()
        }
    }
}
