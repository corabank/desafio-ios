//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import UIKit
import Core
import Network

public protocol ExtractCoordinator {
    var container: DIContainerService { get set }
    var navigationController: UINavigationController? { get set }
    
    func openExtractScreen()
    func openExtractDetails(withId id: String)
}

//MARK: - implementation

public class ExtractNavigator: ExtractCoordinator {
    public var container: DIContainerService
    public var navigationController: UINavigationController?
    
    public init(container: DIContainerService,
                navigationController: UINavigationController? = nil) {
        self.container = container
        self.navigationController = navigationController
        registerDependencies()
    }
    
    private func registerDependencies() {
        registerRepositories()
        registerUseCases()
        registerViewModels()
        
        container.register(type: PresentableExtractView.self) { container in
            ExtractViewController(
                navigationService: container.resolve(type: ExtractCoordinator.self)!,
                viewModel: container.resolve(type: ExtractViewModelProtocol.self)!
            )
        }
    }
    
    private func registerRepositories() {
        container.register(type: ExtractRepositoryProtocol.self) { container in
            DefaultExtractRepository(networkService: container.resolve(type: NetworkServiceProtocol.self)!)
        }
    }
    
    private func registerUseCases() {
        container.register(type: LoadExtractsUseCase.self) { container in
            DefaultLoadExtractsUseCase(repository: container.resolve(type: ExtractRepositoryProtocol.self)!)
        }
        
        container.register(type: LoadExtractDetailsUseCase.self) { container in
            DefaultLoadExtractDetailsUseCase(repository: container.resolve(type: ExtractRepositoryProtocol.self)!)
        }
    }
    
    private func registerViewModels() {
        container.register(type: ExtractViewModelProtocol.self) { container in
            DefaultExtractViewModel(fetchDataUseCase: container.resolve(type: LoadExtractsUseCase.self)!)
        }
        
        container.register(type: ExtractDetailsViewModelProtocol.self) { container in
            DefaultExtractDetailsViewModel(loadDetailsUseCase: container.resolve(type: LoadExtractDetailsUseCase.self)!)
        }
    }
    
    public func openExtractScreen() {
        let viewController = container.resolve(type: PresentableExtractView.self)!
        navigationController?.pushViewController(viewController.toPresent(), animated: true)
    }
    
    public func openExtractDetails(withId id: String) {
        let viewController = ExtractDetailsViewController(
            navigationService: container.resolve(type: ExtractCoordinator.self)!,
            viewModel: container.resolve(type: ExtractDetailsViewModelProtocol.self)!,
            detailsId: id
        )
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
