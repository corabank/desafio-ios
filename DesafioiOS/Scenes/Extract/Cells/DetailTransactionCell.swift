//
//  DetailTransactionCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 29/05/22.
//

import UIKit

final class DetailTransactionCell: UITableViewCell {
    
    static let identifier = String(describing: DetailTransactionCell.self)
    var model: Model?
    
    var imageTransaction: UIImageView = {
        let image = UIImage()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var valueTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .bold, color: CoraColor.secondary)
        label.numberOfLines = .zero
        return label
    }()
    
    var typeTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: CoraColor.offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    var nameTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: CoraColor.gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    var hourTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .caption, fontWeight: .regular, color: CoraColor.gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .coraColor(.offBlack)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setColor()  {
        switch model?.type {
        case .entry:
            imageTransaction.setImageColor(color: .coraColor(.secondary))
            valueTransactionLabel.textColor = .coraColor(.secondary)
            typeTransactionLabel.textColor = .coraColor(.secondary)
            lineView.isHidden = true
        case .output:
            imageTransaction.setImageColor(color: .coraColor(.offBlack))
            valueTransactionLabel.textColor = .coraColor(.offBlack)
            typeTransactionLabel.textColor = .coraColor(.offBlack)
            lineView.isHidden = true
        case .refund:
            imageTransaction.setImageColor(color: .coraColor(.offBlack))
            valueTransactionLabel.textColor = .coraColor(.offBlack)
            typeTransactionLabel.textColor = .coraColor(.offBlack)
            lineView.isHidden = false
        case .none:
            break
        }
    }

    func setup(model: Model) {
        self.model = model
        self.imageTransaction.image =  model.image
        self.valueTransactionLabel.text = model.value
        self.typeTransactionLabel.text = model.description
        self.nameTransactionLabel.text = model.name
        self.hourTransactionLabel.text = model.time
        setupView()
        setColor()
    }
}

extension DetailTransactionCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(imageTransaction)
        addSubview(valueTransactionLabel)
        addSubview(typeTransactionLabel)
        addSubview(nameTransactionLabel)
        addSubview(hourTransactionLabel)
        addSubview(lineView)
    }
    
    func setupConstraints() {
        [lineView, imageTransaction, valueTransactionLabel, typeTransactionLabel, nameTransactionLabel, hourTransactionLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            /// ImageTransaction
            imageTransaction.topAnchor.constraint(equalTo: topAnchor, constant: model?.isFirst == true ? .coraSpacing(.base07) : .coraSpacing(.base04)),
            imageTransaction.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            
            /// ValueTransaction
            valueTransactionLabel.topAnchor.constraint(equalTo: topAnchor, constant: model?.isFirst == true ? .coraSpacing(.base07) : .coraSpacing(.base04)),
            valueTransactionLabel.leadingAnchor.constraint(equalTo: imageTransaction.trailingAnchor, constant: .coraSpacing(.base05)),
            
            /// TyoeTransaction
            typeTransactionLabel.topAnchor.constraint(equalTo: valueTransactionLabel.bottomAnchor, constant: .coraSpacing(.base01)),
            typeTransactionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base12)),
            
            /// NameTransaction
            nameTransactionLabel.topAnchor.constraint(equalTo: typeTransactionLabel.bottomAnchor, constant: .coraSpacing(.base01)),
            nameTransactionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base12)),
            nameTransactionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: model?.isLast == true ? -.coraSpacing(.base07) : -.coraSpacing(.base04)),
            
            /// HourTransaction
            hourTransactionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            hourTransactionLabel.topAnchor.constraint(equalTo: topAnchor, constant: .coraSpacing(.base09)),
            
            /// LineView
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalTo: valueTransactionLabel.widthAnchor),
            lineView.centerYAnchor.constraint(equalTo: valueTransactionLabel.centerYAnchor),
            lineView.centerXAnchor.constraint(equalTo: valueTransactionLabel.centerXAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .coraColor(.white)
        selectionStyle = .none
    }
}

extension DetailTransactionCell {
    struct Model {
        var image: UIImage?
        var value: String?
        var name: String?
        var type: TransactionType?
        var time: String?
        var description: String?
        var isLast: Bool
        var isFirst: Bool
    }
}
