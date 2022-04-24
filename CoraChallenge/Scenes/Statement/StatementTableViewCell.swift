//
//  StatementTableViewCell.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/23/22.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icon, labelStack, hourLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.contentMode = .scaleAspectFit
        return stackView
    }()
    
    lazy var icon: UIImageView = {
       let icon = UIImageView(image: UIImage(named: "ic_eye-hidden"))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.contentMode = .center
        return icon
    }()
    
    lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, statusLabel, institutionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.contentMode = .scaleAspectFit
        return stackView
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 123,12"
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transferência Recebida"
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        return label
    }()
    
    lazy var institutionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fellipe Ricciardi Chiarello"
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        return label
    }()
    
    lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "17:48"
        label.font = UIFont(name: "Avenir-Roman", size: 12)
        label.widthAnchor.constraint(equalToConstant: 32).isActive = true
        label.contentMode = .center
        return label
    }()
    
    static let cellId = "StatementTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementTableViewCell: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(mainStack)
    }
    
    func viewCodeConstraintSetup() {
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func viewCodeAditionalSetup() {
        backgroundColor = .coraBackgroundWhite
    }
}
