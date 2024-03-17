//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation
import Core
import Network

protocol ExtractRepositoryProtocol {
    func executeLoad(completionHandler: @escaping ((Result<ExtractList, NetworkError>) -> Void))
}
