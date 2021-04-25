//
//  String+withLocalized.swift
//  cora
//
//  Created by Lucas Silveira on 25/04/21.
//

import UIKit


extension String {
    var localized: String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
