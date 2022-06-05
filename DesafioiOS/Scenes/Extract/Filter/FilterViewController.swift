//
//  FilterViewController.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 30/05/22.
//

import UIKit

public protocol FilterViewControllerDelegate: AnyObject {
    func didTapFilter(type: FilterType)
}

public enum FilterType: String, CaseIterable {
    case all = "Tudo"
    case entry = "Entrada"
    case output = "Saída"
    case future = "Futuro"
}

final class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    private lazy var filterButton: CoraButton = {
        let button = CoraButton()
        let icon = Asset.filter.image.paintImage(color: .primary)
        button.render(.fill(.init(style: .ghost, icon: icon, title: String())))
        return button
    }()
    
    private lazy var filterStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: FilterButtonCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 24.0, bottom: 0, right: 24.0)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UIScreen.main.sizeType == .iPhone5 ? 24.0 : 32.0
        layout.minimumInteritemSpacing = UIScreen.main.sizeType == .iPhone5 ? 24.0 : 32.0
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
}

extension FilterViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(filterStackView)
        filterStackView.addArrangedSubview(collectionView)
        filterStackView.addArrangedSubview(filterButton)
    }
    
    func setupConstraints() {
        filterStackView.translatesAutoresizingMaskIntoConstraints = false
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //Filter Transactions
            filterStackView.topAnchor.constraint(equalTo: view.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Filter button
            filterButton.heightAnchor.constraint(equalToConstant: .coraSpacing(.base11)),
            filterButton.widthAnchor.constraint(equalToConstant: .coraSpacing(.base07))
        ])
    }
}

extension FilterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterButtonCell", for: indexPath) as? FilterButtonCell
        let title = FilterType.allCases[indexPath.row]
        cell?.fill(title: title.rawValue)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapFilter(type: FilterType.allCases[indexPath.row])
    }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = FilterType.allCases[indexPath.row].rawValue.width(withConstrainedHeight: 56.0, font: .systemFont(ofSize: .coraFont(.body2)))
        return .init(width: width, height: 56.0)
    }
}
