//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

import Core

protocol ExtractViewModelInput: AnyObject {
    func fetchData()
}

protocol ExtractViewModelOutput: AnyObject {
    var onFetchSuccess: ((ExtractList) -> Void)? { get set }
    var onFetchError: ((Error) -> Void)? { get set }
}

protocol ExtractViewModelProtocol: ExtractViewModelInput & ExtractViewModelOutput {
    var listData: ExtractList? { get set }
}
