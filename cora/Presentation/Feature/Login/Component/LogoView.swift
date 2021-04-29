//
//  LogoView.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

class LogoView: UIView {
    private var logo: UIImageView!
    
    func makeView() {
        let image = UIImage(named: "logo-cora")
        logo = UIImageView(image: image)
        logo.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                logo.tintColor = .white
            }
        }
        self.addSubview(logo)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 80.dp),
            logo.heightAnchor.constraint(equalToConstant: 80.dp),
            logo.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor),
            logo.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 80.dp)
        ])
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        makeView()

        if self.superview != nil {
            setConstraints()
        }
    }
}
