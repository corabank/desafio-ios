//
//  HomePresenter.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import UIKit

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplay? { get set }
}

class HomePresenter: HomePresenting {
    private let coordinator: HomeCoordinating
    weak var viewController: HomeDisplay?
    
    init(_ coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}
