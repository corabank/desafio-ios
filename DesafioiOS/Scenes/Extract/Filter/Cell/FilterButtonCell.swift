//
//  ButtonCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 30/05/22.
//

import UIKit

final class FilterButtonCell: UICollectionViewCell {
    
    static let identifier = String(describing: FilterButtonCell.self)
    
    lazy var button: CoraButton = {
        let button = CoraButton()
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .coraColor(.primary)
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override var isSelected: Bool {
        didSet {
            let color: CoraColor = isSelected ? .primary : .gray1
            line.isHidden = !isSelected
            button.setTitleColor(.coraColor(color), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func fill(title: String) {
        button.render(.fill(.init(style: .ghost, icon: nil, title: title)))
        button.setTitleColor(.coraColor(.gray1), for: .normal)
        line.isHidden = true
    }
}

extension FilterButtonCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(button)
        addSubview(line)
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Filter Button
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: .coraSpacing(.base11)),
            
            // Line Button
            line.heightAnchor.constraint(equalToConstant: .coraSpacing(.base00)),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.coraSpacing(.base06))
        ])
    }
}
