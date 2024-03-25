//
//  Dynamic.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

public typealias GenericCompletion<T> = ((T) -> Void)

public final class Dynamic<T> {
    
    public var value: T {
        didSet {
            completion?(value)
        }
    }
    
    private var completion: GenericCompletion<T>?
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func bind(_ completion: @escaping GenericCompletion<T>) {
        completion(value)
        self.completion = completion
    }
}
