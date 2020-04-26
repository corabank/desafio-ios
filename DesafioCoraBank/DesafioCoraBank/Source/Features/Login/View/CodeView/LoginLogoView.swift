//
//  LoginLogoView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class LoginLogoView: UIView {
    
    public lazy var logoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "awesome-logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbWhite
        let boldAttributes = [NSAttributedString.Key.font: UIFont.cbBold(16), NSAttributedString.Key.foregroundColor: UIColor.cbWhite]
        let lightAttributes = [NSAttributedString.Key.font: UIFont.cbLight(16), NSAttributedString.Key.foregroundColor: UIColor.cbWhite]
        let title: NSMutableAttributedString = NSMutableAttributedString(string: "AWESOME & Co.", attributes: boldAttributes)
        title.addAttributes(lightAttributes, range: NSRange(location: 8, length: 5))
        label.attributedText = title
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension LoginLogoView: CodeView {
    func buildViewHierarchy() {
        
        addSubview(logoImage)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let heightConstraint = logoImage.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.identifier = "height"
        heightConstraint.isActive = true
        let widthConstraint = logoImage.widthAnchor.constraint(equalToConstant: 50)
        widthConstraint.identifier = "width"
        widthConstraint.isActive = true
        logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: .cbLineBreakMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true  
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
