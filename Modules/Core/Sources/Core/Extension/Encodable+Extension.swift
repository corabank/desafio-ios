//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import Foundation

public extension Encodable {
    /// Converts `self` to dictionary format
    var asDictionary: [String: Any]? {
      guard let data = try? JSONEncoder().encode(self) else { return nil }
      return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
  }
