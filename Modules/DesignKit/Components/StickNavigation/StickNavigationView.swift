//
//  StickNavigationView.swift
//  DesignKit
//
//  Created by Erik Santos on 13/03/24.
//

import UIKit
import CoreKit

public protocol StickNavigationViewDelegate: AnyObject {
    func didTapLeftButton()
}

public class StickNavigationView: UIView {
    
    public var delegate: StickNavigationViewDelegate?
    
    // MARK: -  Properties

    private var viewModel: StickNavigationViewModelProtocol?
    
    private lazy var leftButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    public override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width, height: LayoutHelper.shared.getSafeTopAreaHeight())
    }
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    
    public static func instantiate(viewModel: StickNavigationViewModelProtocol) -> StickNavigationView {
       return setup(viewModel)
    }
    
    public func setViewModel(_ viewModel: StickNavigationViewModelProtocol) {
        self.viewModel = viewModel
        resetView()
        buildComponent()
    }
    
    public func updateTitle(_ text: String) {
        self.viewModel?.title.text = text
    }
    
    // MARK: - Private methods
    
    private static func setup(_ viewModel: StickNavigationViewModelProtocol) -> StickNavigationView {
        let component = StickNavigationView()
        component.setViewModel(viewModel)
        return component
    }
    
    private func buildComponent() {
        seupTitle()
        setupLeftButton()
        backgroundColor = viewModel?.backgroundColor
    }
    
    private func setupLeftButton() {
        guard let viewModel = viewModel else { return }
        if let leftButtonImage = viewModel.leftButton {
            addSubview(self.leftButton)
            NSLayoutConstraint.activate([
                leftButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
                leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                leftButton.heightAnchor.constraint(equalToConstant: 24),
                leftButton.widthAnchor.constraint(equalToConstant: 15)
            ])
            
            leftButton.image = leftButtonImage.image
            leftButton.tintColor = leftButtonImage.color
            leftButton.isUserInteractionEnabled = true
            leftButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapLeftButton)))
        }
    }
    
    private func seupTitle() {
        addSubview(title)
        NSLayoutConstraint.activate([
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        title.font = viewModel?.title.font
        title.textColor = viewModel?.title.color
        title.text = viewModel?.title.text
    }
    
    private func resetView() {
        subviews.forEach { view in
            view.removeFromSuperview()
        }
        
    }
    
    @objc
    private func didTapLeftButton() {
        delegate?.didTapLeftButton()
    }
}
