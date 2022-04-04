//
//  ExtractViewModel.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 26/03/22.
//

import Foundation

class ExtractViewModel {
    
    var days: [DayExtract] = []
    
    func getExtracts(completion: @escaping () -> ()) {
        if let path = Bundle.main.path(forResource: "days", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let dayExtract = jsonResult["day_extract"] as? [DayExtract] {
                            // do stuff
                  }
              } catch {
                   // handle error
              }
        
        let configuration = URLSessionConfiguration.default

        configuration.protocolClasses = [ExtractMock.self]

        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: URL(fileURLWithPath: path)) { data, response, error in
            
            
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let dayExtract = try JSONDecoder().decode([DayExtract].self, from: data)
                DispatchQueue.main.async {
                    self.days = dayExtract
                }
                completion()
            } catch {
                print(error)
                
            }
            
        }

        task.resume()
        
    }
    }
}
