//
//  Common.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 14.1.2023.
//

import Foundation

struct Set: Identifiable, Codable {
    let id: UUID
    var name: String
    var reps: Int
    var weight: Double
    var order: Int
    
    init(id: UUID = UUID(), name: String, reps: Int, weight: Double, order: Int) {
        self.id = id
        self.name = name
        self.reps = reps
        self.weight = weight
        self.order = order
    }
    
    init() {
        self.id = UUID()
        self.name = "Set 1"
        self.reps = 0
        self.weight = 0
        self.order = 0
    }
    
    func weightAsString() -> String {
        return String(format: "%g", self.weight)
    }
}

struct Exercise: Identifiable, Codable {
    let id: UUID
    var name: String
    var order: Int
    var isSuperset: Bool
    var sets: [Set]
   
    init(id: UUID = UUID(), name: String, order: Int,  isSuperset: Bool, sets: [Set]) {
        self.id = id
        self.name = name
        self.order = order
        self.isSuperset = isSuperset
        self.sets = sets
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.order = 0
        self.isSuperset = false
        self.sets = [Set.init()]
    }
}

struct Data {
    var title: String = ""
    var date: Date = Date.now
    var exercises: [Exercise] = []
}

