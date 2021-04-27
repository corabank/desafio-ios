//
//  LoginHeaderView.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

class LoginHeaderview: UIView {
    var userNameLabel: UILabel!
    var ordersLabel: UILabel!
    var ordersAmountLabel: UILabel!
    var userName: String
    var ordersSum: String
    var ordersDescription: String
    
    init(userName: String, ordersSum: String, ordersDescription: String) {
        self.userName = userName
        self.ordersSum = ordersSum
        self.ordersDescription = ordersDescription
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeView() {
        userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = "Hello".localized + ", \(userName)"
        userNameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userNameLabel.font = UIFont.systemFont(ofSize: 14.dp)
        userNameLabel.textAlignment = .right
        userNameLabel.accessibilityIdentifier = "userNameLabel"
        self.addSubview(userNameLabel)
        
        ordersLabel = UILabel()
        ordersLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersLabel.text = "Orders".localized
        ordersLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ordersLabel.font = UIFont.boldSystemFont(ofSize: 22.dp)
        ordersLabel.textAlignment = .left
        self.addSubview(ordersLabel)
        
        ordersAmountLabel = UILabel()
        ordersAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        ordersAmountLabel.text = "\(ordersSum) "
            + "orders".localized
            + ", " + "totaling".localized
            + " \(ordersDescription)"
        ordersAmountLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ordersAmountLabel.font = UIFont.systemFont(ofSize: 14.dp)
        ordersAmountLabel.textAlignment = .left
        self.addSubview(ordersAmountLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 20.dp),
            userNameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20.dp),
            
            ordersLabel.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 80.dp),
            ordersLabel.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: 10.dp),

            ordersAmountLabel.topAnchor.constraint(equalTo: ordersLabel.bottomAnchor, constant: 5.dp),
            ordersAmountLabel.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: 10.dp)
        ])
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeView()

        if self.superview != nil {
            setConstraints()
        }
    }
}
