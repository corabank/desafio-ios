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
    
    // MARK: Constraints
    
    func fitToParent(with insets: UIEdgeInsets = .zero) {
        guard let parent = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
            parent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom),
            parent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
        ])
    }

    func height(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
        }
    }
