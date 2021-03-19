//
//  InfoClientController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientController: BaseViewController {
    
    lazy var infoView = InfoClientView(data)
    
    var indexDetails: IndexPath?
    
    var data: OrderListElement?
    
    convenience init(data: OrderListElement?) {
        self.init()
        self.data = data
        setupNavigation()
        view.backgroundColor = .white
        self.title = "details"
    }
    
    override func loadView() {
        super.loadView()
        view = infoView
    }

}
