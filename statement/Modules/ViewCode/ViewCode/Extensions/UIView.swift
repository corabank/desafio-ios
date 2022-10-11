import UIKit

public extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
              leading: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              trailing: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingRight: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top { topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true }
    }

    func size(height: CGFloat? = nil, width: CGFloat? = nil) {
        if let height = height { heightAnchor.constraint(equalToConstant: height).isActive = true }
        if let width = width { widthAnchor.constraint(equalToConstant: width).isActive = true }
    }

    func setWidthEqual(to reference: UIView, priority: Float = 999) {
        let constraint = self.widthAnchor.constraint(equalTo: reference.widthAnchor)
        constraint.priority = UILayoutPriority(priority)
        constraint.isActive = true
    }

    func setHeightEqual(to reference: UIView, priority: Float = 999) {
        let constraint = self.heightAnchor.constraint(equalTo: reference.heightAnchor)
        constraint.priority = UILayoutPriority(priority)
        constraint.isActive = true
    }

    func centerXYEqual(to reference: UIView) {
        self.centerXEqual(to: reference)
        self.centerYEqual(to: reference)
    }

    func centerXEqual(to reference: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: reference.centerXAnchor).isActive = true
    }

    func centerYEqual(to reference: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: reference.centerYAnchor).isActive = true
    }

    func asContainer(padding: UIEdgeInsets) -> UIView {
        let container = UIView()
        container.addSubview(self)
        self.setAnchors(container, padding)
        return container
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    func setAnchorsEqual(to base: UIView,
                         _ padding: UIEdgeInsets = UIEdgeInsets.zero, safe: Bool = false) {
        safe ? setAnchorsWithSafeArea(base, padding) : setAnchors(base, padding)
    }

    func addSubviews(_ subviews: Array<UIView>) {
        subviews.forEach { self.addSubview($0) }
    }

    private func setAnchorsWithSafeArea(_ base: UIView, _ padding: UIEdgeInsets) {
        self.anchor(top: base.safeAreaLayoutGuide.topAnchor,
                        leading: base.safeAreaLayoutGuide.leadingAnchor,
                        bottom: base.safeAreaLayoutGuide.bottomAnchor,
                        trailing: base.safeAreaLayoutGuide.trailingAnchor,
                        paddingTop: padding.top,
                        paddingBottom: padding.bottom,
                        paddingLeft: padding.left,
                        paddingRight: padding.right)
    }

    private func setAnchors(_ base: UIView, _ padding: UIEdgeInsets) {
        self.anchor(top: base.topAnchor,
                        leading: base.leadingAnchor,
                        bottom: base.bottomAnchor,
                        trailing: base.trailingAnchor,
                        paddingTop: padding.top,
                        paddingBottom: padding.bottom,
                        paddingLeft: padding.left,
                        paddingRight: padding.right)
    }
}
