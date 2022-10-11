import Foundation
import UIKit
import Components
import Resources
import ViewCode

final class TitleDescSection: UIView {
    
    private lazy var stack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = Colors.black
        label.font = UIFont.systemFont(ofSize: Dimensions.fontSmall, weight: .bold)
        return label
    }()
    

    required init?(coder: NSCoder) { return nil }
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    func set(title: String, desc: String, plain: Bool = false) {
        self.titleLabel.text = title
        self.descLabel.text = desc
        
        if (plain) {
            descLabel.textColor = Colors.darkGray
            descLabel.font = UIFont.systemFont(ofSize: Dimensions.fontTiny)
        }
    }
}

extension TitleDescSection: ViewCode {
    func setSubviews() {
        self.addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descLabel)
    }
    
    func setConstraints() {
        stack.setAnchorsEqual(to: self)
        titleLabel.setWidthEqual(to: stack)
        titleLabel.size(height: 20)
        descLabel.setWidthEqual(to: stack)
        //descLabel.size(height: Dimensions.medium)
    }
}
