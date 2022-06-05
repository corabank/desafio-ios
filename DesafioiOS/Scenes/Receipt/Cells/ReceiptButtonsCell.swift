//
//  ReceiptButtonsCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import UIKit

protocol ReceiptButtonsCellDelegate: AnyObject {
    func sharedReceipt()
    func cancelScheduling()
}

final class ReceiptButtonsCell: UITableViewCell {
    typealias Strings = Localization.ReceiptButtonsCell

    static let identifier = String(describing: ReceiptButtonsCell.self)
    weak var delegate: ReceiptButtonsCellDelegate?
    
    private lazy var shareReceipt: CoraButton = {
        let button = CoraButton()
        let icon = Asset.shareIos.image
        button.render(.fill(.init(style: .primary(isLight: false),
                                  icon: icon,
                                  title: Strings.shareReceipt)))
        button.addTarget(self, action: #selector(didTapSharedReceipt), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelScheduling: CoraButton = {
        let button = CoraButton()
        button.render(.fill(.init(style: .ghost,
                                  icon: nil,
                                  title: Strings.cancelScheduling)))
        button.addTarget(self, action: #selector(didTapCancelScheduling), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}

extension ReceiptButtonsCell: ViewCode {
    
    func buildViewHierarchy() {
        contentView.addSubview(shareReceipt)
        contentView.addSubview(cancelScheduling)
    }
    
    func setupConstraints() {
        shareReceipt.translatesAutoresizingMaskIntoConstraints = false
        cancelScheduling.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// Button shared receipt
            shareReceipt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .coraSpacing(.base07)),
            shareReceipt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.coraSpacing(.base07)),
            shareReceipt.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .coraSpacing(.base07)),
            
            /// Button cancel scheduling
            cancelScheduling.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .coraSpacing(.base07)),
            cancelScheduling.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.coraSpacing(.base07)),
            cancelScheduling.topAnchor.constraint(equalTo: shareReceipt.bottomAnchor, constant: .coraSpacing(.base07)),
            cancelScheduling.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.coraSpacing(.base07))
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

@objc
extension ReceiptButtonsCell {
    func didTapSharedReceipt() {
        delegate?.sharedReceipt()
    }
    
    func didTapCancelScheduling() {
        delegate?.cancelScheduling()
    }
}
