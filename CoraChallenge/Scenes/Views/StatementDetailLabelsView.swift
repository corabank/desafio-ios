//
//  StatementDetailLabelsView.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/26/22.
//

import UIKit

enum DetailsLabelType {
    case full
    case partial
}

class StatementDetailLabelsView: UIView {
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstLabel, messageLabel, documentLabel, bankNameLabel, agencyAccountLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraBlack
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = .coraBlack
        return label
    }()
    
    lazy var documentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraDarkGray
        return label
    }()
    
    lazy var bankNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraDarkGray
        return label
    }()
    
    lazy var agencyAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraDarkGray
        return label
    }()
    
    var labelType: DetailsLabelType? {
        didSet {
            switch labelType {
            case .full:
                self.documentLabel.isHidden = false
                self.bankNameLabel.isHidden = false
                self.agencyAccountLabel.isHidden = false
            case .partial:
                self.documentLabel.isHidden = true
                self.bankNameLabel.isHidden = true
                self.agencyAccountLabel.isHidden = true
            case .none:
                return
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatementDetailLabelsView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(mainStack)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func viewCodeAditionalSetup() {
        backgroundColor = .white
    }
}
