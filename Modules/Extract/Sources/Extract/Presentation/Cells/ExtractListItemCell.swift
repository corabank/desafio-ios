//
//  ExtractListItemCell.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import UIKit
import Core

class ExtractListItemCell: UITableViewCell {
    static let identifier = "ExtractListItemCell"
    
    struct ExtractListItemCellConstants {
        static let leftImageViewSize: CGFloat = 24.0
    }
    
    //MARK: - properties
    
    private(set) var item: ExtractItem!
    
    //MARK: - views
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: ExtractListItemCellConstants.leftImageViewSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: ExtractListItemCellConstants.leftImageViewSize).isActive = true
        return imageView
    }()
    
    private let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let transferTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let personLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()

    //MARK: - setup
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        addSubview(container)
        container.addSubview(leftImageView)
        container.addSubview(textsStackView)
        container.addSubview(hourLabel)
        
        textsStackView.addArrangedSubview(valueLabel)
        textsStackView.addArrangedSubview(transferTypeLabel)
        textsStackView.addArrangedSubview(personLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            leftImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.defaultPadding),
            leftImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.defaultPadding),
            
            textsStackView.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: Constants.defaultPadding / 1.25),
            textsStackView.topAnchor.constraint(equalTo: leftImageView.topAnchor),
            textsStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.defaultPadding),
            
            hourLabel
                .trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.defaultPadding),
            hourLabel.leadingAnchor.constraint(equalTo: textsStackView.trailingAnchor, constant: Constants.defaultPadding),
            hourLabel.centerYAnchor.constraint(equalTo: textsStackView.centerYAnchor)
        ])
    }
    
    func prepare(item: ExtractItem) 
    {
        self.item = item
        
        leftImageView.image = item.leftIcon
        valueLabel.text = item.amount.asCurrency
        transferTypeLabel.text = item.label
        personLabel.text = item.name
        hourLabel.text = item.dateEvent.asDate()
        
        valueLabel.textColor = item.textColor
        transferTypeLabel.textColor = item.textColor
        hideShimmerAnimation()
    }
    
    func showShimmerAnimation() {
        leftImageView.image = Images.Extract.arrowDownIn
        valueLabel.text = "dummy text"
        transferTypeLabel.text = "dummy text"
        personLabel.text = "dummy text"
        
        hourLabel.isHidden = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            leftImageView.startShimmeringAnimation()
            textsStackView.startShimmeringAnimation()
        }
    }
    
    private func hideShimmerAnimation() {
        hourLabel.isHidden = false
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            leftImageView.stopShimmeringAnimation()
            textsStackView.stopShimmeringAnimation()
        }
    }
}
