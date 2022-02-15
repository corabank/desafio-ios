//
//  HomeViewController.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import SnapKit
import UIKit

protocol HomeDisplaying: AnyObject {
    func set(products: [ProductItem])
}

private extension HomeViewController.Layout {
    enum Size {
        static let imageSize = CGSize(width: 60, height: 60)
    }
}

final class HomeViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var ironmanImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: Strings.Image.ironmanFace))
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var salutationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base03, weight: .light)
        label.text = Strings.CommonMessage.salutationMessage
        return label
    }()
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base04, weight: .bold)
        label.text = Strings.CommonMessage.ordersMessage
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = UIFont.systemFont(ofSize: LayoutSize.FontSize.base01, weight: .regular)
        label.text = Strings.CommonMessage.descriptionMessage
        return label
    }()
    
    private lazy var listProductsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: ProductListCollectionViewCell.identifier)
        collection.layer.cornerRadius = LayoutSize.Stack.spacing00
        return collection
    }()
    
    private let interactor: HomeInteracting
    private var products: [ProductItem] = []
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationItem()
        buildLayout()
        interactor.load()
    }
}

extension HomeViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(ironmanImage)
        view.addSubview(salutationLabel)
        view.addSubview(orderLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(listProductsCollection)
    }
    
    func setupConstraints() {
        ironmanImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(LayoutSize.View.base0X)
            $0.leading.equalToSuperview().offset(LayoutSize.View.base00)
            $0.size.equalTo(Layout.Size.imageSize)
        }
        
        salutationLabel.snp.makeConstraints {
            $0.centerY.equalTo(ironmanImage)
            $0.trailing.equalToSuperview().offset(-LayoutSize.View.base01)
        }
        
        orderLabel.snp.makeConstraints {
            $0.top.equalTo(ironmanImage.snp.bottom).offset(LayoutSize.View.base01)
            $0.leading.equalToSuperview().offset(LayoutSize.View.base00)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(orderLabel.snp.bottom).offset(LayoutSize.View.base0x)
            $0.leading.trailing.equalToSuperview().inset(LayoutSize.View.base00)
        }
        
        listProductsCollection.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(LayoutSize.View.base01)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func configureViews() {
        view.backgroundColor = .systemGray4
    }
    
    func hideNavigationItem() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: LayoutSize.View.base04)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.identifier, for: indexPath) as? ProductListCollectionViewCell else { return UICollectionViewCell() }
        cell.setup(products[indexPath.row])
        return cell
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    func set(products: [ProductItem]) {
        self.products = products
    }
}
