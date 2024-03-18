//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import Foundation
import Core

final class DefaultExtractDetailsViewModel: ExtractDetailsViewModelProtocol {
    private let loadDetailsUseCase: LoadExtractDetailsUseCase

    var onFetchSuccess: ((ExtractDetails) -> Void)?
    var onFetchError: ((Error) -> Void)?

    var data: ExtractDetails?
    
    init(loadDetailsUseCase: LoadExtractDetailsUseCase) {
        self.loadDetailsUseCase = loadDetailsUseCase
    }

    func fetchData(withId id: String) {
        loadDetailsUseCase.run(withId: id) { [weak self] result in
            switch result {
            case .success(let success):
                self?.data = success
                self?.onFetchSuccess?(success)
            case .failure(let failure):
                self?.onFetchError?(failure)
            }
        }
    }
}
