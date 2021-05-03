//
//  Injection.swift
//  cora
//
//  Created by Lucas Silveira on 20/04/21.
//
// The propose of this file is to reproduce as facade pattern to the project

import Swinject

var container = Container()

struct Facade {
    static func injectDataSources() {
        container.register(LoginDataSourceProtocol.self) { _ in LoginDataSource() }
        container.register(OrdersDataSourceProtocol.self) { _ in OrdersDataSource() }
    }
    
    static func injectRepositories() {
        container.register(LoginRepositoryProtocol.self) { resolver in
            let dataSource = resolver.resolve(LoginDataSourceProtocol.self)!
            return LoginRepository(dataSource: dataSource)
        }
        
        container.register(OrdersRepositoryProtocol.self) { resolver in
            let dataSource = resolver.resolve(OrdersDataSourceProtocol.self)!
            return OrdersRepository(dataSource: dataSource)
        }
    }

    static func injectUseCases() {
        container.register(LoginUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(LoginRepositoryProtocol.self)!
            return LoginUseCase(repository: repository)
        }
        
        container.register(OrdersUseCaseProtocol.self) { resolver in
            let repository = resolver.resolve(OrdersRepositoryProtocol.self)!
            return OrdersUseCase(repository: repository)
        }
    }
}
