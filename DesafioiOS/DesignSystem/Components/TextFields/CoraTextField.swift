//
//  CoraTextField.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

final class CoraTextField: UITextField {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setup() {
        font = .systemFont(ofSize: .coraFont(.title3), weight: .regular)
        textColor = .coraColor(.gray1)
    }
    
    func addEyeButton() {
        var configuration = UIButton.Configuration.filled()
        configuration.image = Asset.eyeHidden.image
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let button = UIButton(configuration: configuration)
        button.tintColor = .clear
        button.backgroundColor = .clear
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.didTapEyeButton), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
    
    @objc func didTapEyeButton() {
        isSecureTextEntry = !isSecureTextEntry
    }
}

