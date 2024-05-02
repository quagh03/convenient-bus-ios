//
//  NetworkMonitor.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 23/04/2024.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = true
    
    var networkChangePublisher: AnyPublisher<Bool, Never> {
        return $isConnected.eraseToAnyPublisher()
    }
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
