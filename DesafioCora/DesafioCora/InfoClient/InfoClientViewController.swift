//
//  InfoClientViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientViewController: BaseViewController {
    
    lazy var infoView = InfoClientView(data)
    
    var indexDetails: IndexPath?
    
    let value: String? = ""
    let name: String = ""
    let mail: String? = ""
   //let data: String? = ""
    let status: String? = ""
    let taxes: String? = ""
    
    var data: OrderListElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupNavigation()
       // setupViews()
    }
    
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
    
//    func setupViews() {
//        view.backgroundColor = .white
//        self.title = "details"
//        let infoClientView = InfoClientView(frame: self.view.frame)
//        self.infoView = infoClientView
//        view.addSubview(infoView)
//    }
}
