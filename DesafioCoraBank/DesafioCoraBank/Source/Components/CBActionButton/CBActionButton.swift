//
//  CBActionButton.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 19/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class CBActionButton: UIView {
    
    public var onTouch: (()->Void)?
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icon-arrow")
        imageView.tintColor = .cbWhite
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbWhite
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

extension CBActionButton: CodeView {
    func buildViewHierarchy() {
        
        addSubview(titleLabel)
        addSubview(arrowImage)
    }
    
    func setupConstraints() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        arrowImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        arrowImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: .cbRightMargin).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbPink
        layer.cornerRadius = .cbCornerRadius
        
        setupGesture()
    }
    
    private func setupGesture() {
        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        touchGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(touchGesture)
        isUserInteractionEnabled = true
    }
    
    @objc public func handleTap() {
        onTouch?()
    }
}
