//
//  Fonts.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

enum Fonts {
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
