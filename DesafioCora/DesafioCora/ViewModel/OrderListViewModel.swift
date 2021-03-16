//
//  OrderListViewModel.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import Foundation

final class OrderListViewModel {
    
    let jasonserializer = JsonSerializer()
    var model: [OrderListElement] = []
    
    func getJsonSerializer(completion: (ValidationError?) -> Void){
        jasonserializer.serealizationJson { (error, arrayOrderListJson) in
            if let error = error {
                completion(error)
                return
            }else{
                model = arrayOrderListJson
                completion(nil)
                return
            }
        }
    }
}
