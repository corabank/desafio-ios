//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import Foundation
import Core

protocol ExtractDetailsViewModelInput: AnyObject {
    func fetchData(withId id: String)
}

protocol ExtractDetailsViewModelOutput: AnyObject {
    var onFetchSuccess: ((ExtractDetails) -> Void)? { get set }
    var onFetchError: ((Error) -> Void)? { get set }
}

protocol ExtractDetailsViewModelProtocol: ExtractDetailsViewModelInput & ExtractDetailsViewModelOutput {
    var data: ExtractDetails? { get set }
}
