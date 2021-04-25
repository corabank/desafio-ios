//
//  String+withLocalized.swift
//  cora
//
//  Created by Lucas Silveira on 25/04/21.
//

import UIKit

extension String {
    /// localized
    /// - Returns localized string based on devices language supported by the app
    /// - Important: Only supporting localization for English and Portugues (Brazil)
    var localized: String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
