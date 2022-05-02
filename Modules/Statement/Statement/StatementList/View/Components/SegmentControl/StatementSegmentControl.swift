import UIKit
import Resources
import ViewCode
import Components

final class StatementSegmentControl: UIView {
    
    private weak var delegate: StatementSegmentControlDelegate?
    
    private lazy var mainStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonAll: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Tudo", for: .normal)
        button.setTitleColor(Colors.pink, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
        button.setAttributedTitle(addUnderline("Tudo"), for: .normal)
        button.addTarget(self, action: #selector(tapAll), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonIncome: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Entrada", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .regular)
        button.addTarget(self, action: #selector(tapIncome), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonOutcome: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Saída", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .regular)
        button.addTarget(self, action: #selector(tapOutcome), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonFuture: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Futuro", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .regular)
        button.addTarget(self, action: #selector(tapFuture), for: .touchUpInside)
        return button
    }()
    
    public init(title: String = "", share: Bool = false) {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    private func grayOut() {
        buttonAll.setTitleColor(Colors.mediumGray, for: .normal)
        buttonIncome.setTitleColor(Colors.mediumGray, for: .normal)
        buttonOutcome.setTitleColor(Colors.mediumGray, for: .normal)
        buttonFuture.setTitleColor(Colors.mediumGray, for: .normal)
    }
    
    private func enableAll() {
        buttonAll.isEnabled = true
        buttonIncome.isEnabled = true
        buttonOutcome.isEnabled = true
        buttonFuture.isEnabled = true
    }
    
    private func addUnderline(_ text: String?) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text ?? "", attributes: [
            .font: UIFont.systemFont(ofSize: Dimensions.fontTiny, weight: .bold),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
    }
    
    private func removeUnderline(_ text: String?) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text ?? "", attributes: [
            .font: UIFont.systemFont(ofSize: Dimensions.fontTiny, weight: .regular)
        ])
    }
    
    private func removeUnderlineFromAll() {
        buttonAll.setAttributedTitle(removeUnderline(buttonAll.titleLabel?.text), for: .normal)
        buttonIncome.setAttributedTitle(removeUnderline(buttonIncome.titleLabel?.text), for: .normal)
        buttonOutcome.setAttributedTitle(removeUnderline(buttonOutcome.titleLabel?.text), for: .normal)
        buttonFuture.setAttributedTitle(removeUnderline(buttonFuture.titleLabel?.text), for: .normal)
    }
    
    @objc
    private func tapAll() {
        grayOut()
        removeUnderlineFromAll()
        buttonAll.setTitleColor(Colors.pink, for: .normal)
        buttonAll.setAttributedTitle(addUnderline(buttonAll.titleLabel?.text), for: .normal)
        delegate?.tapAll()
    }
    
    @objc
    private func tapIncome() {
        grayOut()
        removeUnderlineFromAll()
        buttonIncome.setTitleColor(Colors.pink, for: .normal)
        buttonIncome.setAttributedTitle(addUnderline(buttonIncome.titleLabel?.text), for: .normal)
        delegate?.tapIncome()
    }
    
    @objc
    private func tapOutcome() {
        grayOut()
        removeUnderlineFromAll()
        buttonOutcome.setTitleColor(Colors.pink, for: .normal)
        buttonOutcome.setAttributedTitle(addUnderline(buttonOutcome.titleLabel?.text), for: .normal)
        delegate?.tapOutcome()
    }
    
    @objc
    private func tapFuture() {
        grayOut()
        removeUnderlineFromAll()
        buttonFuture.setAttributedTitle(addUnderline(buttonFuture.titleLabel?.text), for: .normal)
        buttonFuture.setTitleColor(Colors.pink, for: .normal)
        delegate?.tapFuture()
    }
    
    func set(delegate: StatementSegmentControlDelegate) {
        self.delegate = delegate
    }
}

extension StatementSegmentControl: ViewCode {
    func setSubviews() {
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(buttonAll)
        mainStack.addArrangedSubview(buttonIncome)
        mainStack.addArrangedSubview(buttonOutcome)
        mainStack.addArrangedSubview(buttonFuture)
    }
    
    func setConstraints() {
        mainStack.setAnchorsEqual(to: self)
        
    }
}
