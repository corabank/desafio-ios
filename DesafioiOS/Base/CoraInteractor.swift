//
//  CoraInteractor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import Foundation

open class CoraInteractor <Presenter> {
    public let presenter: Presenter
    
    public init(presenter: Presenter) {
        self.presenter = presenter
    }
}
