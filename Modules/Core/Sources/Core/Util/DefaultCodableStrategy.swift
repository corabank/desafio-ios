//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import Foundation

/// Provides a default value for missing `Decodable` data.
///
/// Inspired by: http://marksands.github.io/2019/10/21/better-codable-through-property-wrappers.html
///
/// `DefaultCodableStrategy` provides a generic strategy type that the `DefaultCodable` property wrapper can use to provide a reasonable default value for missing Decodable data.
public protocol DefaultCodableStrategy {
    associatedtype RawValue: Codable

    static var defaultValue: RawValue { get }
}

/// Decodes values with a reasonable default value
///
/// `@Defaultable` attempts to decode a value and falls back to a default type provided by the generic `DefaultCodableStrategy`.
@propertyWrapper
public struct DefaultCodable<Default: DefaultCodableStrategy>: Codable {
    public var wrappedValue: Default.RawValue

    public init(wrappedValue: Default.RawValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(Default.RawValue.self)) ?? Default.defaultValue
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultCodable: Equatable where Default.RawValue: Equatable { }
extension DefaultCodable: Hashable where Default.RawValue: Hashable { }

// MARK: - KeyedDecodingContainer
public extension KeyedDecodingContainer {

    /// Default implementation of decoding a DefaultCodable
    ///
    /// Decodes successfully if key is available if not fallsback to the default value provided.
    func decode<P>(_: DefaultCodable<P>.Type, forKey key: Key) throws -> DefaultCodable<P> {
        if let value = try decodeIfPresent(DefaultCodable<P>.self, forKey: key) {
            return value
        } else {
            return DefaultCodable(wrappedValue: P.defaultValue)
        }
    }
    
    /// Default implementation of decoding a DefaultArraySorted
    ///
    /// Decodes successfully if key is available if not fallsback to the default value provided.
    func decode<P>(_: DefaultArraySorted<P>.Type, forKey key: Key) throws -> DefaultArraySorted<P> {
        if let value = try decodeIfPresent(DefaultArraySorted<P>.self, forKey: key) {
            return value
        } else {
            return DefaultArraySorted(wrappedValue: [])
        }
    }
}

// MARK: - Int Default implementation

public struct DefaultIntStrategy: DefaultCodableStrategy {
    public static var defaultValue: Int { return 0 }
}

public typealias DefaultInt = DefaultCodable<DefaultIntStrategy>

// MARK: Double
public struct DefaultDoubleStrategy: DefaultCodableStrategy {
    public static var defaultValue: Double { return 0.0 }
}

public typealias DefaultDouble = DefaultCodable<DefaultDoubleStrategy>

// MARK: - String Default implementation

public struct DefaultStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}

public typealias DefaultString = DefaultCodable<DefaultStringStrategy>

// MARK: -  Array Default implementation

public struct DefaultEmptyArrayStrategy<T: Codable>: DefaultCodableStrategy {
    public static var defaultValue: [T] { return [] }
}

/// Decodes Arrays returning an empty array instead of nil if appicable
///
/// `@DefaultEmptyArray` decodes Arrays and returns an empty array instead of nil if the Decoder is unable to decode the container.
public typealias DefaultEmptyArray<T> = DefaultCodable<DefaultEmptyArrayStrategy<T>> where T: Codable

// MARK: - Bool Default implementation

public struct DefaultFalseStrategy: DefaultCodableStrategy {
    public static var defaultValue: Bool { return false }
}

/// Decodes Bools defaulting to `false` if applicable
///
/// `@DefaultFalse` decodes Bools and defaults the value to false if the Decoder is unable to decode the value.
public typealias DefaultFalse = DefaultCodable<DefaultFalseStrategy>

@propertyWrapper
public struct DefaultArraySorted<Value: Codable & Comparable>: Codable {
    public var wrappedValue: [Value] {
        didSet {
            if let comparator = comparator {
                wrappedValue.sort(by: comparator)
            }
        }
    }
    
    public typealias Comparator = (Value, Value) -> Bool

    private let comparator: Comparator?
    
    public init(wrappedValue: [Value]) {
        self.wrappedValue = wrappedValue
        self.comparator = { $0 < $1 }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode([Value].self)) ?? [Value]()
        self.comparator = { $0 < $1 }
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultArraySorted: Equatable where Value: Equatable {
    public static func == (lhs: DefaultArraySorted<Value>, rhs: DefaultArraySorted<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}
