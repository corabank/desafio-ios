import UIKit
import Resources
import ViewCode
import Components

final class StatementSegmentControl: UIView {
    
    private var delegate: StatementSegmentControlDelegate?
    
    private lazy var mainStack: UIStackView = {
        let stack: UIStackView = UIStackView(frame: .zero)
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var lineAll: UIView = UIView()
    private lazy var buttonAll: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Tudo", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
        button.addTarget(self, action: #selector(tapAll), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineIncome: UIView = UIView()
    private lazy var buttonIncome: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Entrada", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
        button.addTarget(self, action: #selector(tapIncome), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineOutcome: UIView = UIView()
    private lazy var buttonOutcome: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Saída", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
        button.addTarget(self, action: #selector(tapOutcome), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineFuture: UIView = UIView()
    private lazy var buttonFuture: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("Futuro", for: .normal)
        button.setTitleColor(Colors.mediumGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
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
    
    @objc
    private func tapAll() {
        grayOut()
        buttonAll.setTitleColor(Colors.pink, for: .normal)
        buttonAll.titleLabel?.font = .systemFont(ofSize: Dimensions.fontTiny, weight: .bold)
        delegate?.tapAll()
    }
    
    @objc
    private func tapIncome() {
        grayOut()
        buttonIncome.setTitleColor(Colors.pink, for: .normal)
        delegate?.tapIncome()
    }
    
    @objc
    private func tapOutcome() {
        grayOut()
        buttonOutcome.setTitleColor(Colors.pink, for: .normal)
        delegate?.tapOutcome()
    }
    
    @objc
    private func tapFuture() {
        grayOut()
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
//        buttonAll.addSubview(lineAll)
//        buttonIncome.addSubview(lineIncome)
//        buttonOutcome.addSubview(lineOutcome)
//        buttonFuture.addSubview(lineFuture)
    }
    
    func setConstraints() {
        mainStack.setAnchorsEqual(to: self)
        
    }
}
