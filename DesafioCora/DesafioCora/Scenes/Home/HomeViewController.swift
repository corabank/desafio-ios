//
//  HomeViewController.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import UIKit

protocol HomeDisplay: AnyObject { }

class HomeViewController: UIViewController {
    
    private let interactor: HomeInteracting
    
    init(_ interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet!")
    }
}

extension HomeViewController: HomeDisplay { }
