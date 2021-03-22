//
//  InfoClientController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientController: BaseViewController {
    
    // MARK: - Properties
    
    lazy var infoView = InfoClientView(data)
    
    var indexDetails: IndexPath?
    
    var data: OrderListElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.backgroundColor = .white
        self.title = "details"
    }
    
    // MARK: -  Initializers
    
    convenience init(data: OrderListElement?) {
        self.init()
        self.data = data
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = infoView
    }
    
}
