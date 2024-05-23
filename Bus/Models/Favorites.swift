//
//  Favorites.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import Foundation

class Favorites: ObservableObject {
    @Published var busRoutes = [BusRoute]()
    @Published var saveItems: Set<Int> = []
    
    private var db = Database()
    
    var filterItem: [BusRoute] {
        return busRoutes.filter {
            saveItems.contains($0.id)
        }
    }

    init(){
        self.saveItems = db.load()
        busRoutes = []
    }
    
    func contains(_ busRoute: BusRoute)->Bool{
        saveItems.contains(busRoute.id)
    }
    
    func toggleFavs(busRoute: BusRoute){
        if contains(busRoute){
            saveItems.remove(busRoute.id)
        } else{
            saveItems.insert(busRoute.id)
        }
        db.save(items: saveItems)
        
        objectWillChange.send()
    }
    
}
