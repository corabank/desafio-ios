//
//  ButtonView.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit

public class ButtonView: UIView {
    //MARK: - enums
    
    public enum Style {
        case primary, primaryWhite, secondary
    }
    
    public enum State {
        case normal, inactive
    }
    
    public enum Size {
        case medium, big
    }
    
    enum ButtonConstants {
        static let rightImageSize = 24.0
        static let vPadding: CGFloat = 20.0
        static let hPadding: CGFloat = 24.0
    }
    
    //MARK: - properties

    public var text: String = "" {
        didSet { updateStyle() }
    }
    
    public var image: UIImage? {
        didSet { updateStyle() }
    }
    
    public var style: Style = .primary {
        didSet { updateStyle() }
    }
    
    public var state: State = .normal {
        didSet { updateStyle() }
    }
    
    public var size: Size = .medium {
        didSet { updateStyle() }
    }
    
    public var didTapButton: (() -> Void)?
    
    //MARK: - views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: ButtonConstants.rightImageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: ButtonConstants.rightImageSize).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var widthConstaint = widthAnchor.constraint(equalToConstant: .zero)
    private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: .zero)
    private lazy var imageViewLeadingAnchor = rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero)

    
    //MARK: - setup
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        prepareView()
     }
    
    private func prepareView() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
        
        clipsToBounds = true
        widthConstaint.isActive = true
        heightConstraint.isActive = true
        
        addSubview(titleLabel)
        addSubview(rightImageView)
         
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ButtonConstants.hPadding),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: ButtonConstants.vPadding),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -ButtonConstants.vPadding),

            imageViewLeadingAnchor,
            rightImageView.topAnchor.constraint(equalTo: topAnchor, constant: ButtonConstants.vPadding),
            rightImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ButtonConstants.vPadding),
            rightImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: ButtonConstants.hPadding)
        ])
        
        updateStyle()
    }
    
    private func updateStyle() {
        isUserInteractionEnabled = state == .normal
        layer.cornerRadius = size.cornerRadius

        rightImageView.image = image
        imageViewLeadingAnchor.constant = image == nil ? .zero : -(ButtonConstants.hPadding - 4)
        
        titleLabel.text = text
        titleLabel.textAlignment = style.textAlignment

        widthConstaint.constant = size.frame.width
        heightConstraint.constant = size.frame.height
        
        titleLabel.textColor = style.textColor
                
        UIView.animate(withDuration: 0.3) {
            if let newBackgroundColor = self.state.secondaryBackgroundColor {
                self.backgroundColor = newBackgroundColor
            } else {
                self.backgroundColor = self.style.backgroundColor
            }
        }
    }
    
    @objc
    private func didTapView() {
        tapAnimation(didTapButton)
        
    }
    
    func tapAnimation(_ completionHandler: (() -> Void)?) {
        isUserInteractionEnabled = false
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
            }
        ) {  (done) in
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: .curveLinear,
                animations: { [weak self] in
                    self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }
            ) { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completionHandler?()
            }
        }
    }
}

//MARK: - style properties

extension ButtonView.Style {
    var backgroundColor: UIColor {
        switch self {
        case .primary:
            return AppColors.primary
        case .primaryWhite:
            return AppColors.secondary
        case .secondary:
            return .clear
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .primary, .secondary:
            return AppColors.secondary
        case .primaryWhite:
            return AppColors.primary
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .primary, .primaryWhite:
            return .natural
        case .secondary:
            return .center
        }
    }
}


//MARK: - State properties

extension ButtonView.State {
    // Determines if the button has a background color that should be used when in this state
    var secondaryBackgroundColor: UIColor? {
        switch self {
        case .normal:
            return nil
        case .inactive:
            return AppColors.deactivatedBackground
        }
    }
}


//MARK: - Size properties

extension ButtonView.Size {
    var frame: CGSize {
        switch self {
        case .medium:
            return .init(width: 327, height: 48)
        case .big:
            return .init(width: 327, height: 64)
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .medium:
            return 12
        case .big:
            return 16
        }
    }
}
