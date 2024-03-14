//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import Foundation
import Core
import Network

public protocol LoginRepositoryProtocol {
    func executeLogin(with data: LoginData, completionHandler: @escaping ((Result<TokenRevalidationResponse, NetworkError>) -> Void))
}
