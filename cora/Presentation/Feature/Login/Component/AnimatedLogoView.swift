//
//  AnimatedLogoView.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

class AnimatedLogoView: UIView {
    private var logo: UIImageView!
    
    // Logo Constraints
    private var logoWidthConstraint: NSLayoutConstraint!
    private var logoHeightConstraint: NSLayoutConstraint!
    private var logoCenterXConstraint: NSLayoutConstraint!
    private var logoTopConstraint: NSLayoutConstraint!
    private var logoLeftConstraint: NSLayoutConstraint!
    private var logoRightConstraint: NSLayoutConstraint!
    
    func makeView() {
        let image = UIImage(named: "logo-cora")
        logo = UIImageView(image: image)
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logo)
    }
    
    func setConstraints() {
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 80.dp)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 80.dp)
        logoCenterXConstraint = logo.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor)
        logoTopConstraint = logo.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 80.dp)
        
        NSLayoutConstraint.activate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoCenterXConstraint,
            logoTopConstraint
        ])
    }
    
    func updateConstraintsToAnimate() {
        NSLayoutConstraint.deactivate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoCenterXConstraint,
            logoTopConstraint
        ])
        
        logoTopConstraint = logo.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 10.dp)
        logoLeftConstraint = logo.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: 10.dp)
        logoWidthConstraint = logo.widthAnchor.constraint(equalToConstant: 40.dp)
        logoHeightConstraint = logo.heightAnchor.constraint(equalToConstant: 40.dp)
        
        NSLayoutConstraint.activate([
            logoWidthConstraint,
            logoHeightConstraint,
            logoTopConstraint,
            logoLeftConstraint
        ])
    }
    
    func animate() {
        self.updateConstraintsToAnimate()
        UIView.transition(
            with: self.logo,
            duration: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.layoutIfNeeded()
            }
        )
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeView()

        if self.superview != nil {
            setConstraints()
        }
    }
}
