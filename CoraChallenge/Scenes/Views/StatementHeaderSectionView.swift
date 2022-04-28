//
//  StatementHeaderSection.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/25/22.
//

import UIKit

class StatementHeaderSectionView: UIView {
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, valueLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 12)
        label.textColor = .coraDarkGray
        label.text = "Hoje - 6 de Agosto"
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        label.textColor = .coraDarkGray
        label.text = "R$ 1.935,50"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewCodeSetup()
        backgroundColor = .coraMediumGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StatementHeaderSectionView: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        addSubview(mainStack)
    }
    
    func setupHeader(data: String) {
        let strArray = data.components(separatedBy: "|")
        let date = strArray[0].formatStringDate(withFormat: "dd/MM/yyyy")
        let value = strArray[1]
        
        self.dateLabel.text = String(describing: date)
        self.valueLabel.text = Double(value)?.doubleToCurrency()
    }
    
    func viewCodeConstraintSetup() {
        let padding: CGFloat = 24
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
