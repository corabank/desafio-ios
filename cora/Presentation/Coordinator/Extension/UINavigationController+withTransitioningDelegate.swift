//
//  UINavigationController+withTransitionDelegate.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

extension UINavigationController : UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController) -> UIPresentationController? {
            return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
