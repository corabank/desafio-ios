//
//  DispatchQueueType.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
    func asyncAfter(_ dispatchTime: DispatchTime, work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func asyncAfter(_ dispatchTime: DispatchTime, work: @escaping @convention(block) () -> Void) {
        asyncAfter(deadline: dispatchTime, qos: .unspecified, flags: [], execute: work)
    }
    
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
