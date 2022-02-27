//
//  TransactionsRequest.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation

struct TransactionsRequest: ServiceRequest {
    var params: [String : Any]? = nil
    var path: String = "/transactions"
}
