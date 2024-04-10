//
//  Database.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import Foundation

final class Database{
    private let FAV_KEY = "fav_key"
    func save(items: Set<Int>){
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    func load() -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
        return Set(array)
    }
}
