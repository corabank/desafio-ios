//
//  HalfSizePresentationController.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {
    static var y: CGFloat!
    
    override var frameOfPresentedViewInContainerView: CGRect {
        HalfSizePresentationController.y = (containerView!.bounds.height / 3.5)
        
        presentedView?.layer.cornerRadius = 10
        presentedView?.layer.masksToBounds = true
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        presentedView?.addGestureRecognizer(gesture)
        presentedView?.isUserInteractionEnabled = true
        gesture.delegate = self

        return CGRect(
            x: 0,
            y: HalfSizePresentationController.y,
            width: containerView!.bounds.width,
            height: containerView!.bounds.height/1.3
        )
    }
}

extension HalfSizePresentationController: UIGestureRecognizerDelegate {
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began
            || gestureRecognizer.state == UIGestureRecognizer.State.changed {

            let translation = gestureRecognizer.translation(in: self.presentedView)
            
            if gestureRecognizer.view!.center.y < 555 {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x,
                                                         y: gestureRecognizer.view!.center.y + translation.y)
            } else {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
            }
            
            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.presentedView)
        }
    }
}
