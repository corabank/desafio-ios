//
//  ReceiptStatusCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import UIKit

final class ReceiptStatusCell: UITableViewCell {
    static let identifier = String(describing: ReceiptStatusCell.self)
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [statusImage, statusTitleLabel])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 11.0
        return stackView
    }()
    
    private var statusTitleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .bold, color: .offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    private var statusImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.contentMode = .scaleAspectFill
        return headerImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setup(statusIcon: String?, statusTitle: String?) {
        self.statusImage.image = UIImage(named: statusIcon ?? String())
        self.statusTitleLabel.text = statusTitle
    }
}
                                         
extension ReceiptStatusCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(headerStackView)
    }
    
    func setupConstraints() {
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// Header Title
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            headerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: .coraSpacing(.base08)),
            
            /// Image
            statusImage.heightAnchor.constraint(equalToConstant: .coraSpacing(.base07)),
            statusImage.widthAnchor.constraint(equalToConstant: .coraSpacing(.base07))
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
