//
//  ExtractHeaderTable.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 21/03/22.
//

import Foundation
import UIKit

class ExtractHeaderTable: UIView {
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        return dateLabel
    }()
    
    lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        return valueLabel
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
        backgroundColor = .grayHeader
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dateLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 1.50),
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 0.30)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            valueLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor)
        ])
    }
}
