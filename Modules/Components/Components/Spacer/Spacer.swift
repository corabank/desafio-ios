import UIKit

public class Spacer: UIView {
    public init(size: CGFloat, orientation: SpacerOrientation = .height) {
        super.init(frame: .zero)
        
        switch orientation {
        case .height:
            setHeight(size)
        case .width:
            setWidth(size)
        case .square:
            setHeight(size)
            setWidth(size)
        }
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setHeight(_ value: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: value).isActive = true
    }
    
    private func setWidth(_ value: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: value).isActive = true
    }
}

public enum SpacerOrientation { case height, width, square }
