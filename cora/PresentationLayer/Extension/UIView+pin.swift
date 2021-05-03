//
//  UIView+pin.swift
//  cora
//
//  Created by Lucas Silveira on 17/04/21.
//

import UIKit

extension UIView {
    /// Applies to the element the same size of the view passed as parameter
    /// - Parameter superview: UIView
    func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
