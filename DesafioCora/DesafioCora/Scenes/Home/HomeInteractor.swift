//
//  HomeInteractor.swift
//  DesafioCora
//
//  Created by leonardo on 14/02/22.
//

import Foundation

protocol HomeInteracting: AnyObject { }

class HomeInteractor: HomeInteracting {
    typealias Dependencies = HasAnalytics
    private let presenter: HomePresenting
    private let dependencies: Dependencies
    
    init(_ presenter: HomePresenting, container: Dependencies) {
        self.presenter = presenter
        self.dependencies = container
    }
}
