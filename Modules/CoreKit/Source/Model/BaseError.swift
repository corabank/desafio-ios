//
//  BaseError.swift
//  CoraDesafio
//
//  Created by Erik Santos on 15/03/24.
//

import Foundation

public enum BaseError: Error {
    case invalidUrl
    case invalidRequest
    case invalidResponse
    case invalidLoginResponseError
    case convertParameterError
    case invalidStatusCode
    case inputLoginDataError
}
