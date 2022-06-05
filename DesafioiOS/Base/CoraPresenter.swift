//
//  CoraPresenter.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import UIKit

open class CoraPresenter <Coordinator> {
    public let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}
