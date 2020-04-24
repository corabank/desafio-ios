//
//  OrderRepository.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import RogueKit

public enum OrderRepository: RKRepository {
    
    case fetchOrderList,
    fetchOrder(orderID: String)
    
    public var domain: String { return "https://yourserver.domain.com" }
    
    public func createRequest() throws -> RKRequest {
        switch self {
        case .fetchOrderList:
            return RKRequest.post("/fetchOrderList")
        case let .fetchOrder(orderID):
            return RKRequest.post("/fetchOrder/\(orderID)")
        }
    }
    
    public func createMockForRequest<T>(completion: @escaping(ResultCallback<T>)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch self {
            case .fetchOrderList:
                if let orderList = self.generateMockedOrderList() as? T {
                    completion(.success(orderList))
                } else {
                    completion(.failure(RKError(.invalidData)))
                }
            case .fetchOrder(_):
                if let order = self.generateMockedOrder() as? T {
                    completion(.success(order))
                } else {
                    completion(.failure(RKError(.invalidData)))
                }
            }
        }
    }
    
    private func generateMockedOrderList() -> OrderListEntity {
        var mock = OrderListEntity()
        mock.orderCount = 320
        mock.orderTotalValue = 115345.45
        mock.orderList = []
        
        for _ in 0...29 {
            mock.orderList?.append(generateMockedOrder())
        }
        
        return mock
    }
    
    private func generateMockedOrder() -> OrderEntity {
        var mock = OrderEntity()
        
        mock.id = "abcdef123"
        mock.value = Double.random(in: 1.5 ... 500)
        mock.email = "cajuca@moip.com.br"
        mock.date = generateRandomDate()
        
        let order: Int = Int.random(in: 0 ... 2)
        switch order {
        case 0:
            mock.status = .paid
        case 1:
            mock.status = .waiting
        default:
            mock.status = .notpaid
        }
        
        mock.paymentMethod = .credit
        mock.buyerName = "Caju Cacau"
        mock.taxes = 4.99
        mock.sandbox = "b463456nsd-3454353 345345 345345-345345 fiogsdgbjk3h45j6343"
        
        return mock
        
    }
    
    private func generateRandomDate() -> Date {
        
        var month = Int.random(in: 0...10)
        month = month < 7 ? 0 : ((month - 7) * -1)
            
        let day = Int.random(in: 0...30) * -1
        let hour = Int.random(in: 0...23) * -1
        let minute = Int.random(in: 0...59) * -1
        
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.month = month
        offsetComponents.day = day
        offsetComponents.hour = hour
        offsetComponents.minute = minute
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: Date(), options: .init(rawValue: 0) )
        return randomDate ?? Date()
    }
}
