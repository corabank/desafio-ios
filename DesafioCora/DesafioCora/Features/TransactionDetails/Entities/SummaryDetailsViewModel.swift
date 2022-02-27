//
//  SummaryDetailsViewModel.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

struct SummaryDetailsViewModel {
    let totalValue: Double
    let tax: Double
    
    var totalValueText: String {
        return totalValue.currency
    }
    
    var taxValueText: String {
        return tax.currency
    }
    
    var receivedValueText: String {
        return (totalValue - tax).currency
    }
}
