//
//  ExtractMock.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 26/03/22.
//

import Foundation

class ExtractMock: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        print(self, #function)
        
        guard let client = client, let url = request.url else { return }
        
        let extracts = Bundle.main.decode([DayExtract].self, from: "days.json")
        
        guard let data = (try? JSONEncoder().encode(extracts)) else { return  }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        
        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client.urlProtocol(self, didLoad: data)
        client.urlProtocolDidFinishLoading(self)
        
    }
    
    override func stopLoading() { }
    
}
