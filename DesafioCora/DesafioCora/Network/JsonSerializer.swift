//
//  JsonSerializer.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import Foundation

class JsonSerializer{
    
    /// function responsible for parsing the json
    func serealizationJson(completion: (ValidationError?, [OrderListElement]) -> Void) {
        if let path = Bundle.main.path(forResource: "orderList", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do{
                    let result = try JSONDecoder().decode(OrderList.self, from: data)
                    completion(nil, result.orderList)
                }
            }catch{
                let error = ValidationError(titleError: "Atenção", messageError: "Não foi possivel carregar a lista de contatos.")
                completion(error, [])
            }
        }
    }
}
