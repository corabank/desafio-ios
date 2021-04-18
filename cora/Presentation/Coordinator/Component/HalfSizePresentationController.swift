//
//  HalfSizePresentationController.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        presentedView?.layer.cornerRadius = 10
        presentedView?.layer.masksToBounds = true
        return CGRect(
            x: 0,
            y: (containerView!.bounds.height/3.5),
            width: containerView!.bounds.width,
            height: containerView!.bounds.height/1.3
        )
    }
}
