//
//  Favorites.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import Foundation

class Favotites: ObservableObject {
    @Published var busRoutes: [Int]
    @Published var showingFavs: Bool = false
    @Published var saveItems: Set<Int> = [1,2]
    
    private var db = Database()

    
    init(){
        busRoutes = []
    }
    
    func contains(_ busRoute: BusRoute)->Bool{
        busRoutes.contains(busRoute.id)
    }
    
    func toggleFavs(busRoute: BusRoute){
        if contains(busRoute){
            saveItems.remove(busRoute.id)
        } else{
            saveItems.insert(busRoute.id)
        }
        db.save(items: saveItems)
    }
    
}
