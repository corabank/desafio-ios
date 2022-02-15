//
//  ProductListCollectionView.swift
//  desafio-ios
//
//  Created by Barbara Barone on 11/02/22.
//

import Foundation
import SnapKit
import UIKit

final class ProductListCollectionViewCell: UICollectionViewCell {
    private enum Layout {
        enum Cell {
            static let identifier = "ProductListCollectionViewCell"
        }
        enum Size {
            static let imageSize = CGSize(width: 40, height: 40)
        }
    }
    static let identifier = Layout.Cell.identifier
    static let size = Layout.Size.imageSize
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Strings.Image.spiderLogo))
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base03, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base02, weight: .medium)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base01, weight: .regular)
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LayoutSize.Stack.spacing00
        stackView.alignment = .leading
        stackView.contentMode = .scaleAspectFit
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func setup(_ item: ProductItem) {
        valueLabel.text = item.value.formatCurrency()
        descriptionLabel.text = item.description
        dateLabel.text = item.date
    }
}

extension ProductListCollectionViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(productImage)
        addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(valueLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        addSubview(dateLabel)
    }
    
    func setupConstraints() {
        productImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(LayoutSize.View.base00)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(labelsStackView.snp.leading).offset(-LayoutSize.View.base00)
            $0.size.equalTo(Layout.Size.imageSize)
        }
        
        labelsStackView.snp.makeConstraints {
            $0.centerY.equalTo(productImage)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-LayoutSize.View.base00)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}
