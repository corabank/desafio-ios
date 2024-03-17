//
//  FilterBarView.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import UIKit
import Core

class FilterBarView: UIView {
    
    enum FilterBarConstants {
        static let iconSize: CGFloat = 24.0
    }
    
    //MARK: - properties
    
    var items: [String] = [] {
        didSet {
            if oldValue != items {
                updateItems()
            }
        }
    }
    
    var selectedItemIndex = 0 {
        didSet {
            updateSelectedItem(oldSelectedItem: oldValue)
        }
    }
    
    //MARK: - views
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let itemsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.defaultPadding * 1.25
        return stackView
    }()
    
    private let rightFilterIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.Extract.icFilterIcon
        imageView.heightAnchor.constraint(equalToConstant: FilterBarConstants.iconSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: FilterBarConstants.iconSize).isActive = true
        return imageView
    }()
    
    private let bottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = AppColors.primary
        return view
    }()
    
    private lazy var bottomBarLeadingAnchor = bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor)
    private lazy var bottomBarWidthAnchor = bottomBar.widthAnchor.constraint(equalToConstant: .zero)
    
    //MARK: - setup
    
    init(items: [String] = [], selectedItemIndex: Int = .zero) {
        self.items = items
        self.selectedItemIndex = selectedItemIndex
        super.init(frame: .zero)
        
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        self.items = []
        self.selectedItemIndex = .zero
        super.init(coder: coder)
        
        prepareView()
    }
    
    private func prepareView() {
        backgroundColor = .white
        addSubview(containerStackView)
        addSubview(bottomBar)
        
        containerStackView.addArrangedSubview(itemsStackView)
        containerStackView.addArrangedSubview(rightFilterIcon)
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultPadding),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.defaultPadding),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultPadding / 1.25),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultPadding / 1.25),
            
            bottomBar.topAnchor.constraint(equalTo: containerStackView.bottomAnchor),
            bottomBarLeadingAnchor,
            bottomBarWidthAnchor
        ])
        
        updateItems()
        
        DispatchQueue.main.async { [weak self] in
            self?.updateSelectedItem(oldSelectedItem: .zero)
        }
    }
    
    private func updateItems() {
        itemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        items.enumerated().forEach {
            itemsStackView.addArrangedSubview(makeItemLabel($1, index: $0))
        }
    }
    
    private func updateSelectedItem(oldSelectedItem: Int) {
        if let oldSelectedItem = itemsStackView.arrangedSubviews[oldSelectedItem] as? UILabel {
            oldSelectedItem.textColor = AppColors.textSecondaryColor
        }
        
        guard selectedItemIndex < items.count, selectedItemIndex >= 0 else {
            return
        }
        
        guard let selectedItem = itemsStackView.arrangedSubviews[selectedItemIndex] as? UILabel else {
            return
        }
        
        bottomBarLeadingAnchor.isActive = false
        bottomBarLeadingAnchor = bottomBar.leadingAnchor.constraint(equalTo: selectedItem.leadingAnchor)
        
        // another possibility is animate the translation X to provide smoothier transition
        bottomBarLeadingAnchor.isActive = true
        bottomBarWidthAnchor.constant = selectedItem.frame.width
        
        selectedItem.textColor = AppColors.primary
    }
    
    private func makeItemLabel(_ item: String, index: Int) -> UILabel {
        let label = UILabel()
        label.text = item
        label.font = .systemFont(ofSize: 14)
        label.textColor = AppColors.textSecondaryColor
        label.tag = index
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLabel)))
        return label
    }
    
    @objc
    private func didTapLabel(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view else { return }
        selectedItemIndex = view.tag
    }
}
