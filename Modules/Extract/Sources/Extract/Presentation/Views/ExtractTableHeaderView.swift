//
//  ExtractTableHeaderView.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import UIKit
import Core

class ExtractTableHeaderView: UIView {
    
    private enum ViewConstants {
        static let vPadding: CGFloat = 6.0
    }

    //MARK: - properties
    
    private let dateString: String
    
    //MARK: - views
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.textSecondaryColor
        return label
    }()
    
    //MARK: - setup
    
    init(dateString: String) {
        self.dateString = dateString
        super.init(frame: .zero)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        backgroundColor = AppColors.navigationBarBackground
        addSubview(textLabel)
        
        textLabel.text = dateString
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultPadding),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultPadding),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.vPadding),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.vPadding)
        ])
    }

}
