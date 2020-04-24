//
//  OrderDetailNavigationView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetailNavigationView: UIView {
    
    public var onTouch: (()->Void)?
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icon-arrow-back")
        imageView.tintColor = .cbRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbRed
        label.font = .cbLight(14)
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

extension OrderDetailNavigationView: CodeView {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(arrowImage)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        arrowImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: arrowImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .lightGray
        setupGesture()
    }
    
    private func setupGesture() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        touchGesture.numberOfTouchesRequired = 1
        arrowImage.addGestureRecognizer(touchGesture)
        arrowImage.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(touchGesture)
        titleLabel.isUserInteractionEnabled = true
    }
    
    @objc public func handleTap() {
        onTouch?()
    }
}

