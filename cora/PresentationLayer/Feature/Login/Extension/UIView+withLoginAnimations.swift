//
//  UIView+withShake.swift
//  cora
//
//  Created by Lucas Silveira on 28/04/21.
//

import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func animateScroll() {
        let positionY = CAKeyframeAnimation(keyPath: "transform.translation.y")
        positionY.timingFunction = CAMediaTimingFunction(name: .easeIn)
        positionY.duration = 0.3
        positionY.values = [530.dp, 0]
        positionY.isRemovedOnCompletion = false
        positionY.fillMode = .forwards
        layer.add(positionY, forKey: "animateScroll")
    }
    
    func animateOpacity(from start: Double,
                        to end: Double,
                        withDuration duration: TimeInterval,
                        andDelay delay: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.beginTime = CACurrentMediaTime() + delay
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = duration
        animation.values = [start, end]
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        layer.add(animation, forKey: "animateOpacity")
    }
    
    func moveLogo() {
        let positionX = CAKeyframeAnimation(keyPath: "transform.translation.x")
        positionX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        positionX.duration = 0.7
        positionX.values = [-47.0.dp]
        positionX.isRemovedOnCompletion = false
        positionX.fillMode = .forwards
        
        let positionY = CAKeyframeAnimation(keyPath: "transform.translation.y")
        positionY.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        positionY.duration = 0.7
        positionY.values = [-30.0.dp]
        positionY.isRemovedOnCompletion = false
        positionY.fillMode = .forwards
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.duration = 0.7
        scaleAnimation.values = [0.5]
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.fillMode = .forwards
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 0
        fadeOutAnimation.toValue = 1
        fadeOutAnimation.duration = 0.7
        fadeOutAnimation.isRemovedOnCompletion = false
        fadeOutAnimation.fillMode = .forwards
        
        let group = CAAnimationGroup()
        group.duration = 0.7
        group.repeatCount = 1
        group.beginTime = CACurrentMediaTime() + 0.5
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.animations = [positionX, positionY, scaleAnimation, fadeOutAnimation]
        layer.add(group, forKey: "moveLogo")
    }
    
    func moveHeaderTitles() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 400
        animation.toValue = 0
        animation.duration = 0.2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 0.1
        fadeOutAnimation.toValue = 1
        fadeOutAnimation.duration = 0.2
        
        let group = CAAnimationGroup()
        group.duration = 0.2
        group.repeatCount = 1
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.animations = [animation, fadeOutAnimation]
        layer.add(group, forKey: "moveHeaderTitles")
    }
}
