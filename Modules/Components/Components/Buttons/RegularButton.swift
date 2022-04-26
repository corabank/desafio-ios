import UIKit

public final class RegularButton: UIButton {

    public init() {

        super.init(frame: .zero)
        defaultSetups()
        // setupStyle(shadow)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    public func set(title: String) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.textColor = .black
        self.titleLabel?.textAlignment = .center
    }

    private func defaultSetups() {
        self.layer.cornerRadius = 8
    }

    private func setupStyle(_ shadow: Bool) {
        self.backgroundColor = .white
        if shadow { setupShadow() }
    }

    private func setupShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25)
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
}
