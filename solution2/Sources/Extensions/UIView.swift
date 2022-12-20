import UIKit

extension UIView {
    func border(color: UIColor? = nil, radius: CGFloat = 0) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = color == nil ? 0 : 1
        layer.borderColor = color?.cgColor
        clipsToBounds = false
   }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func getScreenshot() -> UIImage? {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: Constraints
    
    func fitToParent(with insets: UIEdgeInsets = .zero) {
        guard let parent = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ])
    }
    
    func size(_ size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size),
            widthAnchor.constraint(equalToConstant: size)
        ])
    }

    func height(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
