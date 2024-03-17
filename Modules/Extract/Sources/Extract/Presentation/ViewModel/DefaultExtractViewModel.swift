//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 17/03/24.
//

import Foundation

final class DefaultExtractViewModel: ExtractViewModelProtocol {
    private let fetchDataUseCase: LoadExtractsUseCase

    var onFetchSuccess: ((ExtractList) -> Void)?
    var onFetchError: ((Error) -> Void)?

    var listData: ExtractList?
    
    init(fetchDataUseCase: LoadExtractsUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
    }

    func fetchData() {
        fetchDataUseCase.run { [weak self] result in
            switch result {
            case .success(let success):
                self?.listData = success
                self?.onFetchSuccess?(success)
            case .failure(let failure):
                self?.onFetchError?(failure)
            }
        }
    }
}
