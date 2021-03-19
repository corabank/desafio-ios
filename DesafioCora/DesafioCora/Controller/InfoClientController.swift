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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = .white
        self.title = "details"
    }
    
    convenience init(data: OrderListElement?) {
        self.init()
        self.data = data
    }
    
    override func loadView() {
        super.loadView()
        view = infoView
    }

}
