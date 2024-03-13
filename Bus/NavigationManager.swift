//
//  NavigationManager.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 13/03/2024.
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    
    @Published var currentPage: String?
    
    private init() {}
    
    func navigateTo(page: String) {
        currentPage = page
    }
    
    func back() {
        currentPage = nil
    }
}
