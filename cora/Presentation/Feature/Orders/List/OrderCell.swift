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
            ? "hoje"
            : "\(days) dia\(days != 1 ? "s" : "") atrás"
        
        switch order.status {
        case .late:
            orderStatus.text = "Não Pago"
        case .paid:
            orderStatus.text = "Pago"
        case .pending:
            orderStatus.text = "Aguardando"
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
        orderImage.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        orderImage.contentMode = .scaleAspectFit
    }

    fileprivate func configureTitleLabel() {
        orderTitle.translatesAutoresizingMaskIntoConstraints = false
        orderTitle.numberOfLines = 0
        orderTitle.adjustsFontSizeToFitWidth = true
        orderTitle.textColor = #colorLiteral(red: 0.1580600441, green: 0.1580889821, blue: 0.1580537558, alpha: 1)
        orderTitle.font = UIFont.boldSystemFont(ofSize: 16)
    }

    fileprivate func configureDescriptionLabel() {
        orderDescription.translatesAutoresizingMaskIntoConstraints = false
        orderDescription.numberOfLines = 0
        orderDescription.adjustsFontSizeToFitWidth = true
        orderDescription.textColor = #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1)
        orderDescription.font = UIFont.systemFont(ofSize: 11)
    }

    fileprivate func configureStatusLabel() {
        orderStatus.translatesAutoresizingMaskIntoConstraints = false
        orderStatus.numberOfLines = 0
        orderStatus.adjustsFontSizeToFitWidth = true
        orderStatus.font = UIFont.systemFont(ofSize: 12)
        
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
        orderDate.font = UIFont.systemFont(ofSize: 10)
    }

    fileprivate func configureElements() {
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStatusLabel()
        configureDateLabel()
    }

    fileprivate func setConstraints() {
        NSLayoutConstraint.activate([
            // image
            orderImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            orderImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            orderImage.heightAnchor.constraint(equalToConstant: 40),
            orderImage.widthAnchor.constraint(equalTo: orderImage.heightAnchor),

            // title
            orderTitle.leftAnchor.constraint(equalTo: orderImage.rightAnchor, constant: 20),
            orderTitle.topAnchor.constraint(equalTo: topAnchor, constant: 13.5),
            
            // description
            orderDescription.leftAnchor.constraint(equalTo: orderImage.rightAnchor, constant: 20),
            orderDescription.topAnchor.constraint(equalTo: orderTitle.bottomAnchor, constant: 4),
            
            // status
            orderStatus.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            orderStatus.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
            // date
            orderDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            orderDate.topAnchor.constraint(equalTo: orderTitle.bottomAnchor, constant: 4)
        ])
    }
}

extension UIImage {
  func resized(to newSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    defer { UIGraphicsEndImageContext() }

    draw(in: CGRect(origin: .zero, size: newSize))
    return UIGraphicsGetImageFromCurrentImageContext()
  }
}
