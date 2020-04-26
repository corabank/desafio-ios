//
//  OrderDetailView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 25/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetailView: UIView {
    
    public let navigationView = OrderDetailNavigationView()
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    public var loading = CBLoading()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension OrderDetailView: CodeView {
    func buildViewHierarchy() {
        addSubview(navigationView)
        addSubview(stackView)
        addSubview(loading)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        navigationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        navigationView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0).isActive = true
        
        loading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        loading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        loading.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0).isActive = true
        loading.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        navigationView.title = "order_header_back".localized
        stackView.backgroundColor = .cbWhite
        loading.isHidden = true
    }
}
