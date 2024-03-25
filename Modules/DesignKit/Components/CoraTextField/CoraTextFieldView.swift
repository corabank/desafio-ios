//
//  CoraTextFieldView.swift
//  DesignKit
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit

public protocol CoraTextFieldViewDelegate: AnyObject {
    func textFieldShouldReturn(_ textField: UITextField)
    func textDidUpdateText(value: String)
}

public class CoraTextFieldView: UIView {
    
    private weak var delegate: CoraTextFieldViewDelegate?
    private var viewModel: CoraTextFieldViewModelProtocol?
    
    public lazy var textFielView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var eyeImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        return image
    }()
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        let height: CGFloat = 32.0
        return CGSize(width: superSize.width, height: height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func instantiate(_ viewModel: CoraTextFieldViewModelProtocol, delegate: CoraTextFieldViewDelegate) -> CoraTextFieldView {
        return setup(viewModel, delegate: delegate)
    }
    
    public func setViewModel(_ viewModel: CoraTextFieldViewModelProtocol) {
        self.viewModel = viewModel
        bindElements()
        buildComponent()
    }
    
    public func getValue() -> String {
        return textFielView.text ?? ""
    }
    
    private static func setup(_ viewModel: CoraTextFieldViewModelProtocol, delegate: CoraTextFieldViewDelegate) -> CoraTextFieldView {
        let component = CoraTextFieldView()
        component.delegate = delegate
        component.setViewModel(viewModel)
        return component
    }
    
    private func bindElements() {
        viewModel?.passwordButton?.isShowPassword.bind { [weak self] value in
            guard let self = self else { return }
            eyeImage.image = value ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash")
            textFielView.isSecureTextEntry = !value
        }
    }
    
    private func buildComponent() {
        setupTextFieldView()
        setupEyeImage()
    }
    
    private func setupEyeImage() {
        guard let hasSecure = viewModel?.passwordButton?.hasSecure, hasSecure else { return }
        
        addSubview(eyeImage)
        
        NSLayoutConstraint.activate([
            eyeImage.topAnchor.constraint(equalTo: topAnchor),
            eyeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            eyeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            eyeImage.heightAnchor.constraint(equalToConstant: 32),
            eyeImage.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        eyeImage.tintColor = viewModel?.passwordButton?.tintColor
        eyeImage.isUserInteractionEnabled = true
        eyeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEye)))
    }
    
    private func setupTextFieldView() {
        addSubview(textFielView)
        
        NSLayoutConstraint.activate([
            textFielView.topAnchor.constraint(equalTo: topAnchor),
            textFielView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            textFielView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textFielView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        textFielView.font = viewModel?.textField.font
        textFielView.delegate = self
        textFielView.keyboardType = viewModel?.textField.keyboardType ?? .default
    }
    
    @objc
    private func didTapEye() {
        viewModel?.passwordButton?.isShowPassword.value.toggle()
    }
}

extension CoraTextFieldView: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textDidUpdateText(value: textField.text ?? "")
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.textFieldShouldReturn(textField)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        guard let typeInput = viewModel?.textField.type, typeInput != .cpf else {
            
            // Obtém a string completa (texto atual + texto a ser adicionado)
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Remove todos os caracteres não numéricos
            let numericString = updatedText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            // Verifica se a string numérica tem mais de 11 caracteres
            guard numericString.count <= 11 else {
                return false
            }
            
            // Formata o texto do CPF
            let formattedCPF = formatCPF(numericString)
            
            // Atualiza o texto do UITextField
            textField.text = formattedCPF
            
            // Retorna falso para impedir que o UITextField processe a entrada do usuário
            return false
        }
        
        return typeInput == .custom
        
    }
    
    func formatCPF(_ text: String) -> String {
        var formattedCPF = ""
        
        // Itera sobre cada caractere do texto
        for (index, character) in text.enumerated() {
            // Adiciona um ponto após cada bloco de 3 dígitos
            if index == 3 || index == 6 {
                formattedCPF += "."
            }
            // Adiciona um hífen após o bloco de 6 dígitos
            if index == 9 {
                formattedCPF += "-"
            }
            // Adiciona o caractere atual
            formattedCPF.append(character)
        }
        
        return formattedCPF
    }
}
