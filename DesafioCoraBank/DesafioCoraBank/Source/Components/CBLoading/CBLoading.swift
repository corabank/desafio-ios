//
//  CBLoading.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class CBLoading: UIView {
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .cbLightBlue
        loading.startAnimating()
        return loading
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension CBLoading: CodeView {
    func buildViewHierarchy() {
        addSubview(loadingView)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.cbBlack.withAlphaComponent(0.2)
    }
}
