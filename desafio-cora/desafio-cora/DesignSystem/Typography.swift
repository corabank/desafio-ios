//
//  Typography.swift
//  desafio-cora
//
//  Created by Matheus Perez on 06/04/22.
//

import UIKit

enum Typography {
    case bold(size: CGFloat)
    case regular(size: CGFloat)
    case medium(size: CGFloat)
    
    func getFont() -> UIFont {
        switch self {
        case .bold(let size):
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
        case .regular(let size):
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
        case .medium(let size):
            return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
        }
    }
}
