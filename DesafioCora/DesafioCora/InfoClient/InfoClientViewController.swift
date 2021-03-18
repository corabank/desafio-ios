//
//  InfoClientViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientViewController: BaseViewController {
    
    var infoView: InfoClientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        self.title = "details"
        let infoClientView = InfoClientView(frame: self.view.frame)
        self.infoView = infoClientView
        view.addSubview(infoClientView)
    }
    
    
}
