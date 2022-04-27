import UIKit

public class Spacer: UIView {
    public init(size: CGFloat) {
        super.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: size).isActive = true
    }

    required init?(coder: NSCoder) {
        return nil
    }
}
