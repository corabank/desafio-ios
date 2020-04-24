//
//  OrderListNavigationView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderListNavigationView: UIView {
    
    public var userName: String? {
        didSet {
            helloLabel.text = "\("order_header_hello".localized)\(userName ?? "")"
        }
    }
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "awesome-logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbWhite
        label.font = .cbRegular(14)
        label.textAlignment = .right
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

extension OrderListNavigationView: CodeView {
    func buildViewHierarchy() {
        addSubview(logoImage)
        addSubview(helloLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true

        helloLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        helloLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        helloLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        helloLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbDarkBlue
    }
}
