//
//  Controller+withPanGestures.swift
//  cora
//
//  Created by Lucas Silveira on 30/04/21.
//

import UIKit

extension OrdersViewController: UIGestureRecognizerDelegate {
    @objc func wasDragged(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        
        switch recognizer.state {
        case .began, .changed:
            
            let currentPosition = self.lastLocation.y + translation.y
            
            UIView.transition(
                with: view,
                duration: 0.05,
                options: .curveEaseInOut,
                animations: {
                    self.view.transform = CGAffineTransform(
                        translationX: 0,
                        y: currentPosition)
            })
        case .ended:
            lastLocation.y += translation.y
            
            if lastLocation.y <= topLimit {
                UIView.transition(
                    with: view,
                    duration: 0.5,
                    options: .curveEaseInOut,
                    animations: {
                        self.view.transform = CGAffineTransform(translationX: 0,
                                                                y: self.topLimit)
                })
                lastLocation.y = self.topLimit
            }

            if lastLocation.y >= bottomLimit {
                UIView.transition(
                    with: view,
                    duration: 0.5,
                    options: .curveEaseInOut,
                    animations: {
                        self.view.transform = CGAffineTransform(translationX: 0,
                                                                y: 0)
                })
                lastLocation.y = 0
            }
        default: break
        }
    }
}
