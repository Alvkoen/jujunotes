//
//  Common.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 14.1.2023.
//

import Foundation

struct Exercise: Identifiable, Codable {
    let id: UUID
    var name: String
    var reps: Int
    var sets: Int
    var weight: Double
    
    init(id: UUID = UUID(), name: String, reps: Int, sets: Int, weight: Double) {
        self.id = id
        self.name = name
        self.reps = reps
        self.sets = sets
        self.weight = weight
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.reps = 0
        self.sets = 0
        self.weight = 0
    }
    
    func weightAsString() -> String {
        return String(format: "%g", self.weight)
    }
}

struct Data {
    var title: String = ""
    var date: Date = Date.now
    var exercises: [Exercise] = []
}

