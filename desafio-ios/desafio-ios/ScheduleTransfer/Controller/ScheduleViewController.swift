//
//  ScheduleViewController.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 21/03/22.
//

import Foundation
import UIKit

class ScheduleViewController: UIViewController {
    
    private let scheduleView: ScheduleView = {
        let scheduleView = ScheduleView()
        return scheduleView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Detalhes do agendamento"
    }
    
    override func loadView() {
        self.view = scheduleView
    }
}
