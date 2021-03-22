//
//  OrderListViewModel.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import Foundation

final class OrderListViewModel {
    
    // MARK: - Constants
    
    let jasonserializer = JsonSerializer()
    
    // MARK: - Properties
    
    var model: [OrderListElement] = []
    
    // MARK: - Public functions
    
    /// function responsible for making the json decode
    /// - Parameter completion: returns an error and the object
    func getJsonSerializer(completion: (ValidationError?) -> Void) {
        jasonserializer.serealizationJson { (error, arrayOrderListJson) in
            if let error = error {
                completion(error)
            } else {
                model = arrayOrderListJson
            }
        }
    }
}
