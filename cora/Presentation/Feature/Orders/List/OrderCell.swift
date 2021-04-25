//
//  OrderCell.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import UIKit

class OrderCell: UITableViewCell {
    private var order: Order! {
        didSet {
            configureElements()
            setConstraints()
        }
    }
    
    private var orderImage = UIImageView()
    private var orderTitle = UILabel()
    private var orderDescription = UILabel()
    private var orderStatus = UILabel()
    private var orderDate = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        if order != nil {
            self.accessibilityIdentifier = order.id.uuidString
        }
        makeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(order: Order) {
        self.order = order

        orderTitle.text = order.value.toCurrency
        orderDescription.text = order.description
        let days = order.dueDate.daysBetween(date: Date())
        orderDate.text = days == 0
            ? "today".localized
            : "\(days) " + "day".localized + "\(days != 1 ? "s" : "") " + "ago".localized
        
        switch order.status {
        case .late:
            orderStatus.text = "Not Paid".localized
        case .paid:
            orderStatus.text = "Paid".localized
        case .pending:
            orderStatus.text = "Waiting".localized
        }
    }
    
    fileprivate func makeView() {
        addSubview(orderImage)
        addSubview(orderTitle)
        addSubview(orderDescription)
        addSubview(orderStatus)
        addSubview(orderDate)
    }

    fileprivate func configureImageView() {
        orderImage.translatesAutoresizingMaskIntoConstraints = false
        orderImage.image = UIImage(named: "creditcard.circle.fill")?
            .withRenderingMode(.automatic)
        orderImage.tintColor = #colorLiteral(red: 0.2040163577, green: 0.3045359552, blue: 0.3877969384, alpha: 1)
        orderImage.contentMode = .scaleAspectFit
        orderImage.layer.opacity = 0.45
    }

    fileprivate func configureTitleLabel() {
        orderTitle.translatesAutoresizingMaskIntoConstraints = false
        orderTitle.numberOfLines = 0
        orderTitle.adjustsFontSizeToFitWidth = true
        orderTitle.textColor = #colorLiteral(red: 0.1580600441, green: 0.1580889821, blue: 0.1580537558, alpha: 1)
        orderTitle.font = UIFont.boldSystemFont(ofSize: 16.dp)
    }

    fileprivate func configureDescriptionLabel() {
        orderDescription.translatesAutoresizingMaskIntoConstraints = false
        orderDescription.numberOfLines = 0
        orderDescription.adjustsFontSizeToFitWidth = true
        orderDescription.textColor = #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1)
        orderDescription.font = UIFont.systemFont(ofSize: 11.dp)
    }

    fileprivate func configureStatusLabel() {
        orderStatus.translatesAutoresizingMaskIntoConstraints = false
        orderStatus.numberOfLines = 0
        orderStatus.adjustsFontSizeToFitWidth = true
        orderStatus.font = UIFont.systemFont(ofSize: 12.dp)
        
        switch order.status {
        case .late:
            orderStatus.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .paid:
            orderStatus.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .pending:
            orderStatus.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
    }

    fileprivate func configureDateLabel() {
        orderDate.translatesAutoresizingMaskIntoConstraints = false
        orderDate.numberOfLines = 0
        orderDate.adjustsFontSizeToFitWidth = true
        orderDate.textColor = #colorLiteral(red: 0.4481066465, green: 0.4479940534, blue: 0.4521933794, alpha: 1)
        orderDate.font = UIFont.systemFont(ofSize: 10.dp)
    }

    fileprivate func configureElements() {
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStatusLabel()
        configureDateLabel()
    }

    /// Set Constraints
    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            /// orderImage constraints
            orderImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            orderImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.dp),
            orderImage.heightAnchor.constraint(equalToConstant: 40.dp),
            orderImage.widthAnchor.constraint(equalTo: orderImage.heightAnchor),

            /// orderTitle constraints
            orderTitle.leftAnchor.constraint(equalTo: orderImage.rightAnchor, constant: 20.dp),
            orderTitle.topAnchor.constraint(equalTo: topAnchor, constant: 13.5.dp),
            
            /// orderDescription ocnstraints
            orderDescription.leftAnchor.constraint(equalTo: orderImage.rightAnchor, constant: 20.dp),
            orderDescription.topAnchor.constraint(equalTo: orderTitle.bottomAnchor, constant: 4.dp),
            
            /// orderStatus constraints
            orderStatus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.dp),
            orderStatus.topAnchor.constraint(equalTo: topAnchor, constant: 12.dp),
            
            /// orderDate constraints
            orderDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.dp),
            orderDate.topAnchor.constraint(equalTo: orderTitle.bottomAnchor, constant: 4.dp)
        ])
    }
}
