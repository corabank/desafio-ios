//
//  CoraJsonManager.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import Foundation

protocol CoraJsonManagerProtocol: AnyObject {
    func setFileName(_ fileName: String)
    func getData() -> Data?
}

internal final class CoraJsonManager: CoraJsonManagerProtocol {
    
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func setFileName(_ fileName: String) {
        self.fileName = fileName
    }
    
    func getData() -> Data? {
        let jsonFile = getSampleBundle().path(forResource: fileName, ofType: "json") ?? String()
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: .mappedIfSafe)
        return jsonData ?? Data()
    }
    
    func getSampleBundle() -> Bundle {
        return Bundle.resourceBundle(for: CoraJsonManager.self, resource: "DesafioiOS")
    }
}

public extension Bundle {
    ///  Get the resources bundle with an class and the resource name
    class func resourceBundle(for sdkClass: AnyClass, resource: String) -> Bundle {
        if  let bundleURL = Bundle(for: sdkClass).url(forResource: resource, withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL) {
            return bundle
        }
        if let bundle = Bundle(identifier: "allana.castenharo.DesafioiOS.\(resource)") {
            return bundle
        }
        return Bundle.main
    }
}

