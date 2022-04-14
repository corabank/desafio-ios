//
//  TransactionColor.swift
//  desafio-cora
//
//  Created by Matheus Perez on 14/04/22.
//

import UIKit

enum TransactionColor {
    case color(typeEntry: TransactionEntry)
    
    func getColor() -> UIColor {
        switch self {
        case .color(let typeEntry):
            switch typeEntry {
            case .input:
                return Colors.blue
            case .output:
                return Colors.offBlack
            }
        }
    }
}
